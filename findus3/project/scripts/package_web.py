#!/usr/bin/env python3
"""Package the local web port and its matching GPL runtime source.

Run freeze_runtime.py and build_runtime.py first. The ZIP includes proprietary
content extracted from the supplied disc; this command does not publish it.
"""
from pathlib import Path
import io
import json
import shutil
import subprocess
import tarfile
import zipfile
from freeze_runtime import SNAPSHOT, sha256, source_files, source_hashes, verify_snapshot

ROOT=Path(__file__).resolve().parents[1]
SOURCE=ROOT/'tools/runtime-options/dirplayer-rs'
WEB=ROOT/'dist/web'

def main():
    lock=json.loads((ROOT/'tools-lock.json').read_text())
    runtime=lock['dirplayer'];patch=ROOT/runtime['patch']
    if (SOURCE/'.git').exists():
        revision=subprocess.check_output(['git','rev-parse','HEAD'],cwd=SOURCE,text=True).strip()
        if revision!=runtime['revision']:raise SystemExit('Unexpected runtime revision')
        subprocess.run(['git','apply','--reverse','--check',str(patch)],cwd=SOURCE,check=True)
    else:verify_snapshot(SOURCE,runtime,patch)
    provenance_path=WEB/'engine/build-info.json'
    if not provenance_path.is_file():raise SystemExit('Run build_runtime.py first to record matching runtime source and output hashes.')
    provenance=json.loads(provenance_path.read_text())
    hashes=source_hashes(SOURCE)
    if provenance['source_files']!=hashes or provenance['revision']!=runtime['revision'] or provenance['patch_sha256']!=sha256(patch):
        raise SystemExit('Runtime source/patch changed after the build; run freeze_runtime.py and build_runtime.py again.')
    for name,digest in provenance['outputs'].items():
        if sha256(WEB/'engine'/name)!=digest:raise SystemExit(f'Runtime output changed after build: {name}')
    for src in (ROOT/'web').iterdir():
        if src.is_file() and sha256(src)!=sha256(WEB/src.name):raise SystemExit('Web shell changed; run build_web.py again.')
    source_dir=WEB/'source';source_dir.mkdir(exist_ok=True)
    archive=source_dir/'dirplayer-findus.tar.gz'
    snapshot={'revision':runtime['revision'],'patch_sha256':sha256(patch),'files':hashes}
    with tarfile.open(archive,'w:gz') as tar:
        for name in source_files(SOURCE):
            tar.add(SOURCE/name,arcname='findus-port/tools/runtime-options/dirplayer-rs/'+name,recursive=False)
        data=(json.dumps(snapshot,indent=2)+'\n').encode()
        info=tarfile.TarInfo('findus-port/tools/runtime-options/dirplayer-rs/'+SNAPSHOT);info.size=len(data)
        tar.addfile(info,io.BytesIO(data))
        for path in [ROOT/'tools-lock.json',patch,*sorted((ROOT/'web').glob('*')),*sorted((ROOT/'scripts').glob('*web*.py')),ROOT/'scripts/build_runtime.py',ROOT/'scripts/freeze_runtime.py',*sorted((ROOT/'docs').glob('*.md')),*sorted((ROOT/'runtime/dirplayer').glob('*')),ROOT/'LICENSES/GPL-3.0.txt']:
            if path.is_file():tar.add(path,arcname='findus-port/'+str(path.relative_to(ROOT)),recursive=False)
    (source_dir/'README.txt').write_text('Complete modified DirPlayer source and build scripts are in dirplayer-findus.tar.gz.\nUnpack it, then follow findus-port/docs/web-port.md.\nRuntime license: GPL-3.0-only; see findus-port/tools/runtime-options/dirplayer-rs/LICENSE.\nSource revision, patch and per-file hashes are included. Original game data stays separate.\nUse --game-dir /absolute/path/to/findus-web/game when rebuilding from this package.\n')
    (WEB/'scripts').mkdir(exist_ok=True)
    shutil.copy2(ROOT/'scripts/serve_web.py',WEB/'scripts/serve_web.py')
    (WEB/'README.txt').write_text('Findus web reference port\n\nRun: python3 scripts/serve_web.py\nOpen http://127.0.0.1:8766/ and press Spielen.\nOr serve this entire directory with any static HTTP server; file:// is unsupported.\nFor LAN testing add --host 0.0.0.0.\nMatching runtime source and rebuild instructions: source/README.txt\nRuntime: GPL-3.0-only. Original game content has its own copyright.\n')
    manifest={str(p.relative_to(WEB)):sha256(p) for p in sorted(WEB.rglob('*')) if p.is_file() and p.name!='sha256.json'}
    (WEB/'sha256.json').write_text(json.dumps(manifest,indent=2)+'\n')
    zip_path=ROOT/'dist/findus-web.zip'
    with zipfile.ZipFile(zip_path,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=6) as archive:
        for path in sorted(WEB.rglob('*')):
            if path.is_file():archive.write(path,'findus-web/'+str(path.relative_to(WEB)))
    print(f'Packaged {zip_path} ({zip_path.stat().st_size:,} bytes) with matching runtime source.')

if __name__=='__main__':main()
