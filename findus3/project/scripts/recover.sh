#!/bin/sh
# Run from any directory after scripts/bootstrap.sh.
set -eu
cd "$(dirname "$0")/.."
.venv/bin/python scripts/extract_disc.py
.venv/bin/python scripts/extract_projector.py artifacts/disc/FINDUS3.EXE artifacts/projector
.venv/bin/python scripts/extract_hfs.py artifacts/CD01.iso artifacts/mac --iso-files artifacts/disc
.venv/bin/python scripts/decompile.py
.venv/bin/python scripts/analyze_director.py
.venv/bin/python scripts/verify_artifacts.py
.venv/bin/python scripts/audit_lingo.py
if [ -f scripts/export_media.py ]; then
    .venv/bin/python scripts/export_media.py
fi
.venv/bin/python scripts/export_xmed.py
