#!/usr/bin/env python3
"""Preserve HFS data/resource forks, Finder metadata, and native PEF fragments.

Dependencies: machfs==1.3, macresources==1.2 (or compatible versions).
Does not mount the image or execute any extracted file.
"""
import argparse
import collections
import json
import struct
from pathlib import Path

import machfs
import macresources
from extract_projector import extract, safe_name, sha


class CompleteVolume(machfs.Volume):
    def pop(self, key, default=None):
        # Volume.read() normally discards Finder desktop databases. Preserve them.
        return self.get(key, default)


def pef_metadata(data):
    assert data[:8] == b"Joy!peff"
    arch = data[8:12].decode("ascii")
    count = struct.unpack_from(">H", data, 32)[0]
    sections = []
    for i in range(count):
        name, address, total, unpacked, packed, offset, kind, share, alignment, reserved = struct.unpack_from(">i5I4B", data, 40+28*i)
        sections.append({"index": i, "name_offset": name, "default_address": address, "total_size": total,
                         "unpacked_size": unpacked, "packed_size": packed, "offset": offset, "kind": kind,
                         "alignment_power": alignment})
    meta = {"architecture": arch, "format_version": struct.unpack_from(">I", data, 12)[0], "sections": sections}
    ld = next((x for x in sections if x["kind"] == 4), None)
    if ld:
        loader = data[ld["offset"]:ld["offset"]+ld["packed_size"]]
        main_s, main_o, init_s, init_o, term_s, term_o, libs, syms, relocs, reloff, stroff, hashoff, hashpower, expcount = struct.unpack_from(">iIiIiI8I", loader)
        meta["loader"] = {"main_section": main_s, "main_offset": main_o, "init_section": init_s,
                          "init_offset": init_o, "term_section": term_s, "term_offset": term_o,
                          "imported_symbol_count": syms, "exported_symbol_count": expcount}
        imports = []
        for i in range(libs):
            noff, old, current, nsyms, first = struct.unpack_from(">5I", loader, 56+24*i)
            name = loader[stroff+noff:].split(b"\0", 1)[0].decode("mac_roman")
            names = []
            for j in range(first, first+nsyms):
                value = struct.unpack_from(">I", loader, 56+24*libs+4*j)[0]
                names.append(loader[stroff+(value&0xffffff):].split(b"\0", 1)[0].decode("mac_roman"))
            imports.append({"library": name, "symbols": names})
        meta["imports"] = imports
    return meta


def resources(raw, output):
    rows = []
    output.mkdir(parents=True, exist_ok=True)
    for resource in macresources.parse_file(raw):
        tag = resource.type.decode("mac_roman")
        name = f"{safe_name(tag)}_{resource.id}.bin"
        data = bytes(resource.data)
        (output / name).write_bytes(data)
        row = {"type": tag, "id": resource.id, "name": resource.name, "attributes": resource.attribs,
               "path": name, "size": len(data), "sha256": sha(data)}
        if tag == "vers":
            n = data[6]
            row["short_version"] = data[7:7+n].decode("mac_roman")
            row["description"] = data[8+n:8+n+data[7+n]].decode("mac_roman")
        rows.append(row)
    (output / "manifest.json").write_text(json.dumps(rows, indent=2, ensure_ascii=False)+"\n")
    return rows


def main(source, output, iso_files):
    data = source.read_bytes()
    volume = CompleteVolume()
    volume.read(data)
    rows = []
    output.mkdir(parents=True, exist_ok=True)

    def walk(folder, path=()):
        for name, obj in folder.items():
            components = (*path, name)
            relative = Path(*[safe_name(n) for n in components])
            if isinstance(obj, machfs.Folder):
                (output / "data" / relative).mkdir(parents=True, exist_ok=True)
                walk(obj, components)
                continue
            row = {"hfs_path": ":".join(components), "output_path": str(relative),
                   "type": obj.type.decode("mac_roman"), "creator": obj.creator.decode("mac_roman"),
                   "finder_flags": obj.flags, "created_mac_epoch": obj.crdate, "modified_mac_epoch": obj.mddate,
                   "backup_mac_epoch": obj.bkdate, "finder_x": obj.x, "finder_y": obj.y}
            for fork, payload in [("data", obj.data), ("rsrc", obj.rsrc)]:
                target = output / fork / relative
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(payload)
                row[fork] = {"size": len(payload), "sha256": sha(payload)}
            if iso_files and len(components) == 2 and components[0] == "Main":
                win = iso_files / "MAIN" / components[1].upper()
                if win.exists():
                    row["windows_equivalent"] = str(win)
                    row["windows_byte_identical"] = win.read_bytes() == obj.data
            rows.append(row)

    walk(volume)
    part_count = struct.unpack_from(">I", data, 516)[0]
    partitions = []
    for i in range(part_count):
        p = 512*(i+1)
        start, blocks = struct.unpack_from(">II", data, p+8)
        partitions.append({"name": data[p+16:p+48].split(b"\0")[0].decode("mac_roman"),
                           "type": data[p+48:p+80].split(b"\0")[0].decode("ascii"),
                           "start_block_512": start, "block_count": blocks,
                           "byte_offset": start*512, "byte_length": blocks*512})
    manifest = {"source": str(source), "sha256": sha(data), "partitions": partitions, "files": rows}
    (output / "manifest.json").write_text(json.dumps(manifest, indent=2, ensure_ascii=False)+"\n")

    launcher = volume["Findus3"]
    # Convenience copies retain the explicit fork suffix for tools without HFS support.
    (output / "Findus3.data").write_bytes(launcher.data)
    (output / "Findus3.rsrc").write_bytes(launcher.rsrc)
    resources(launcher.rsrc, output / "resources")
    cfrg = next(r.data for r in macresources.parse_file(launcher.rsrc) if r.type == b"cfrg")
    count = struct.unpack_from(">I", cfrg, 28)[0]
    native = []
    cursor = 32
    for _ in range(count):
        arch = bytes(cfrg[cursor:cursor+4]).decode("ascii")
        off, declared_size = struct.unpack_from(">II", cfrg, cursor+24)
        record_size = struct.unpack_from(">H", cfrg, cursor+40)[0]
        n = cfrg[cursor+42]
        name = bytes(cfrg[cursor+43:cursor+43+n]).decode("mac_roman")
        chunk = launcher.data[off:]
        meta = pef_metadata(chunk)
        inferred_size = max(40+28*len(meta["sections"]), *(s["offset"]+s["packed_size"] for s in meta["sections"]))
        size = declared_size or inferred_size
        chunk = chunk[:size]
        p = output / "native" / (safe_name(name)+".pef")
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_bytes(chunk)
        native.append({"name": name, "architecture": arch, "offset": off, "declared_size": declared_size,
                       "size": len(chunk), "sha256": sha(chunk), "path": str(p), "pef": meta})
        cursor += record_size
    (output / "native" / "manifest.json").write_text(json.dumps(native, indent=2, ensure_ascii=False)+"\n")
    project = extract(output / "Findus3.data", output / "projector")
    for row in project["files"]:
        path = output / "projector" / row["path"]
        raw = path.read_bytes()
        if row["kind"] == "Xtra data fork" and raw.startswith(b"Joy!peff"):
            row["pef"] = pef_metadata(raw)
        elif row["kind"] == "Xtra resource fork":
            row["resources"] = resources(raw, output / "xtra-resources" / safe_name(path.stem))
    (output / "projector" / "manifest.json").write_text(json.dumps(project, indent=2, ensure_ascii=False)+"\n")
    same = sum(r.get("windows_byte_identical", False) for r in rows)
    print(f"Preserved {len(rows)} HFS files with both forks; {same} Main files match Windows byte-for-byte; {len(native)} PEF fragments")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--iso-files", type=Path, default=Path("artifacts/disc"))
    args = parser.parse_args()
    main(args.source, args.output, args.iso_files)
