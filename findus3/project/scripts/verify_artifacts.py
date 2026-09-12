#!/usr/bin/env python3
"""Check source-disc hashes and byte-preservation through Director reconstruction.

This is structural verification, not proof of equivalent game execution.
"""
import collections
import hashlib
import json
import re
import struct
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def digest(path):
    with path.open('rb') as f:
        return hashlib.file_digest(f, 'sha256').hexdigest()


def chunks(path):
    data = path.read_bytes()
    endian = '>' if data[:4] == b'RIFX' else '<'
    assert data[:4] in (b'RIFX', b'XFIR')
    def value(fmt, at):
        return struct.unpack_from(endian + fmt, data, at)
    def tag(at):
        raw = data[at:at + 4]
        return raw if endian == '>' else raw[::-1]
    assert tag(12) == b'imap'
    mmap = value('I', 24)[0]
    assert tag(mmap) == b'mmap'
    header, entry_size, capacity, used = value('HHII', mmap + 8)
    result = {}
    for i in range(capacity):
        at = mmap + 8 + header + i * entry_size
        kind = tag(at)
        length, offset = value('II', at + 4)
        if kind in (b'free', b'junk', b'\0\0\0\0'):
            continue
        if kind == b'RIFX':
            # Several authored files omit the final odd-byte container pad.
            assert 0 <= offset + 8 + length - len(data) <= 1
            result[i] = (kind, data[8:])
            continue
        assert offset + 8 + length <= len(data), (path, i)
        assert tag(offset) == kind
        result[i] = (kind, data[offset + 8:offset + 8 + length])
    return result


def main():
    disc = json.loads((ROOT / 'artifacts/disc-manifest.json').read_text())
    assert digest(ROOT / disc['source']) == disc['source_sha256']
    assert digest(ROOT / 'artifacts/CD01.iso') == disc['iso_sha256']
    for companion in disc.get('companions', []):
        assert digest(ROOT / companion['path']) == companion['sha256']
    for row in disc['files']:
        assert digest(ROOT / 'artifacts/disc' / row['path']) == row['sha256']
    manifest = json.loads((ROOT / 'artifacts/decompilation-manifest.json').read_text())
    results = []
    for row in manifest:
        original = chunks(ROOT / row['input'])
        rebuilt = chunks(ROOT / row['editable'])
        changed = collections.Counter()
        preserved = collections.Counter()
        dump = ROOT / row['dump']
        for key, (tag, raw) in original.items():
            if tag != b'RIFX':
                safe_tag = re.sub(r'[<>:"/\\|?*]', '_', tag.decode('ascii'))
                assert (dump / 'chunks' / f'{safe_tag}-{key}.bin').read_bytes() == raw, (row['input'], key, 'dump differs from original')
            assert key in rebuilt, (row['input'], key, 'missing chunk')
            new_tag, new_raw = rebuilt[key]
            assert new_tag == tag
            if raw == new_raw:
                preserved[tag.decode('ascii')] += 1
            else:
                changed[tag.decode('ascii')] += 1
                assert tag in (b'RIFX', b'imap', b'mmap', b'DRCF', b'CASt'), (row['input'], key, tag, 'unexpected mutation')
        assert preserved['Lscr'] == row['script_resources']
        for key, (tag, raw) in original.items():
            if tag == b'Lscr':
                assert (dump / 'scripts-by-chunk' / f'Lscr-{key}.ls').exists()
                assert (dump / 'scripts-by-chunk' / f'Lscr-{key}.lasm').exists()
        results.append({'input': row['input'], 'preserved_chunks': dict(preserved),
                        'rewritten_chunks': dict(changed), 'status': 'pass'})
    summary = {'source_image_sha256': disc['source_sha256'], 'disc_files_verified': len(disc['files']),
               'containers_verified': len(results), 'script_resources_preserved': sum(r['preserved_chunks'].get('Lscr', 0) for r in results),
               'verified': 'Every dumped payload equals its original live resource; every original live resource ID retained; all bytecode, name tables, score, sound and bitmap payloads unchanged in reconstructed containers.',
               'not_verified': 'Source recompilation/behavioral equivalence, full original-runtime playthrough, complete open-source-runtime compatibility.',
               'containers': results}
    (ROOT / 'artifacts/verification.json').write_text(json.dumps(summary, indent=2) + '\n')
    print(f'PASS: {len(disc["files"])} extracted files, {len(results)} reconstructed containers, '
          f'{summary["script_resources_preserved"]} byte-identical script resources')


if __name__ == '__main__':
    main()
