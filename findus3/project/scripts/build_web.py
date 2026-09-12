#!/usr/bin/env python3
"""Assemble the standalone static web port from locally recovered game data."""
from pathlib import Path
import argparse
import json
import shutil

ROOT=Path(__file__).resolve().parents[1]
ENGINE=ROOT/'tools/runtime-options/dirplayer-rs'
OUT=ROOT/'dist/web'

def build(game_dir=None):
    for src in ('vm-rust/pkg/vm_rust.js','vm-rust/pkg/vm_rust_bg.wasm','dirplayer-js-api/index.js','public/charmap-system.png'):
        if not (ENGINE/src).is_file():raise SystemExit(f'Missing engine file: {src}. Build the WASM runtime first.')
    OUT.mkdir(parents=True,exist_ok=True)
    for src in (ROOT/'web').iterdir():
        if src.is_file():shutil.copy2(src,OUT/src.name)
    engine=OUT/'engine';engine.mkdir(exist_ok=True)
    for src,name in [('vm-rust/pkg/vm_rust.js','vm_rust.js'),('vm-rust/pkg/vm_rust_bg.wasm','vm_rust_bg.wasm'),('dirplayer-js-api/index.js','dirplayer-js-api.js'),('public/charmap-system.png','charmap-system.png')]:
        shutil.copy2(ENGINE/src,engine/name)
    provenance=ENGINE/'vm-rust/pkg/findus-build.json'
    if provenance.is_file():shutil.copy2(provenance,engine/'build-info.json')
    game=OUT/'game';(game/'MAIN').mkdir(parents=True,exist_ok=True)
    files={}
    input_main=game_dir/'MAIN' if game_dir else ROOT/'artifacts/disc/MAIN'
    sources=[(game_dir/'start.dir' if game_dir else ROOT/'artifacts/projector/Start.dir','start.dir')]
    sources.extend((src,'MAIN/'+src.name) for src in sorted(input_main.iterdir()) if src.suffix.lower() in ('.dxr','.cxt'))
    for src,relative in sources:
        if src.resolve()!=(game/relative).resolve():shutil.copy2(src,game/relative)
        path=Path(relative)
        extensions=('.dir','.dxr','.dcr') if path.suffix.lower() in ('.dir','.dxr') else ('.cst','.cxt','.cct')
        files[str(path.with_suffix('')).lower()]=relative
        for ext in extensions:files[str(path.with_suffix(ext)).lower()]=relative
    (game/'files.json').write_text(json.dumps(files,indent=2)+'\n')
    shutil.copy2(ROOT/'LICENSES/GPL-3.0.txt',engine/'LICENSE.txt')
    print(f'Built {OUT} ({len(sources)} original Director containers).')

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--game-dir',type=Path,help='Reuse the game/ directory of an unpacked web package.')
    args=parser.parse_args()
    build(args.game_dir.resolve() if args.game_dir else None)
