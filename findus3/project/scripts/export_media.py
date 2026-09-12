#!/usr/bin/env python3
"""Export Director 7 BITD and MoaSoundFormat media from ProjectorRays chunks.

Pixel/PCM encoding is verified against ScummVM's Director BITDDecoder and
MoaSoundFormatDecoder. Requires Pillow. No original runtime is executed.
PNG preserves palette indices; transparency/ink and timeline palette changes
remain runtime concerns and are deliberately not baked into these assets.
"""
import argparse
import collections
import hashlib
import json
import re
import struct
import wave
from pathlib import Path

from PIL import Image, ImageDraw, PngImagePlugin


def sha(data):
    return hashlib.sha256(data).hexdigest()


def legacy(s):
    try:
        return s.encode("latin1").decode("mac_roman")
    except UnicodeEncodeError:
        return s


def read_json(path):
    return json.loads(path.read_text())


def chunk_id(path):
    return int(path.stem.split("-")[-1])


def safe(s):
    return re.sub(r"[^\w. -]", "_", s)[:75].rstrip(". ") or "unnamed"


def builtin_palettes(path):
    # Read the upstream tables from the pinned research checkout; do not
    # duplicate GPL table source in this project script.
    text = path.read_text()
    result = {}
    for name in ("macPalette", "winD5Palette", "grayscale4Palette"):
        body = re.search(r"\b"+name+r"\[\d+\]\s*=\s*\{(.*?)\};", text, re.S).group(1)
        body = re.sub(r"//[^\n]*", "", body)
        result[name] = bytes(int(x, 16) for x in re.findall(r"0x([0-9a-fA-F]+)", body))
    return result


def movie_context(folder):
    chunks = folder / "chunks"
    keyfile = next(chunks.glob("KEY_*.json"), None)
    if not keyfile:
        return None
    keys = read_json(keyfile)["entries"]
    lists = next(chunks.glob("MCsL*.json"), None)
    libs = read_json(lists)["entries"] if lists else [
        {"name": "Internal", "filePath": "", "id": 1024, "minMember": 1}]
    members = {}
    for li, lib in enumerate(libs, 1):
        if lib["filePath"]:
            continue
        cast = next((x for x in keys if x["castID"] == lib["id"] and x["fourCC"] == "CAS*"), None)
        if cast is None:
            continue
        ids = read_json(chunks / f"CAS_-{cast['sectionID']}.json")["memberIDs"]
        for slot, cid in enumerate(ids, lib["minMember"]):
            if cid:
                members[cid] = {"cast_library_index": li, "cast_library_name": legacy(lib["name"]),
                                "cast_library_resource_id": lib["id"], "member_number": slot,
                                "cast_table_chunk": cast["sectionID"]}
    children = collections.defaultdict(dict)
    for item in keys:
        children[item["castID"]][item["fourCC"]] = item["sectionID"]
    palettes = []
    for p in chunks.glob("CASt-*.json"):
        meta = read_json(p)
        cid = chunk_id(p)
        if meta["type"] != 4 or "CLUT" not in children[cid]:
            continue
        asset = children[cid]["CLUT"]
        raw = (chunks / f"CLUT-{asset}.bin").read_bytes()
        assert len(raw) % 6 == 0
        palette = raw[::2]
        palettes.append({"cast_chunk": cid, "asset_chunk": asset, "palette": palette,
                         "colors": len(raw)//6, "name": legacy((meta.get("info") or {}).get("name", "")),
                         **members.get(cid, {})})
    return {"folder": folder, "chunks": chunks, "members": members, "children": children,
            "palettes": palettes, "libraries": libs}


def unpack_bitd(raw, wanted):
    if len(raw) == wanted:
        return raw, "uncompressed"
    out = bytearray()
    pos = 0
    while pos < len(raw):
        control = raw[pos]
        pos += 1
        if control & 128:
            assert pos < len(raw), "Truncated run"
            out.extend(bytes([raw[pos]])*(257-control))
            pos += 1
        else:
            n = control+1
            assert pos+n <= len(raw), "Truncated literal"
            out.extend(raw[pos:pos+n])
            pos += n
        assert len(out) <= wanted, "RLE output exceeds geometry"
    assert len(out) == wanted, f"RLE output {len(out)} != expected {wanted}"
    return bytes(out), "Director RLE"


def choose_palette(ctx, identity, bpp, lib, member, builtins):
    if bpp == 1:
        return bytes([255, 255, 255]+[0, 0, 0]*255), {"status": "exact", "kind": "monochrome"}
    if bpp == 2:
        return builtins["grayscale4Palette"], {"status": "exact", "kind": "Director 2-bit grayscale"}
    if member <= 0:
        name = {-101: "winD5Palette", 0: "macPalette"}.get(member)
        assert name, f"Unsupported built-in palette {member}"
        return builtins[name], {"status": "exact", "kind": name, "stored_member": member}
    matches = [p for p in ctx["palettes"] if p.get("member_number") == member]
    if lib == -1:
        own = [p for p in matches if p.get("cast_library_index") == identity.get("cast_library_index")]
        if own:
            matches = own
    elif lib > 0:
        matches = [p for p in matches if p.get("cast_library_index") == lib]
    if len(matches) == 1:
        p = matches[0]
        status = "exact" if lib != 0 else "inferred_unique_movie_palette"
        return p["palette"], {"status": status, "kind": "cast palette", "cast_chunk": p["cast_chunk"],
                              "asset_chunk": p["asset_chunk"], "name": p["name"],
                              "stored_cast_library": lib, "stored_member": member}
    return builtins["macPalette"], {"status": "requires_host_movie_palette", "kind": "Mac system preview fallback",
                                    "stored_cast_library": lib, "stored_member": member,
                                    "note": "Indices preserved; final colors require the host movie's palette context."}


def bitmap(ctx, cid, meta, row, builtins):
    rawmeta = (ctx["chunks"] / f"CASt-{cid}.bin").read_bytes()
    specific = rawmeta[12+meta["infoLen"]:12+meta["infoLen"]+meta["specificDataLen"]]
    pitchflags, top, left, bottom, right = struct.unpack_from(">H4h", specific)
    pitch = pitchflags & 0x3fff
    width, height = right-left, bottom-top
    bpp = specific[23] if pitchflags & 0x8000 else 1
    clib, cpal = struct.unpack_from(">hh", specific, 24) if bpp > 1 else (-1, 0)
    reg_y, reg_x = struct.unpack_from(">hh", specific, 18)
    row.update({"width": width, "height": height, "row_bytes": pitch, "bits_per_pixel": bpp,
                "initial_rect": {"top": top, "left": left, "bottom": bottom, "right": right},
                "registration_canvas": {"x": reg_x, "y": reg_y},
                "registration_image": {"x": reg_x-left, "y": reg_y-top},
                "update_flags": specific[22], "alpha_threshold": specific[10],
                "source_palette": {"cast_library": clib, "member": cpal}})
    asset = ctx["children"][cid].get("BITD")
    if width == 0 and height == 0 and asset is None:
        row.update({"status": "empty_bitmap", "note": "Zero-size cast bitmap, no BITD child in source."})
        return None
    assert width > 0 and height > 0 and asset is not None, "Bitmap geometry/asset missing"
    source = ctx["chunks"] / f"BITD-{asset}.bin"
    raw = source.read_bytes()
    pixels, encoding = unpack_bitd(raw, pitch*height)
    row.update({"asset_chunk": asset, "source": str(source), "source_sha256": sha(raw), "encoding": encoding,
                "decoded_storage_sha256": sha(pixels)})
    if bpp <= 8:
        indices = bytearray(width*height)
        for y in range(height):
            for x in range(width):
                if bpp == 8:
                    value = pixels[y*pitch+x]
                elif bpp == 1:
                    value = 255 if (pixels[y*pitch+x//8] >> (7-x%8)) & 1 else 0
                elif bpp == 2:
                    value = (pixels[y*pitch+x//4] >> (6-2*(x%4))) & 3
                else:
                    raise ValueError(f"Unsupported bit depth {bpp}")
                indices[y*width+x] = value
        palette, palette_info = choose_palette(ctx, row, bpp, clib, cpal, builtins)
        assert max(indices, default=0)*3+3 <= len(palette)
        row["palette"] = palette_info
        im = Image.frombytes("P", (width, height), bytes(indices))
        im.putpalette(palette+bytes(768-len(palette)))
    elif bpp in (16, 32):
        rgb = bytearray(width*height*3)
        alpha_values = set()
        for y in range(height):
            for x in range(width):
                if bpp == 16:
                    if encoding == "uncompressed":
                        value = int.from_bytes(pixels[y*pitch+x*2:y*pitch+x*2+2], "big")
                    else:
                        value = pixels[y*pitch+x]*256+pixels[y*pitch+width+x]
                    channels = [(value >> shift) & 31 for shift in (10, 5, 0)]
                    channels = [(c << 3) | (c >> 2) for c in channels]
                else:
                    if encoding == "uncompressed":
                        alpha = pixels[y*pitch+x*4]
                        channels = pixels[y*pitch+x*4+1:y*pitch+x*4+4]
                    else:
                        alpha = pixels[y*pitch+x]
                        channels = [pixels[y*pitch+width*k+x] for k in (1, 2, 3)]
                    alpha_values.add(alpha)
                pos = (y*width+x)*3
                rgb[pos:pos+3] = bytes(channels)
        row["palette"] = {"status": "exact", "kind": "RGB555" if bpp == 16 else "RGB888 planar"}
        if bpp == 32:
            row["stored_alpha_values"] = sorted(alpha_values)
            row["alpha_note"] = "RGB exported opaque, as Director BITD decoding does; original first plane retained in source."
        im = Image.frombytes("RGB", (width, height), bytes(rgb))
    else:
        raise ValueError(f"Unsupported bit depth {bpp}")
    row["pixel_sha256"] = sha(im.tobytes())
    row["png_mode"] = im.mode
    row["status"] = "exported"
    return im


def sound(ctx, cid, row, target):
    children = ctx["children"][cid]
    hid, sid = children["sndH"], children["sndS"]
    header = (ctx["chunks"] / f"sndH-{hid}.bin").read_bytes()
    samplefile = ctx["chunks"] / f"sndS-{sid}.bin"
    raw = samplefile.read_bytes()
    fields = ("offset", "size", "playback_start", "playback_start_frame", "loop_start", "loop_start_frame",
              "loop_end", "loop_end_frame", "playback_end", "playback_end_frame", "frames", "sample_rate", "byte_rate")
    fmt = dict(zip(fields, struct.unpack_from(">13I", header)))
    fmt.update(dict(zip(("bits_per_sample", "bytes_per_sample", "channels", "bytes_per_frame"),
                        struct.unpack_from(">4I", header, 68))))
    fmt["compression_guid"] = header[52:68].hex()
    fmt["sound_header_guid"] = header[84:100].hex()
    assert fmt["compression_guid"] == "0"*32, "Compressed samples not supported"
    assert fmt["bits_per_sample"] in (8, 16) and fmt["channels"] in (1, 2)
    assert fmt["bytes_per_frame"] == fmt["channels"]*fmt["bytes_per_sample"]
    assert len(raw) == fmt["size"] == fmt["frames"]*fmt["bytes_per_frame"]
    pcm = raw
    if fmt["bits_per_sample"] == 16:
        swapped = bytearray(len(raw))
        swapped[0::2] = raw[1::2]
        swapped[1::2] = raw[0::2]
        pcm = bytes(swapped)
    target.parent.mkdir(parents=True, exist_ok=True)
    with wave.open(str(target), "wb") as wav:
        wav.setnchannels(fmt["channels"])
        wav.setsampwidth(fmt["bytes_per_sample"])
        wav.setframerate(fmt["sample_rate"])
        wav.writeframes(pcm)
    # Round-trip the sample stream: catches endian/length/output-writing mistakes.
    with wave.open(str(target), "rb") as wav:
        assert wav.readframes(wav.getnframes()) == pcm
        assert wav.getnframes() == fmt["frames"]
    row.update({"status": "exported", "header_chunk": hid, "asset_chunk": sid, "source": str(samplefile),
                "source_sha256": sha(raw), "pcm_sha256": sha(pcm), "format": fmt,
                "duration_seconds": fmt["frames"]/fmt["sample_rate"],
                "sample_encoding": "unsigned PCM8" if fmt["bits_per_sample"] == 8 else "signed PCM16 big-endian to little-endian"})


def pict(ctx, cid, row, output):
    """Strict PICT v2 reader for this disc's single 8-bit PackBitsRect pictures."""
    asset = ctx["children"][cid]["PICT"]
    source = ctx["chunks"] / f"PICT-{asset}.bin"
    raw = source.read_bytes()
    rawfile = output / "pict" / ctx["folder"].name / f"PICT-{asset}.pict"
    rawfile.parent.mkdir(parents=True, exist_ok=True)
    rawfile.write_bytes(bytes(512)+raw)
    bounds = struct.unpack_from(">4h", raw, 2)
    assert raw[10:14] == b"\x00\x11\x02\xff", "Expected PICT version 2"
    cursor, image = 14, None
    opcodes = []
    while cursor < len(raw):
        cursor += cursor % 2
        opcode = struct.unpack_from(">H", raw, cursor)[0]
        cursor += 2
        opcodes.append(hex(opcode))
        if opcode == 0xc00:
            cursor += 24
        elif opcode == 0xa1:
            comment_len = struct.unpack_from(">H", raw, cursor+2)[0]
            cursor += 4+comment_len
        elif opcode == 1:
            region_len = struct.unpack_from(">H", raw, cursor)[0]
            assert region_len == 10 and struct.unpack_from(">4h", raw, cursor+2) == bounds, "Nonrectangular clip"
            cursor += region_len
        elif opcode == 0x98:
            assert image is None, "Multiple picture drawing operations"
            pitch = struct.unpack_from(">H", raw, cursor)[0]
            assert pitch & 0x8000
            pitch &= 0x7fff
            rect = struct.unpack_from(">4h", raw, cursor+2)
            pack_type = struct.unpack_from(">H", raw, cursor+12)[0]
            pixel_type, depth, components, component_depth = struct.unpack_from(">4H", raw, cursor+26)
            assert (pack_type, pixel_type, depth, components, component_depth) == (0, 0, 8, 1, 8)
            cursor += 46
            colors = struct.unpack_from(">H", raw, cursor+6)[0]+1
            cursor += 8
            palette = bytearray(768)
            for _ in range(colors):
                index, red, green, blue = struct.unpack_from(">4H", raw, cursor)
                assert index < 256
                palette[index*3:index*3+3] = bytes((red >> 8, green >> 8, blue >> 8))
                cursor += 8
            src = struct.unpack_from(">4h", raw, cursor)
            dst = struct.unpack_from(">4h", raw, cursor+8)
            mode = struct.unpack_from(">H", raw, cursor+16)[0]
            cursor += 18
            assert src == dst == rect == bounds and mode == 0
            width, height = rect[3]-rect[1], rect[2]-rect[0]
            indices = bytearray()
            for _ in range(height):
                n = struct.unpack_from(">H", raw, cursor)[0] if pitch > 250 else raw[cursor]
                cursor += 2 if pitch > 250 else 1
                packed = raw[cursor:cursor+n]
                cursor += n
                pos, unpacked = 0, bytearray()
                while pos < len(packed):
                    control = packed[pos]
                    pos += 1
                    if control == 128:
                        continue
                    if control > 128:
                        assert pos < len(packed)
                        unpacked.extend(bytes([packed[pos]])*(257-control))
                        pos += 1
                    else:
                        length = control+1
                        assert pos+length <= len(packed)
                        unpacked.extend(packed[pos:pos+length])
                        pos += length
                assert len(unpacked) == pitch
                indices.extend(unpacked[:width])
            image = Image.frombytes("P", (width, height), bytes(indices))
            image.putpalette(bytes(palette))
        elif opcode == 0xff:
            assert cursor == len(raw), "Data after PICT end marker"
            break
        else:
            raise ValueError(f"Unsupported PICT opcode {opcode:#x}")
    assert image is not None
    row.update({"status": "exported", "asset_chunk": asset, "source": str(source), "source_sha256": sha(raw),
                "raw_pict": str(rawfile.relative_to(output)), "raw_pict_note": "Original resource plus 512 zero-byte PICT file header.",
                "width": image.width, "height": image.height, "bits_per_pixel": 8, "encoding": "PICT v2 PackBitsRect",
                "palette": {"status": "exact", "kind": "PICT embedded color table"},
                "pixel_sha256": sha(image.tobytes()), "pict_opcodes": opcodes, "png_mode": "P"})
    return image


def contact_sheets(rows, output):
    selected = []
    examples = [("KALENDER", 352), ("DAG01", 643), ("DAG05", None), ("DAG08", 24),
                ("DAG10", None), ("DAG12", None), ("DAG15", None), ("DAG17", None),
                ("DAG18", 141), ("DAG24", None), ("KONSTR01", None), ("DAG04", None)]
    for movie, cid in examples:
        candidates = [r for r in rows if r["movie"] == movie and r["type"] == "bitmap"
                      and r["status"] == "exported" and (cid is None or r["cast_chunk"] == cid)]
        if candidates:
            selected.append(max(candidates, key=lambda r: r["width"]*r["height"]))
    def sheet(chosen, columns, cell_width, cell_height, filename):
        if not chosen:
            return
        canvas = Image.new("RGB", (columns*cell_width, ((len(chosen)+columns-1)//columns)*cell_height), "#ddd")
        draw = ImageDraw.Draw(canvas)
        for i, row in enumerate(chosen):
            im = Image.open(output / row["output"]).convert("RGB")
            im.thumbnail((cell_width-16, cell_height-52))
            x, y = i%columns*cell_width, i//columns*cell_height
            canvas.paste(im, (x+(cell_width-im.width)//2, y+8))
            draw.text((x+8, y+cell_height-38), f"{row['movie']} / {row['name'][:26]}", fill="black")
            draw.text((x+8, y+cell_height-22), f"{row['width']}x{row['height']} / {row['bits_per_pixel']} bpp", fill="black")
        canvas.save(output / filename)
        (output / Path(filename).with_suffix(".json")).write_text(json.dumps(chosen, indent=2, ensure_ascii=False)+"\n")
    sheet(selected, 4, 360, 300, "contact-sheet.png")
    sheet([r for r in rows if r["type"] == "pict" and r["status"] == "exported"], 2, 525, 390, "pict-contact-sheet.png")


def export_all(source, output, palette_source):
    output.mkdir(parents=True, exist_ok=True)
    builtins = builtin_palettes(palette_source)
    rows, palette_rows = [], []
    for folder in sorted(source.iterdir()):
        if not folder.is_dir():
            continue
        ctx = movie_context(folder)
        if ctx is None:
            continue
        for pal in ctx["palettes"]:
            palette = pal["palette"]
            item = {k: v for k, v in pal.items() if k != "palette"}
            item["movie"] = folder.name
            name = f"palettes/{folder.name}/CLUT-{pal['asset_chunk']}.json"
            item["output"] = name
            p = output / name
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text(json.dumps({**item, "rgb": [list(palette[i:i+3]) for i in range(0, len(palette), 3)]}, indent=2)+"\n")
            palette_rows.append(item)
        for path in sorted(ctx["chunks"].glob("CASt-*.json"), key=chunk_id):
            cid = chunk_id(path)
            meta = read_json(path)
            if meta["type"] not in (1, 5, 6):
                continue
            info = meta.get("info") or {}
            name = legacy(info.get("name", ""))
            row = {"movie": folder.name, "cast_chunk": cid, "name": name, "type": {1: "bitmap", 5: "pict", 6: "sound"}[meta["type"]],
                   **ctx["members"].get(cid, {}), "cast_metadata_source": str(path)}
            base = f"lib{row.get('cast_library_index',0)}_member{row.get('member_number',0)}_CASt{cid}_{safe(name)}"
            extension = "wav" if meta["type"] == 6 else "png"
            relative = Path({1: "bitmaps", 5: "pict", 6: "audio"}[meta["type"]]) / folder.name / f"{base}.{extension}"
            target = output / relative
            try:
                if meta["type"] in (1, 5):
                    im = bitmap(ctx, cid, meta, row, builtins) if meta["type"] == 1 else pict(ctx, cid, row, output)
                    if im:
                        target.parent.mkdir(parents=True, exist_ok=True)
                        text = PngImagePlugin.PngInfo()
                        text.add_text("Director cast member", json.dumps({k:v for k,v in row.items() if k in (
                            "movie", "cast_chunk", "name", "cast_library_index", "member_number", "palette")}, ensure_ascii=False))
                        im.save(target, pnginfo=text)
                        with Image.open(target) as check:
                            assert check.size == im.size and check.tobytes() == im.tobytes()
                else:
                    sound(ctx, cid, row, target)
                if row["status"] == "exported":
                    row["output"] = str(relative)
                    row["output_sha256"] = sha(target.read_bytes())
            except Exception as error:
                row["status"] = "failed"
                row["error"] = f"{type(error).__name__}: {error}"
            rows.append(row)
        print(f"{folder.name}: {sum(r['movie']==folder.name and r['status']=='exported' for r in rows)} media exported", flush=True)
    counts = collections.Counter((r["type"], r["status"]) for r in rows)
    palettes = collections.Counter(r["palette"]["status"] for r in rows if "palette" in r)
    summary = {"counts": {f"{kind}_{status}": n for (kind, status), n in sorted(counts.items())},
               "palette_status": dict(palettes), "palette_assets": len(palette_rows),
               "audio_duration_seconds": sum(r.get("duration_seconds", 0) for r in rows),
               "source": str(source), "palette_table_source": str(palette_source),
               "notes": ["Palette PNGs preserve pixel indices.",
                         "Sprite inks, mattes, dynamic palette changes, looping, and cue scheduling remain runtime concerns."]}
    (output / "manifest.json").write_text(json.dumps({"summary": summary, "palettes": palette_rows, "media": rows}, indent=2, ensure_ascii=False)+"\n")
    (output / "failures.json").write_text(json.dumps([r for r in rows if r["status"] == "failed"], indent=2, ensure_ascii=False)+"\n")
    (output / "summary.json").write_text(json.dumps(summary, indent=2)+"\n")
    contact_sheets(rows, output)
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=Path("artifacts/decompiled"))
    parser.add_argument("--output", type=Path, default=Path("artifacts/media"))
    parser.add_argument("--palette-source", type=Path,
                        default=Path("tools/reference/scummvm-graphics-data.h"))
    args = parser.parse_args()
    export_all(args.source, args.output, args.palette_source)
