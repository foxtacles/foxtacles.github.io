#!/usr/bin/env python3
"""Index Director resources and decode D7 score deltas without running the game.

Format references: ScummVM engines/director/{score.cpp,frame.cpp,spriteinfo.h}.
Output contains authored score state, not Lingo's runtime/puppet modifications.
Unknown fields and all sprite-detail records are retained as hexadecimal bytes.
"""
import collections
import hashlib
import json
import re
import struct
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TYPES = {0: 'empty', 1: 'bitmap', 2: 'filmLoop', 3: 'text', 4: 'palette',
         5: 'picture', 6: 'sound', 7: 'button', 8: 'shape', 9: 'movie',
         10: 'digitalVideo', 11: 'script', 12: 'richText', 15: 'richTextXtra'}


def unpack(data, offset, fmt):
    return struct.unpack_from('>' + fmt, data, offset)


def mac(s):
    return s.encode('latin1').decode('mac_roman')


def load(path):
    return json.loads(path.read_text())


def labels(data):
    count = unpack(data, 0, 'H')[0] + 1
    base = 2 + 4 * count
    entries = [unpack(data, 2 + 4 * i, 'HH') for i in range(count)]
    result = []
    for (frame, start), (_, end) in zip(entries, entries[1:]):
        assert start <= end and base + end <= len(data)
        text = data[base + start:base + end].decode('mac_roman').split('\r', 1)
        result.append({'frame': frame, 'label': text[0], 'comment': text[1] if len(text) > 1 else ''})
    return result


def sprite(data, channel):
    cast, member, detail, y, x, h, w = unpack(data, 4, 'hHIhhhh')
    return {'channel': channel, 'type': data[0], 'ink': data[1] & 63,
            'trails': bool(data[1] & 64), 'stretch': bool(data[1] & 128),
            'cast': cast, 'member': member, 'detail_index': detail,
            'x': x, 'y': y, 'width': w, 'height': h,
            'color_flags': data[20], 'blend_raw': data[21], 'thickness': data[22],
            'flags': data[23], 'foreground': [data[2], data[24], data[26]],
            'background': [data[3], data[25], data[27]],
            'rotation_raw': unpack(data, 28, 'i')[0], 'skew_raw': unpack(data, 32, 'i')[0],
            'raw': data.hex()}


def score(data):
    length, version, list_start = unpack(data, 0, 'IiI')
    count, list_size, data_length = unpack(data, list_start, 'III')
    base = list_start + 12 + list_size * 4
    assert list_size >= count + 1
    offsets = unpack(data, list_start + 12, f'{count + 1}I')
    assert length == len(data) and base + data_length <= len(data)
    assert all(a <= b for a, b in zip(offsets, offsets[1:]))
    detail = [data[base + start:base + end] for start, end in zip(offsets, offsets[1:])]
    # The extra list slot after numEntries is the terminal offset.
    header = unpack(detail[0], 0, 'IIIHHHH')
    size, frame_offset, declared_frames, frame_version, record_size, channels, displayed = header
    assert record_size == 48 and frame_offset == 20, header
    assert 0 <= len(detail[0]) - size <= 3 and not any(detail[0][size:]), 'Nonzero score alignment padding'
    # This game stores six 48-byte control records and up to 1000 sprites.
    state = bytearray(channels * record_size)
    frames = []
    pos = frame_offset
    while pos < size:
        frame_start = pos
        frame_size = unpack(detail[0], pos, 'H')[0]
        if frame_size == 0:
            break
        assert frame_size >= 2 and pos + frame_size <= size
        pos += 2
        changed = set()
        while pos < frame_start + frame_size:
            amount, offset = unpack(detail[0], pos, 'HH')
            pos += 4
            assert pos + amount <= frame_start + frame_size
            assert offset + amount <= len(state)
            state[offset:offset + amount] = detail[0][pos:pos + amount]
            if amount:
                changed.update(range(offset // 48, (offset + amount - 1) // 48 + 1))
            pos += amount
        assert pos == frame_start + frame_size
        main = {'script_cast': unpack(state, 0, 'H')[0], 'script_member': unpack(state, 2, 'H')[0],
                'script_detail_index': unpack(state, 4, 'I')[0],
                'tempo_raw': state[54], 'tempo_cue': unpack(state, 52, 'H')[0],
                'transition': list(unpack(state, 96, 'HH')),
                'sound2': list(unpack(state, 144, 'HH')), 'sound1': list(unpack(state, 192, 'HH')),
                'palette': list(unpack(state, 240, 'hh')), 'raw': state[:288].hex()}
        updates = [sprite(state[n * 48:(n + 1) * 48], n - 5) for n in sorted(changed) if n >= 6]
        frames.append({'frame': len(frames) + 1, 'main': main, 'sprite_updates': updates})
    used_details = {f['main']['script_detail_index'] for f in frames}
    used_details.update(s['detail_index'] for f in frames for s in f['sprite_updates'])
    spans = []
    for i in sorted(used_details - {0}):
        assert i + 2 < len(detail), i
        raw = detail[i]
        if len(raw) < 40:
            spans.append({'index': i, 'unparsed': True, 'raw': raw.hex()})
            continue
        values = unpack(raw, 0, '10i')
        span = dict(zip(['start_frame', 'end_frame', 'xtra_info', 'flags', 'channel',
                         'curvature', 'tween_flags', 'ease_in', 'ease_out', 'padding'], values))
        span.update(index=i, name=detail[i + 2].rstrip(b'\0').decode('mac_roman'),
                    keyframes=list(unpack(raw, 40, f'{(len(raw) - 40) // 4}i')), behaviors=[])
        assert len(detail[i + 1]) % 8 == 0
        for at in range(0, len(detail[i + 1]), 8):
            cast, member, initializer = unpack(detail[i + 1], at, 'hhI')
            span['behaviors'].append({'cast': cast, 'member': member, 'initializer_index': initializer,
                                      'initializer': detail[initializer].rstrip(b'\0').decode('mac_roman') if initializer else ''})
        spans.append(span)
    return {'format': 'Director 7 authored score; carry sprite updates forward frame by frame',
            'limitations': 'Does not execute Lingo, apply puppet changes, resolve tween interpolation, or render ink effects. Raw control/detail data retained.',
            'header': dict(zip(['size', 'frame_offset', 'declared_frames', 'frame_version',
                                'sprite_record_size', 'channel_records', 'displayed_channels'], header)),
            'actual_frames': len(frames), 'frames': frames, 'spans': spans,
            'detail_records': [{'index': i, 'offset': base + offsets[i], 'length': len(raw), 'raw': raw.hex()}
                               for i, raw in enumerate(detail)]}


def index_movie(item, output):
    folder = ROOT / item['dump']
    chunks = folder / 'chunks'
    js = {p.stem: load(p) for p in chunks.glob('*.json')}
    def first(tag, fallback=None):
        return next((v for k, v in js.items() if k.startswith(tag + '-')), fallback)
    config = first('DRCF')
    keys = first('KEY_')['entries']
    casts = first('MCsL', {}).get('entries', [])
    if not casts:
        casts = [{'name': 'External', 'filePath': '', 'id': 1024, 'minMember': config['minMember'], 'maxMember': config['maxMember']}]
    members, scripts = [], []
    for cast_number, cast in enumerate(casts, 1):
        if cast['filePath']:
            continue
        cas = next((e['sectionID'] for e in keys if e['castID'] == cast['id'] and e['fourCC'] == 'CAS*'), None)
        if cas is None:
            continue
        ctx_id = next((e['sectionID'] for e in keys if e['castID'] == cast['id'] and e['fourCC'] in ('Lctx', 'LctX')), None)
        ctx = js.get(f'Lctx-{ctx_id}', {})
        for slot, chunk_id in enumerate(js[f'CAS_-{cas}']['memberIDs'], cast['minMember']):
            if chunk_id <= 0:
                continue
            info = js[f'CASt-{chunk_id}']
            metadata = info.get('info') or {}
            sid = metadata.get('scriptId', 0)
            script_chunk = ctx['sectionMap'][sid - 1]['sectionID'] if sid and sid <= len(ctx.get('sectionMap', [])) else None
            members.append({'cast_number': cast_number, 'cast_name': mac(cast['name']), 'member': slot,
                            'chunk_id': chunk_id, 'type': TYPES.get(info['type'], str(info['type'])),
                            'type_id': info['type'], 'name': mac(metadata.get('name', '')),
                            'script_chunk': script_chunk,
                            'children': [e for e in keys if e['castID'] == chunk_id]})
    for key, script in js.items():
        if not key.startswith('Lscr-'):
            continue
        sid = int(key.split('-')[1])
        context = next(v for k, v in js.items() if k.startswith('Lctx-') and any(e['sectionID'] == sid for e in v['sectionMap']))
        names = js[f'Lnam-{context["lnamSectionID"]}']['names']
        def name(n):
            return mac(names[n]) if 0 <= n < len(names) else f'UNRESOLVED_NAME_ID({n})'
        text = (folder / 'scripts-by-chunk' / (key + '.ls')).read_text(errors='replace')
        scripts.append({'chunk_id': sid, 'path': str((folder / 'scripts-by-chunk' / (key + '.ls')).relative_to(ROOT)),
                        'handler_names': [name(h['nameID']) for h in script['handlers']],
                        'globals': [name(n) for n in script['globalNameIDs']],
                        'properties': [name(n) for n in script['propertyNameIDs']],
                        'source_lines': len(text.splitlines()), 'bytecode_handlers': script['handlersCount'],
                        'bindings': [m for m in members if m['script_chunk'] == sid]})
    filename = Path(item['input']).name
    key = folder.name if folder.parent.name == 'decompiled' else folder.parent.name
    report = {'name': key, 'input': item['input'], 'config': config,
              'cast_libraries': [{**c, 'name': mac(c['name']), 'filePath': mac(c['filePath'])} for c in casts],
              'member_types': dict(collections.Counter(m['type'] for m in members)),
              'members': members, 'scripts': scripts, 'labels': []}
    for path in chunks.glob('VWLB-*.bin'):
        report['labels'] = labels(path.read_bytes())
    for path in chunks.glob('VWSC-*.bin'):
        timeline = score(path.read_bytes())
        timeline['labels'] = report['labels']
        score_file = output / 'scores' / (key + '.json')
        score_file.parent.mkdir(parents=True, exist_ok=True)
        score_file.write_text(json.dumps(timeline, ensure_ascii=False, separators=(',', ':')) + '\n')
        report['score'] = {'path': str(score_file.relative_to(ROOT)), 'frames': timeline['actual_frames'],
                           'spans': len(timeline['spans'])}
    report['filmloops'] = []
    for path in chunks.glob('SCVW-*.bin'):
        timeline = score(path.read_bytes())
        dest = output / 'filmloops' / key / (path.stem + '.json')
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(json.dumps(timeline, ensure_ascii=False, separators=(',', ':')) + '\n')
        report['filmloops'].append({'chunk_id': int(path.stem.split('-')[1]),
                                   'frames': timeline['actual_frames'], 'path': str(dest.relative_to(ROOT))})
    report['texts'] = []
    for path in chunks.glob('STXT-*.bin'):
        raw = path.read_bytes()
        offset, length, trailer_length = unpack(raw, 0, 'III')
        assert offset + length + trailer_length == len(raw)
        text = raw[offset:offset + length].decode('mac_roman')
        dest = output / 'text' / key / (path.stem + '.txt')
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(text, encoding='utf-8')
        report['texts'].append({'chunk_id': int(path.stem.split('-')[1]), 'text': text,
                               'encoding': 'mac_roman', 'style_data_hex': raw[offset + length:].hex(),
                               'path': str(dest.relative_to(ROOT))})
    (output / 'movies' / (key + '.json')).write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
    return {k: v for k, v in report.items() if k not in ('members', 'scripts') } | {
        'script_resources': len(scripts), 'handlers': sum(s['bytecode_handlers'] for s in scripts),
        'source_lines': sum(s['source_lines'] for s in scripts)}


def main():
    output = ROOT / 'artifacts/analysis'
    (output / 'movies').mkdir(parents=True, exist_ok=True)
    reports = [index_movie(item, output) for item in load(ROOT / 'artifacts/decompilation-manifest.json')]
    (output / 'inventory.json').write_text(json.dumps(reports, ensure_ascii=False, indent=2) + '\n')
    print(f'{len(reports)} containers indexed; {sum(r["script_resources"] for r in reports)} scripts; '
          f'{sum(r["handlers"] for r in reports)} handlers; {sum(r.get("score", {}).get("frames", 0) for r in reports)} score frames; '
          f'{sum(f["frames"] for r in reports for f in r["filmloops"])} filmloop frames')


if __name__ == '__main__':
    main()
