#!/usr/bin/env python3
"""Recover scripts and editable Director containers using pinned, patched ProjectorRays."""
import hashlib
import json
import shutil
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main():
    exe = ROOT / 'tools/ProjectorRays/projectorrays'
    base = ROOT / 'artifacts/decompiled'
    logs = ROOT / 'artifacts/logs'
    logs.mkdir(parents=True, exist_ok=True)
    inputs = [(p, base) for p in sorted((ROOT / 'artifacts/disc/MAIN').iterdir())
              if p.suffix.upper() in ('.DXR', '.CXT')]
    inputs += [(ROOT / 'artifacts/projector/Start.dir', base / 'projector'),
               (ROOT / 'artifacts/mac/projector/Start.dir', base / 'mac-projector')]
    manifest = []
    for source, dest in inputs:
        if not source.exists():
            raise FileNotFoundError(source)
        dest.mkdir(parents=True, exist_ok=True)
        # Recreate every generated dump so stale chunks cannot satisfy coverage.
        dump_dir = dest / source.stem
        if dump_dir.exists():
            shutil.rmtree(dump_dir)
        command = [str(exe), 'decompile', str(source), '-o', str(dest),
                   '--dump-scripts', '--dump-chunks', '--dump-json']
        output_file = dest / (source.stem + ('_decompiled' if source.suffix.lower() == '.dir' else '') + '.dir')
        output_file.unlink(missing_ok=True)
        result = subprocess.run(command, capture_output=True, text=True)
        log = logs / f'{dest.name}-{source.name}.log'
        log.write_text(result.stdout + result.stderr)
        if result.returncode:
            raise RuntimeError(f'{source.name} failed: see {log}')
        dumped = dest / source.stem
        expected = {p.stem for p in (dumped / 'chunks').glob('Lscr-*.bin')}
        recovered = {p.stem for p in (dumped / 'scripts-by-chunk').glob('*.ls')}
        assert expected == recovered, (source, expected - recovered, recovered - expected)
        for p in dumped.rglob('*.json'):
            json.loads(p.read_text())
        assert output_file.exists()
        # External casts on this disc use MV93 despite CXT suffixes. Supply the
        # conventional authoring extension without modifying their chunk codec.
        editable = ROOT / 'artifacts/editable'
        target = (editable / 'MAIN' / (source.stem + ('.cst' if source.suffix.upper() == '.CXT' else '.dir'))
                  if source.parent.name == 'MAIN' else editable / (dest.name + '-Start.dir'))
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(output_file, target)
        entry = {'input': str(source.relative_to(ROOT)),
                 'input_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
                 'editable': str(target.relative_to(ROOT)),
                 'editable_sha256': hashlib.sha256(target.read_bytes()).hexdigest(),
                 'dump': str(dumped.relative_to(ROOT)), 'script_resources': len(expected),
                 'source_lines': sum(len(p.read_bytes().splitlines()) for p in (dumped / 'scripts-by-chunk').glob('*.ls')),
                 'log': str(log.relative_to(ROOT)), 'returncode': result.returncode}
        manifest.append(entry)
        print(f'{source.name}: {len(expected)} script resources recovered')
    (ROOT / 'artifacts/decompilation-manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print(f'{len(manifest)} containers verified; {sum(m["script_resources"] for m in manifest)} script resources')


if __name__ == '__main__':
    main()
