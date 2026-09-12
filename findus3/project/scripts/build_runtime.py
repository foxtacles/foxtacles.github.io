#!/usr/bin/env python3
"""Build the pinned, patched open-source Director runtime for the web port.

Requires Git, Rust/rustup and wasm-bindgen-cli 0.2.108. All game data stays local.
"""
from pathlib import Path
import argparse
import json
import os
import shutil
import subprocess
import sys
from freeze_runtime import sha256, source_hashes, verify_snapshot

ROOT=Path(__file__).resolve().parents[1]
TOOLS=ROOT/'tools/runtime-options'
SOURCE=TOOLS/'dirplayer-rs'

def run(args,**kwargs):
    print('+ '+' '.join(map(str,args)),flush=True)
    return subprocess.run(list(map(str,args)),check=True,**kwargs)

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--release',action='store_true',help='Build optimized WASM (slower first build).')
    parser.add_argument('--game-dir',type=Path,help='Reuse a packaged game/ directory instead of recovering the disc again.')
    args=parser.parse_args()
    lock=json.loads((ROOT/'tools-lock.json').read_text())['dirplayer']
    if not SOURCE.exists():
        TOOLS.mkdir(parents=True,exist_ok=True)
        run(['git','clone',lock['repository'],SOURCE])
        run(['git','checkout',lock['revision']],cwd=SOURCE)
    patch=ROOT/lock['patch']
    if (SOURCE/'.git').exists():
        revision=subprocess.check_output(['git','rev-parse','HEAD'],cwd=SOURCE,text=True).strip()
        if revision != lock['revision']:raise SystemExit('Runtime revision differs from tools-lock.json; use a fresh checkout.')
        if subprocess.run(['git','apply','--reverse','--check',str(patch)],cwd=SOURCE,capture_output=True).returncode:
            run(['git','apply','--check',patch],cwd=SOURCE)
            run(['git','apply',patch],cwd=SOURCE)
    else:
        verify_snapshot(SOURCE,lock,patch)
    inputs=source_hashes(SOURCE)
    env=os.environ.copy()
    if (TOOLS/'cargo/bin/rustup').exists():
        env['CARGO_HOME']=str(TOOLS/'cargo')
        env['RUSTUP_HOME']=str(TOOLS/'rustup')
        env['PATH']=str(TOOLS/'cargo/bin')+os.pathsep+env.get('PATH','')
    cargo=shutil.which('cargo',path=env['PATH'])
    rustup=shutil.which('rustup',path=env['PATH'])
    if not cargo or not rustup:raise SystemExit('Install Rust with rustup, then rerun this script.')
    run([rustup,'target','add','wasm32-unknown-unknown'],env=env)
    command=[cargo,'build','--locked','--manifest-path','vm-rust/Cargo.toml','--target','wasm32-unknown-unknown']
    if args.release:command.append('--release')
    run(command,cwd=SOURCE,env=env)
    bindgen=shutil.which('wasm-bindgen',path=env['PATH'])
    if not bindgen:
        candidates=list(TOOLS.glob('wasm-bindgen-0.2.108-*/wasm-bindgen'))
        if candidates:bindgen=str(candidates[0])
    if not bindgen:raise SystemExit('Install the matching CLI: cargo install wasm-bindgen-cli --version 0.2.108 --locked')
    version=subprocess.check_output([bindgen,'--version'],text=True).strip()
    if version!='wasm-bindgen 0.2.108':raise SystemExit(f'Expected wasm-bindgen 0.2.108, got {version}')
    profile='release' if args.release else 'debug'
    run([bindgen,f'vm-rust/target/wasm32-unknown-unknown/{profile}/vm_rust.wasm','--out-dir','vm-rust/pkg','--target','web'],cwd=SOURCE,env=env)
    if inputs!=source_hashes(SOURCE):raise SystemExit('Runtime source changed while building; rerun for a matching binary.')
    outputs={name:sha256(SOURCE/'vm-rust/pkg'/name) for name in ('vm_rust.js','vm_rust_bg.wasm')}
    outputs['dirplayer-js-api.js']=sha256(SOURCE/'dirplayer-js-api/index.js')
    outputs['charmap-system.png']=sha256(SOURCE/'public/charmap-system.png')
    rustc=shutil.which('rustc',path=env['PATH'])
    provenance={'revision':lock['revision'],'patch_sha256':sha256(patch),'source_files':inputs,
        'rustc':subprocess.check_output([rustc,'--version'],env=env,text=True).strip(),
        'wasm_bindgen':version,'profile':profile,'target':'wasm32-unknown-unknown','outputs':outputs}
    (SOURCE/'vm-rust/pkg/findus-build.json').write_text(json.dumps(provenance,indent=2)+'\n')
    command=[sys.executable,ROOT/'scripts/build_web.py']
    if args.game_dir:command.extend(['--game-dir',args.game_dir.resolve()])
    run(command)

if __name__=='__main__':main()
