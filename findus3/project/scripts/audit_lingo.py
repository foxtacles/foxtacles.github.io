#!/usr/bin/env python3
"""Independently audit recovered D7 Lingo headers and instruction coverage.

Reads original dumped Lscr/Lnam bytes, then compares ProjectorRays JSON,
source, and disassembly. This establishes structural coverage, not semantic
equivalence of reconstructed source or correctness of opcode interpretation.
"""
import collections
import hashlib
import json
import re
import struct
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
HANDLER = struct.Struct('>hHIIHIHIHIIHHI')
FIELDS = ('nameID', 'vectorPos', 'compiledLen', 'compiledOffset',
          'argumentCount', 'argumentOffset', 'localsCount', 'localsOffset',
          'globalsCount', 'globalsOffset', 'unknown1', 'unknown2',
          'lineCount', 'lineOffset')
HEADER = re.compile(rb'^(?:on|method) ([^\s,]+)', re.M)
INSTRUCTION = re.compile(rb'^  \[\s*(\d+)\]', re.M)


def load(path):
    return json.loads(path.read_text())


def names(raw):
    offset, count = struct.unpack_from('>HH', raw, 16)
    result = []
    for _ in range(count):
        length = raw[offset]
        offset += 1
        value = raw[offset:offset + length]
        assert len(value) == length, 'Truncated Lnam entry'
        result.append(value)
        offset += length
    return result


def main():
    totals = collections.Counter()
    errors, resources, non_utf8 = [], [], []

    def check(condition, resource, reason):
        if not condition:
            errors.append({'resource': resource, 'reason': reason})

    manifest = load(ROOT / 'artifacts/decompilation-manifest.json')
    for movie in manifest:
        folder = ROOT / movie['dump']
        chunks = folder / 'chunks'
        contexts = [load(p) for p in sorted(chunks.glob('Lctx-*.json'))]
        contexts += [load(p) for p in sorted(chunks.glob('LctX-*.json'))]
        raw_paths = sorted(chunks.glob('Lscr-*.bin'))
        expected = {p.stem for p in raw_paths}
        for extension in ('ls', 'lasm'):
            actual = {p.stem for p in (folder / 'scripts-by-chunk').glob('*.' + extension)}
            check(expected == actual, movie['dump'], f'{extension} resource set differs')
        totals['containers'] += 1
        for path in raw_paths:
            resource = str(path.relative_to(ROOT))
            raw = path.read_bytes()
            record = {'resource': resource, 'sha256': hashlib.sha256(raw).hexdigest()}
            try:
                count, offset = struct.unpack_from('>HI', raw, 72)
                check(offset + count * HANDLER.size <= len(raw), resource, 'Handler table outside resource')
                decoded = load(path.with_suffix('.json'))
                check(count == decoded['handlersCount'] == len(decoded['handlers']), resource, 'JSON handler count differs')
                check(offset == decoded['handlersOffset'], resource, 'JSON handler table offset differs')
                source_path = folder / 'scripts-by-chunk' / (path.stem + '.ls')
                source = source_path.read_bytes()
                assembly = source_path.with_suffix('.lasm').read_bytes()
                source_headers = list(HEADER.finditer(source))
                asm_headers = list(HEADER.finditer(assembly))
                check(len(source_headers) == count, resource, 'Source handler count differs')
                check(len(asm_headers) == count, resource, 'Disassembly handler count differs')
                try:
                    source.decode('utf-8')
                except UnicodeDecodeError:
                    non_utf8.append(str(source_path.relative_to(ROOT)))
                script_id = int(path.stem.split('-')[1])
                owners = [c for c in contexts if any(e['sectionID'] == script_id for e in c['sectionMap'])]
                check(len(owners) == 1, resource, 'Script does not have exactly one name-table context')
                script_names = names((chunks / f'Lnam-{owners[0]["lnamSectionID"]}.bin').read_bytes())
                byte_count = instruction_count = 0
                for index in range(count):
                    header = dict(zip(FIELDS, HANDLER.unpack_from(raw, offset + index * HANDLER.size)))
                    check(header == decoded['handlers'][index], resource, f'Handler {index} JSON metadata differs')
                    name = script_names[header['nameID']]
                    if index < len(source_headers):
                        check(name == source_headers[index].group(1), resource, f'Handler {index} source name differs from raw Lnam')
                    if index < len(asm_headers):
                        check(name == asm_headers[index].group(1), resource, f'Handler {index} disassembly name differs from raw Lnam')
                    start, length = header['compiledOffset'], header['compiledLen']
                    check(start + length <= len(raw), resource, f'Handler {index} bytecode outside resource')
                    code = raw[start:start + length]
                    cursor, offsets = 0, []
                    while cursor < len(code):
                        offsets.append(cursor)
                        opcode = code[cursor]
                        cursor += 5 if opcode >= 0xc0 else 3 if opcode >= 0x80 else 2 if opcode >= 0x40 else 1
                    check(cursor == length, resource, f'Handler {index} truncated instruction')
                    if index < len(asm_headers):
                        end = asm_headers[index + 1].start() if index + 1 < len(asm_headers) else len(assembly)
                        observed = [int(m.group(1)) for m in INSTRUCTION.finditer(assembly[asm_headers[index].end():end])]
                        check(observed == offsets, resource, f'Handler {index} instruction offsets differ')
                    instruction_count += len(offsets)
                    byte_count += length
                record.update(handlers=count, source_handlers=len(source_headers),
                              disassembly_handlers=len(asm_headers), instructions=instruction_count,
                              compiled_bytes=byte_count, source_bytes=len(source),
                              disassembly_bytes=len(assembly))
                totals.update(script_resources=1, handlers=count, source_handlers=len(source_headers),
                              disassembly_handlers=len(asm_headers), instructions=instruction_count,
                              compiled_bytes=byte_count, zero_handler_resources=int(count == 0),
                              empty_source_files=int(not source), empty_disassembly_files=int(not assembly))
            except (IndexError, KeyError, ValueError, OSError, struct.error, AssertionError) as error:
                errors.append({'resource': resource, 'reason': str(error)})
            resources.append(record)
    result = {'status': 'pass' if not errors else 'fail', 'totals': dict(totals),
              'scope': 'D7 raw handler metadata, raw Lnam handler names, source/disassembly handler coverage, and instruction byte-offset coverage. Does not establish source semantic equivalence or independently validate instruction mnemonics/operands.',
              'non_utf8_source_files': non_utf8, 'errors': errors, 'resources': resources}
    output = ROOT / 'artifacts/lingo-audit.json'
    output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k: v for k, v in result.items() if k != 'resources'}, indent=2))
    if errors:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
