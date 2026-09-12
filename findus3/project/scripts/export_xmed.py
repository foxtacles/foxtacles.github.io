#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-3.0-only
"""Decode this disc's five Paige/Director XMED rich-text documents.

Wire-format field order corroborated against DirPlayer's GPL-3.0 parser:
https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/vm-rust/src/director/chunks/xmedia_styled_text.rs

Preserves original section bytes, expanded Packer values/pointers and offsets,
and exports text, fonts, character/paragraph runs, and all observed styles.
This is a data decoder, not a text renderer or a reachability analysis.
"""
import argparse
import hashlib
import json
import re
from pathlib import Path


def sha(data):
    return hashlib.sha256(data).hexdigest()


def unpack(data):
    """Expand Paige numeric repeats and length-delimited pointer blocks strictly."""
    pos, last, values, tokens = 0, 0, [], []
    while pos < len(data):
        start, control = pos, data[pos]
        pos += 1
        if control == 3 and pos == len(data):
            tokens.append({"offset": start, "bytes": 1, "kind": "end"})
            break
        if control == 0:
            match = re.match(rb"([0-9a-fA-F]+),", data[pos:])
            assert match, f"Invalid pointer length at {start}"
            size = int(match[1], 16)
            pos += len(match[0])
            assert pos+size <= len(data)
            block = data[pos:pos+size]
            pos += size
            value = {"pointer_bytes_hex": block.hex(), "size": size}
            values.append(value)
            tokens.append({"offset": start, "bytes": pos-start, "kind": "pointer", "value": value})
        elif control & 128:
            repetitions = 1
            if control & 64:
                assert pos < len(data)
                repetitions = data[pos]
                pos += 1
            assert repetitions > 0
            values.extend([last]*repetitions)
            tokens.append({"offset": start, "bytes": pos-start, "kind": "repeat", "control": control,
                           "value": last, "count": repetitions})
        else:
            assert control in (1, 2), f"Unknown numeric control {control:#x} at {start}"
            match = re.match(rb"-?[0-9a-fA-F]+", data[pos:])
            assert match, f"Invalid number at {start}"
            pos += len(match[0])
            last = int(match[0], 16)
            if control == 1:
                last &= 65535
            values.append(last)
            tokens.append({"offset": start, "bytes": pos-start, "kind": "number", "control": control,
                           "value": last, "ascii_hex": match[0].decode()})
    assert pos == len(data)
    assert sum(t["bytes"] for t in tokens) == len(data)
    return values, tokens


def read_sections(raw):
    assert raw.startswith(b"FFFF")
    sections, offset = [], 0
    while offset < len(raw):
        header = raw[offset:offset+20]
        assert re.fullmatch(rb"[0-9A-Fa-f]{20}", header), f"Invalid section header at {offset}"
        key, length, kind, count = (int(header[a:b], 16) for a, b in ((0, 4), (4, 12), (12, 16), (16, 20)))
        data = raw[offset+20:offset+20+length]
        assert len(data) == length
        values, tokens = unpack(data)
        sections.append({"key": f"0x{key:04x}", "offset": offset, "data_offset": offset+20,
                         "length": length, "type": kind, "declared_count": count,
                         "raw_hex": data.hex(), "values": values, "tokens": tokens})
        offset += 20+length
    assert offset == len(raw)
    return sections


def font_name(pointer):
    data = bytes.fromhex(pointer["pointer_bytes_hex"])
    assert data and data[0] < len(data)
    return data[1:1+data[0]].decode("mac_roman")


def fonts(section):
    values, result, i = section["values"], [], 0
    while i < len(values):
        first, alternate = values[i:i+2]
        assert isinstance(first, dict) and isinstance(alternate, dict)
        props = values[i+2:i+19]
        assert len(props) == 17 and all(isinstance(v, int) for v in props)
        result.append({"index": len(result), "name": font_name(first), "alternate_name": font_name(alternate),
                       "properties_raw": props, "font_style_raw": props[0], "font_size_raw": props[1],
                       "kerning_raw": props[3], "anti_alias_raw": props[4],
                       "name_bytes": first, "alternate_name_bytes": alternate})
        i += 19
    assert len(result) == section["declared_count"]
    return result


def styles(section, font_table):
    values = section["values"]
    first = values[0]
    records = values[1:]
    assert len(records) % 77 == 0, "Unexpected style record length for document version 0x40001"
    result = []
    for off in range(0, len(records), 77):
        v = records[off:off+77]
        assert all(isinstance(x, int) for x in v)
        assert 0 <= v[0] < len(font_table)
        result.append({"index": len(result), "font_index": v[0], "font_name": font_table[v[0]]["name"],
                       "style_number_raw": v[3], "word_wrap_mode_raw": v[4],
                       "font_size_points": v[18]/65536,
                       "foreground_rgb": [(x >> 8) & 255 for x in v[9:12]],
                       "background_rgb": [(x >> 8) & 255 for x in v[13:16]],
                       "kerning": v[23]/65536, "character_spacing": v[24]/65536,
                       "bold": bool(v[39]), "italic": bool(v[40]), "underline": bool(v[41]),
                       "style_flags_raw": v[39:71], "raw_values": v})
    assert len(result) == section["declared_count"]
    # For all five files, the prefix is the final valid zero-based style index.
    # Preserve that observation rather than adopting an upstream count heuristic
    # which would incorrectly discard the sole style when this prefix is zero.
    assert first == len(result)-1
    return result, first


def paragraphs(section):
    values = section["values"]
    assert len(values) % 54 == 0
    result = []
    for off in range(0, len(values), 54):
        v = values[off:off+54]
        assert v[29] == 0, "Paragraph tab table not implemented"
        result.append({"index": len(result), "justification_raw": v[0],
                       "alignment": {0: "left", 1: "center", 2: "right", 3: "justify"}.get(v[0], "unknown"),
                       "line_height": v[1], "left_indent": v[3], "right_indent": v[4], "first_indent": v[5],
                       "line_spacing": v[8], "top_spacing": v[33], "bottom_spacing": v[34],
                       "raw_values": v})
    assert len(result) == section["declared_count"]
    return result


def runs(section, index_field):
    v = section["values"]
    assert len(v) % 2 == 0 and all(isinstance(x, int) for x in v)
    result = [{"position": v[i], index_field: v[i+1]} for i in range(0, len(v), 2)]
    assert len(result) == section["declared_count"]
    return result


def decode(raw):
    sections = read_sections(raw)
    by_key = {int(s["key"], 16): s for s in sections}
    document = by_key[0]["values"]
    assert len(document) == 44 and document[0] == 0x40001
    text_blocks = []
    for s in sections:
        if s["key"] == "0x0002":
            assert len(s["values"]) == 1 and isinstance(s["values"][0], dict)
            text_blocks.append(bytes.fromhex(s["values"][0]["pointer_bytes_hex"]))
    text_bytes = b"".join(text_blocks)
    # All text/font strings on this disc are ASCII, so platform code pages agree.
    text = text_bytes.decode("ascii")
    font_table = fonts(by_key[8])
    style_table, style_prefix = styles(by_key[6], font_table)
    par_table = paragraphs(by_key[7])
    style_runs = runs(by_key[4], "style_index")
    par_runs = runs(by_key[5], "paragraph_index")
    spans = []
    for i, run in enumerate(style_runs):
        assert run["style_index"] < len(style_table)
        start = min(run["position"], len(text))
        end = min(style_runs[i+1]["position"] if i+1 < len(style_runs) else len(text), len(text))
        if start < end:
            spans.append({"start": start, "end": end, "text": text[start:end], "style_index": run["style_index"]})
    assert "".join(x["text"] for x in spans) == text
    for run in par_runs:
        assert run["paragraph_index"] < len(par_table)
    return {"text": text, "text_encoding": "ASCII (identical under MacRoman and Windows-1252)",
            "text_bytes_hex": text_bytes.hex(), "text_length_bytes": len(text_bytes),
            "document_version": document[0], "document_version_hex": hex(document[0]),
            "document_background_rgb": [(x >> 8)&255 for x in document[30:33]],
            "fonts": font_table, "styles": style_table, "style_index_prefix": style_prefix,
            "style_runs": style_runs, "paragraph_runs": par_runs, "paragraphs": par_table, "styled_spans": spans,
            "sections": sections, "section_count": len(sections), "all_source_bytes_consumed": True,
            "limitations": ["Unknown Paige housekeeping fields retain expanded values and raw bytes without invented meanings.",
                            "Run positions beyond text end are preserved; portable spans are clipped to the text length.",
                            "This data recovery does not prove runtime layout or script/score reachability."]}


def identity(folder, asset):
    keyfile = next((folder / "chunks").glob("KEY_*.json"))
    keys = json.loads(keyfile.read_text())["entries"]
    owners = [r["castID"] for r in keys if r["fourCC"] == "XMED" and r["sectionID"] == asset]
    result = {"cast_chunk_ids": owners}
    members = []
    index = Path("artifacts/analysis/movies") / (folder.name+".json")
    if index.exists():
        movie = json.loads(index.read_text())
        for member in movie.get("members", []):
            if member.get("chunk_id") in owners:
                members.append({"cast_number": member.get("cast_number"), "cast_name": member.get("cast_name"),
                                "member_number": member.get("member"), "name": member.get("name"),
                                "cast_chunk": member.get("chunk_id")})
    if members:
        result["members"] = members
    return result


def main(source, output):
    output.mkdir(parents=True, exist_ok=True)
    rows = []
    for path in sorted(source.glob("*/chunks/XMED-*.bin")):
        raw = path.read_bytes()
        movie, asset = path.parent.parent.name, int(path.stem.split("-")[-1])
        row = {"movie": movie, "asset_chunk": asset, "source": str(path), "source_size": len(raw),
               "source_sha256": sha(raw), **identity(path.parent.parent, asset)}
        try:
            doc = {**row, **decode(raw)}
            dest = output / movie / path.stem
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.with_suffix(".json").write_text(json.dumps(doc, indent=2, ensure_ascii=False)+"\n")
            # UTF-8 text retains original CR characters; no line-ending normalization.
            dest.with_suffix(".txt").write_bytes(doc["text"].encode("utf-8"))
            row.update({"status": "decoded", "text": doc["text"], "styles": len(doc["styles"]),
                        "fonts": [x["name"] for x in doc["fonts"]], "json": str(dest.with_suffix(".json")),
                        "text_file": str(dest.with_suffix(".txt")), "section_count": doc["section_count"]})
        except Exception as error:
            row.update({"status": "failed", "error": f"{type(error).__name__}: {error}"})
        rows.append(row)
    summary = {"documents": len(rows), "decoded": sum(r["status"] == "decoded" for r in rows),
               "failures": sum(r["status"] == "failed" for r in rows), "documents_detail": rows}
    (output / "manifest.json").write_text(json.dumps(summary, indent=2, ensure_ascii=False)+"\n")
    print(json.dumps(summary, indent=2, ensure_ascii=False))
    assert not summary["failures"], "XMED recovery incomplete; inspect manifest"


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=Path("artifacts/decompiled"))
    parser.add_argument("--output", type=Path, default=Path("artifacts/analysis/xmed"))
    args = parser.parse_args()
    main(args.source, args.output)
