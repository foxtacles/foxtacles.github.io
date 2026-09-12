#!/usr/bin/env python3
"""Extract this disc's Director 7 PJ00 projectors without executing native code.

The PJ00 pointer, APPL dictionary, and absolute mmap offsets are corroborated by
https://github.com/scummvm/scummvm/blob/master/engines/director/resource.cpp .
All output files receive SHA-256 hashes in manifest.json. Native metadata uses
pefile; the Director/Xtra extraction itself uses only Python's standard library.
"""
import argparse
import hashlib
import json
import re
import struct
import zlib
from pathlib import Path


def sha(data):
    return hashlib.sha256(data).hexdigest()


def safe_name(name):
    return re.sub(r"[\x00-\x1f/:\\]", "_", name)


def pe_metadata(data):
    try:
        import pefile
    except ImportError:
        return {"metadata_unavailable": "Install pefile to parse native PE metadata"}
    pe = pefile.PE(data=data)
    versions = []
    for infos in getattr(pe, "FileInfo", []):
        for info in infos:
            for table in getattr(info, "StringTable", []):
                versions.append({k.decode("utf-8", "replace"): v.decode("utf-8", "replace")
                                 for k, v in table.entries.items()})
    return {
        "machine": hex(pe.FILE_HEADER.Machine),
        "timestamp": pe.FILE_HEADER.TimeDateStamp,
        "image_base": hex(pe.OPTIONAL_HEADER.ImageBase),
        "entry_point_rva": hex(pe.OPTIONAL_HEADER.AddressOfEntryPoint),
        "entry_point_va": hex(pe.OPTIONAL_HEADER.ImageBase + pe.OPTIONAL_HEADER.AddressOfEntryPoint),
        "linker_version": f"{pe.OPTIONAL_HEADER.MajorLinkerVersion}.{pe.OPTIONAL_HEADER.MinorLinkerVersion}",
        "subsystem": pe.OPTIONAL_HEADER.Subsystem,
        "sections": [{"name": s.Name.rstrip(b"\0").decode(), "rva": hex(s.VirtualAddress),
                      "raw_offset": s.PointerToRawData, "raw_size": s.SizeOfRawData,
                      "virtual_size": s.Misc_VirtualSize} for s in pe.sections],
        "imports": {x.dll.decode(): [i.name.decode() if i.name else f"ordinal:{i.ordinal}" for i in x.imports]
                    for x in getattr(pe, "DIRECTORY_ENTRY_IMPORT", [])},
        "exports": [{"name": s.name.decode() if s.name else None, "rva": hex(s.address), "ordinal": s.ordinal}
                    for s in getattr(getattr(pe, "DIRECTORY_ENTRY_EXPORT", None), "symbols", [])],
        "version_info": versions,
    }


def mmap_entries(data, base):
    endian = "<" if data[base:base+4] == b"XFIR" else ">"
    assert data[base:base+4] in (b"XFIR", b"RIFX")
    imap_tag = b"pami" if endian == "<" else b"imap"
    mmap_tag = b"pamm" if endian == "<" else b"mmap"
    assert data[base+12:base+16] == imap_tag
    mp = struct.unpack_from(endian + "I", data, base+24)[0]
    assert data[mp:mp+4] == mmap_tag
    count = struct.unpack_from(endian + "I", data, mp+16)[0]
    assert count < 100000
    entries = []
    for i in range(count):
        tag, size, off, flags, unknown, nxt = struct.unpack_from(endian + "4sIIHHI", data, mp+32+20*i)
        entries.append({"index": i, "tag": (tag[::-1] if endian == "<" else tag).decode("latin1"),
                        "size": size, "offset": off, "flags": flags})
    return endian, mp, entries


def rebase_movie(data, base):
    endian, mp, entries = mmap_entries(data, base)
    size = struct.unpack_from(endian + "I", data, base+4)[0] + 8
    assert base+size <= len(data)
    result = bytearray(data[base:base+size])
    patches = [{"offset": 24, "old": mp, "new": mp-base}]
    struct.pack_into(endian + "I", result, 24, mp-base)
    for row in entries:
        if row["offset"] >= base and (row["size"] or row["offset"]):
            pos = mp-base+32+20*row["index"]+8
            struct.pack_into(endian + "I", result, pos, row["offset"]-base)
            patches.append({"offset": pos, "old": row["offset"], "new": row["offset"]-base})
        else:
            assert row["size"] == 0, f"Unexpected offset before movie: {row}"
    # Verify that rebased offsets parse and point inside the standalone movie.
    _, _, rebased = mmap_entries(result, 0)
    for row in rebased:
        assert row["offset"] < len(result) or not row["size"]
    return bytes(result), patches


def extract(source, output):
    source, output = Path(source), Path(output)
    data = source.read_bytes()
    output.mkdir(parents=True, exist_ok=True)
    result = {"source": str(source), "source_size": len(data), "source_sha256": sha(data), "files": []}

    def save(name, content, **extra):
        p = output / name
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_bytes(content)
        row = {"path": name, "size": len(content), "sha256": sha(content), **extra}
        result["files"].append(row)
        return row

    if data[:2] == b"MZ":
        platform = "Windows"
        header = struct.unpack_from("<I", data, len(data)-4)[0]
        assert data[header:header+4] == b"00JP"
        app = struct.unpack_from("<I", data, header+4)[0]
        result["projector_header_offset"] = header
        result["launcher"] = pe_metadata(data)
        save("native/projector-shim.exe", data[:header], source_offset=0, pe=pe_metadata(data[:header]))
        # Header has a DLL count at +16; each 52-byte record names and locates a DLL.
        n = struct.unpack_from("<I", data, header+16)[0]
        for i in range(n):
            pos = header+24+52*i
            off, size = struct.unpack_from("<II", data, pos)
            stem = data[pos+8:pos+40].split(b"\0", 1)[0].decode("ascii")
            content = data[off:off+size]
            assert content.startswith(b"MZ") and len(content) == size
            save(f"native/{safe_name(stem)}.dll", content, source_offset=off, pe=pe_metadata(content))
    else:
        platform = "Macintosh"
        assert data[:4] == b"PJ00"
        app = struct.unpack_from(">I", data, 4)[0]
        result["projector_header_offset"] = 0
    result["platform"] = platform
    result["appl_offset"] = app
    endian, mp, entries = mmap_entries(data, app)
    result["appl_mmap"] = entries
    dictionary = next(x for x in entries if x["tag"] == "Dict")
    d = dictionary["offset"]
    count = struct.unpack_from(endian + "I", data, d+24)[0]
    names = []
    cursor = d+64+count*8
    for _ in range(count):
        n = struct.unpack_from(endian + "I", data, cursor)[0]
        assert n < 4096
        names.append(data[cursor+4:cursor+4+n].decode("cp1252" if endian == "<" else "mac_roman"))
        cursor += 4 + ((n+3)//4)*4
    members = [x for x in entries if x["tag"] == "File"]
    assert len(names) == len(members)
    for name, member in zip(names, members):
        off = member["offset"]
        basename = safe_name(re.split(r"[:\\]", name)[-1])
        raw = data[off:off+member["size"]]
        if raw[:4] in (b"RIFX", b"XFIR"):
            movie, patches = rebase_movie(data, off)
            save(basename, movie, kind="Director movie", source_offset=off, original_name=name,
                 original_sha256=sha(raw), rebasing_patches=patches)
            save(f"raw/{basename}.embedded", raw, kind="Original embedded movie", source_offset=off)
        else:
            assert raw[:4] == b"RIFF" and raw[8:16] == b"XtraFILE"
            # These RIFF wrappers use big-endian sizes, despite their literal tag.
            assert struct.unpack_from(">I", raw, 4)[0]+8 == len(raw)
            file_len, header_len, ftype, creator, dlen, rlen, dc, rc = struct.unpack_from(">II4s4sIIII", raw, 16)
            assert header_len == 28 and file_len == 28+dc+rc
            packed = raw[20+header_len:20+header_len+dc]
            unpacked = zlib.decompress(packed)
            assert len(unpacked) == dlen
            row = save(f"xtras/{basename}", unpacked, kind="Xtra data fork", source_offset=off,
                       original_name=name, type=ftype.decode("latin1"), creator=creator.decode("latin1"),
                       compressed_size=dc, original_sha256=sha(raw))
            if unpacked.startswith(b"MZ"):
                row["pe"] = pe_metadata(unpacked)
            if rc:
                resource = zlib.decompress(raw[20+header_len+dc:20+header_len+dc+rc])
                assert len(resource) == rlen
                save(f"xtras/{basename}.rsrc", resource, kind="Xtra resource fork", compressed_size=rc)
            else:
                assert rlen == 0
            save(f"raw/{basename}.xtra-riff", raw, kind="Original embedded Xtra", source_offset=off)
    (output / "manifest.json").write_text(json.dumps(result, indent=2, ensure_ascii=False)+"\n")
    return result


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    result = extract(args.source, args.output)
    print(f"{result['platform']}: extracted {len(result['files'])} files into {args.output}")
