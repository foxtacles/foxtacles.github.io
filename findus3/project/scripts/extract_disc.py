#!/usr/bin/env python3
"""Extract this MODE1/2352 CloneCD image and its ISO9660 tree; no mounting needed.

The ISO also retains the hybrid Apple partitions. HFS forks are extracted by the
separate Mac extractor. This checks sector framing, not EDC/ECC/subchannel data.
"""
import argparse
import hashlib
import json
import struct
from pathlib import Path


def sha256(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def extract(image, output):
    output.mkdir(parents=True, exist_ok=True)
    iso = output / 'CD01.iso'
    assert image.stat().st_size % 2352 == 0, 'Incomplete raw sector'
    sectors = image.stat().st_size // 2352
    with image.open('rb') as src, iso.open('wb') as dst:
        for sector in range(sectors):
            raw = src.read(2352)
            if raw[:12] != b'\0' + b'\xff' * 10 + b'\0' or raw[15] != 1:
                raise ValueError(f'Invalid MODE1 sector framing: {sector}')
            dst.write(raw[16:2064])
    data = iso.read_bytes()
    pvd = data[16 * 2048:17 * 2048]
    assert pvd[:7] == b'\x01CD001\x01', 'ISO9660 PVD not found'
    assert struct.unpack_from('<H', pvd, 128)[0] == 2048
    root = output / 'disc'
    root.mkdir(exist_ok=True)
    inventory = []
    visited = set()

    def record(rec):
        extent, size = struct.unpack_from('<I', rec, 2)[0], struct.unpack_from('<I', rec, 10)[0]
        assert extent == struct.unpack_from('>I', rec, 6)[0]
        assert size == struct.unpack_from('>I', rec, 14)[0]
        return extent, size

    def walk(rec, dest):
        extent, size = record(rec)
        assert (extent, size) not in visited, 'Directory loop'
        visited.add((extent, size))
        pos, end = extent * 2048, extent * 2048 + size
        assert end <= len(data)
        while pos < end:
            length = data[pos]
            if not length:
                pos = (pos // 2048 + 1) * 2048
                continue
            entry = data[pos:pos + length]
            pos += length
            name_raw = entry[33:33 + entry[32]]
            if name_raw in (b'\0', b'\1'):
                continue
            name = name_raw.decode('ascii').split(';')[0]
            assert name not in ('.', '..') and '/' not in name and '\\' not in name
            path = dest / name
            if entry[25] & 2:
                path.mkdir(exist_ok=True)
                walk(entry, path)
            else:
                assert not entry[25] & 128, 'Multi-extent files are not implemented'
                start, length = record(entry)
                payload = data[start * 2048:start * 2048 + length]
                assert len(payload) == length
                path.write_bytes(payload)
                inventory.append({'path': str(path.relative_to(root)), 'lba': start,
                                  'size': length, 'sha256': hashlib.sha256(payload).hexdigest()})

    walk(pvd[156:156 + pvd[156]], root)
    report = {'source': image.name, 'source_sha256': sha256(image), 'raw_sector_size': 2352,
              'sector_count': sectors, 'data_sector_size': 2048, 'iso_sha256': sha256(iso),
              'volume_id': pvd[40:72].decode('ascii').strip(),
              'checks': 'All sector sync patterns and MODE1 headers; ISO record bounds and dual-endian extents. EDC/ECC and subchannels not validated.',
              'files': sorted(inventory, key=lambda item: item['path'])}
    report['companions'] = [{'path': str(p), 'size': p.stat().st_size, 'sha256': sha256(p)}
                            for ext in ('.cue', '.ccd', '.sub') if (p := image.with_suffix(ext)).exists()]
    (output / 'disc-manifest.json').write_text(json.dumps(report, indent=2) + '\n')
    print(f'Extracted {len(inventory)} files from {sectors} raw sectors to {root}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('image', nargs='?', type=Path, default=Path('CD01.img'))
    parser.add_argument('--output', type=Path, default=Path('artifacts'))
    args = parser.parse_args()
    extract(args.image, args.output)
