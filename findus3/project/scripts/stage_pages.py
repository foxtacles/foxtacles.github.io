#!/usr/bin/env python3
"""Stage the complete Findus web build in a checkout of foxtacles.github.io.

This prepares files only. Review and commit the checkout, then push its main
branch to publish through the repository's existing GitHub Pages configuration.
"""
from pathlib import Path
import argparse
import hashlib
import json
import shutil

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--checkout', type=Path, required=True)
    args = parser.parse_args()
    checkout = args.checkout.resolve()
    if not (checkout / '.git').exists():
        raise SystemExit('The destination must be a Git checkout.')
    source = ROOT / 'dist/web'
    manifest = json.loads((source / 'sha256.json').read_text())
    for name, digest in manifest.items():
        if hashlib.sha256((source / name).read_bytes()).hexdigest() != digest:
            raise SystemExit(f'Package changed: {name}. Run package_web.py again.')
    destination = checkout / 'findus3'
    shutil.copytree(source, destination, dirs_exist_ok=True)
    shutil.copy2(ROOT / 'dist/findus-web.zip', destination / 'findus-web.zip')
    project = destination / 'project'
    files = [ROOT / name for name in (
        'README.md', '.gitignore', 'requirements.txt', 'tools-lock.json',
        'CD01.ccd', 'CD01.cue',
    )]
    for folder in ('web', 'scripts', 'runtime', 'docs', 'patches', 'LICENSES'):
        files.extend((ROOT / folder).rglob('*'))
    files.extend((ROOT / 'artifacts/decompiled').glob('*/scripts-by-chunk/*'))
    files.extend((ROOT / 'artifacts/analysis').rglob('*'))
    files.extend((ROOT / 'artifacts').glob('*.json'))
    for path in files:
        if not path.is_file() or '__pycache__' in path.parts or path.name == '.DS_Store':
            continue
        target = project / path.relative_to(ROOT)
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, target)
    (destination / '.nojekyll').touch()
    sizes = [p.stat().st_size for p in destination.rglob('*') if p.is_file()]
    if max(sizes) >= 100 * 1024 * 1024:
        raise SystemExit('A staged file exceeds GitHub regular Git limits.')
    if sum(sizes) >= 1024 * 1024 * 1024:
        raise SystemExit('The staged site exceeds the GitHub Pages size limit.')
    print(f'Staged {len(sizes)} files ({sum(sizes):,} bytes) at {destination}')


if __name__ == '__main__':
    main()
