#!/usr/bin/env python3
"""Probe original Director movies with freshly compiled open-source DirPlayer.
These are isolated 40-frame startups, not gameplay completion tests.
"""
import argparse,concurrent.futures,json,subprocess
from pathlib import Path
BASE=Path(__file__).resolve().parents[2]
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--out',type=Path,default=BASE/'artifacts/runtime-tests/native')
parser.add_argument('--frames',type=int,default=40)
parser.add_argument('--timeout',type=float,default=12)
args=parser.parse_args()
OUT=args.out.resolve()
GAME=OUT/'aliased-game'
BIN=BASE/'tools/runtime-options/dirplayer-rs/vm-rust/target/debug/examples/findus_probe'
OUT.mkdir(parents=True,exist_ok=True);GAME.mkdir(exist_ok=True)
for src in (BASE/'artifacts/disc/MAIN').iterdir():
    if src.suffix.upper() not in ('.DXR','.CXT'):continue
    for name in (src.name,src.with_suffix('.cct' if src.suffix.upper()=='.CXT' else '.dcr').name):
        dst=GAME/name
        if not dst.exists():dst.symlink_to(src)
movies=['INTRO','KICKER','KALENDER']+[f'DAG{i:02d}' for i in range(1,25)]
def probe(name):
    log=OUT/f'{name}.log';png=OUT/f'{name}.png'
    try:
        p=subprocess.run([str(BIN),str(GAME/f'{name}.DXR'),str(png),str(args.frames)],capture_output=True,text=True,timeout=args.timeout)
        output=p.stdout+'\n'+p.stderr;log.write_text(output)
        line=next((x[6:] for x in p.stdout.splitlines() if x.startswith('PROBE ')),None)
        result={'movie':name,'returncode':p.returncode,'screenshot':str(png.relative_to(BASE)) if png.exists() else None,'state':json.loads(line) if line else None,'errors':[x for x in output.splitlines() if '[ERROR]' in x or 'panicked at' in x or 'Script error' in x]}
    except subprocess.TimeoutExpired as e:
        log.write_bytes((e.stdout or b'')+b'\n'+(e.stderr or b''));result={'movie':name,'timeout_seconds':args.timeout,'state':None,'screenshot':None}
    return result
with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:
    results=list(pool.map(probe,movies))
(OUT/'matrix.json').write_text(json.dumps({'note':f'Patched DirPlayer HEAD, direct entry, external cast suffix aliases, {args.frames} frames, no interaction or launcher globals','results':results},indent=2)+'\n')
for x in results:print(x['movie'],x.get('returncode','timeout'),x.get('state'),x.get('errors',[])[:2])
