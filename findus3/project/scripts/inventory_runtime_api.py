#!/usr/bin/env python3
"""Inventory actual recovered opcode/API use against the portable runtime.

Static routing coverage is not behavioral compatibility. Calls classified as
script-defined may still fail if the declaring library is not loaded/reachable.
"""
import collections
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VM = ROOT / 'tools/runtime-options/dirplayer-rs/vm-rust/src'


def main():
    ops, calls, properties = (collections.Counter() for _ in range(3))
    sites = collections.defaultdict(list)
    declarations = set()
    manifest = json.loads((ROOT / 'artifacts/decompilation-manifest.json').read_text())
    for movie in manifest:
        folder = ROOT / movie['dump']
        contexts = [json.loads(p.read_text()) for p in (folder / 'chunks').glob('Lctx-*.json')]
        contexts += [json.loads(p.read_text()) for p in (folder / 'chunks').glob('LctX-*.json')]
        for path in sorted((folder / 'scripts-by-chunk').glob('*.lasm')):
            text = path.read_bytes().decode('latin1')
            declarations.update(name.lower() for name in re.findall(r'^(?:on|method) ([^ ,\r\n]+)', text, re.M))
            chunk_id = int(path.stem.split('-')[1])
            context = next(c for c in contexts if any(e['sectionID'] == chunk_id for e in c['sectionMap']))
            names = json.loads((folder / 'chunks' / f'Lnam-{context["lnamSectionID"]}.json').read_text())['names']
            for opcode, arg in re.findall(r'^  \[\s*\d+\] (\w+)(?: (\d+))?', text, re.M):
                ops[opcode] += 1
                if opcode not in ('extcall', 'thebuiltin', 'getmovieprop', 'setmovieprop'):
                    continue
                name = names[int(arg)].lower()
                target = calls if opcode == 'extcall' else properties
                target[name] += 1
                site = str(path.relative_to(ROOT))
                if site not in sites[name]:
                    sites[name].append(site)
    symbols = dict((name.lower(), symbol) for name, symbol in re.findall(
        r'"([^"]+)"\s*=>\s*(\w+)', (VM / 'player/symbols/builtin.rs').read_text()))
    opcode_symbols = dict((name, symbol) for symbol, name in re.findall(
        r'\(OpCode::(\w+), "([^"]+)"', (VM / 'director/lingo/constants.rs').read_text()))
    dispatch = (VM / 'player/bytecode/handler_manager.rs').read_text()
    manager = (VM / 'player/handlers/manager.rs').read_text()

    def call_record(name, count):
        symbol = symbols.get(name)
        route = ('script-defined' if name in declarations else
                 'VM control flow' if name == 'return' else
                 'builtin dispatcher' if symbol and re.search(r'\bBuiltInSymbol::' + symbol + r'\b', manager) else
                 'requires dynamic/Xtra resolution')
        return {'name_bytes_latin1': name, 'instructions': count, 'symbol': symbol,
                'static_route': route, 'source_files': sites[name]}

    report = {
        'scope': 'All canonical Lingo disassembly. Static dispatch presence, not executed compatibility; counts include dormant handlers and both embedded startup copies.',
        'opcodes': [{'mnemonic': name, 'instructions': count,
                     'runtime_enum': opcode_symbols.get(name),
                     'present_in_dispatch': bool(opcode_symbols.get(name) and re.search(
                         r'\bOpCode::' + opcode_symbols[name] + r'\b', dispatch))}
                    for name, count in sorted(ops.items())],
        'external_calls': [call_record(name, count) for name, count in sorted(calls.items())],
        'global_properties': [{'name': name, 'instructions': count, 'symbol': symbols.get(name),
                               'source_files': sites[name]} for name, count in sorted(properties.items())],
    }
    output = ROOT / 'artifacts/analysis/runtime-api.json'
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, indent=2) + '\n')
    print(f'{len(ops)} opcode kinds; {len(calls)} external-call names; {len(properties)} named global properties')
    print('Opcodes missing from dispatch:', [op['mnemonic'] for op in report['opcodes'] if not op['present_in_dispatch']])
    print('Calls requiring dynamic/Xtra resolution:', [c['name_bytes_latin1'] for c in report['external_calls'] if c['static_route'] == 'requires dynamic/Xtra resolution'])


if __name__ == '__main__':
    main()
