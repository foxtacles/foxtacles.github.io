#!/usr/bin/env python3
"""Save all runtime changes as a patch against the pinned upstream revision."""
from pathlib import Path
import hashlib
import json
import subprocess

ROOT=Path(__file__).resolve().parents[1]
SOURCE=ROOT/'tools/runtime-options/dirplayer-rs'
SNAPSHOT='.findus-source.json'

def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def source_files(source=SOURCE):
    if (source/'.git').exists():
        files=set(filter(None,subprocess.check_output(['git','ls-files','-z'],cwd=source).decode().split('\0')))
        files.update(name for name in subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=source).decode().split('\0') if name.startswith(('vm-rust/src/','vm-rust/examples/')))
    else:
        metadata=json.loads((source/SNAPSHOT).read_text())
        files=set(metadata['files'])
    return sorted(name for name in files if (source/name).is_file())

def source_hashes(source=SOURCE):
    return {name:sha256(source/name) for name in source_files(source)}

def verify_snapshot(source, lock, patch):
    metadata=json.loads((source/SNAPSHOT).read_text())
    if metadata['revision']!=lock['revision'] or metadata['patch_sha256']!=sha256(patch):
        raise SystemExit('Source snapshot does not match the pinned revision and patch.')
    if metadata['files']!=source_hashes(source):
        raise SystemExit('Source snapshot files changed; restore the archive or use a Git checkout.')
    return metadata

def main():
    lock=json.loads((ROOT/'tools-lock.json').read_text())
    revision=subprocess.check_output(['git','rev-parse','HEAD'],cwd=SOURCE,text=True).strip()
    if revision!=lock['dirplayer']['revision']:raise SystemExit('Unexpected upstream revision')
    patch=subprocess.check_output(['git','diff','--binary','HEAD','--'],cwd=SOURCE)
    new=subprocess.check_output(['git','ls-files','--others','--exclude-standard','-z'],cwd=SOURCE).decode().split('\0')
    for name in sorted(filter(None,new)):
        if not name.startswith(('vm-rust/src/','vm-rust/examples/')):continue
        diff=subprocess.run(['git','diff','--no-index','--binary','--','/dev/null',name],cwd=SOURCE,capture_output=True)
        if diff.returncode not in (0,1):raise SystemExit(diff.stderr.decode())
        patch+=diff.stdout
    target=ROOT/'patches/dirplayer-findus.patch'
    target.write_bytes(patch)
    subprocess.run(['git','apply','--reverse','--check',str(target)],cwd=SOURCE,check=True)
    lock['dirplayer']['patch']=str(target.relative_to(ROOT))
    (ROOT/'tools-lock.json').write_text(json.dumps(lock,indent=2)+'\n')
    print(f'Saved {target} ({len(patch):,} bytes); reverse application verified.')

if __name__=='__main__':main()
