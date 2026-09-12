#!/bin/sh
# Prerequisites: Python 3.11+, git, make, C++17 compiler, Boost, mpg123, zlib.
# macOS: brew install boost mpg123
# Debian/Ubuntu: apt install build-essential libboost-dev libmpg123-dev zlib1g-dev xxd python3-venv
set -eu
cd "$(dirname "$0")/.."
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
mkdir -p tools/reference
if [ ! -f tools/reference/scummvm-graphics-data.h ]; then
    curl -fL https://raw.githubusercontent.com/scummvm/scummvm/37007c3660b991e6fddfa5b7e9fde16dab1813a3/engines/director/graphics-data.h \
        -o tools/reference/scummvm-graphics-data.h
fi
revision=6f9bcebf626b43719abe2affcbbcb041d154d666
if [ ! -d tools/ProjectorRays/.git ]; then
    mkdir -p tools
    git clone https://github.com/ProjectorRays/ProjectorRays.git tools/ProjectorRays
    git -C tools/ProjectorRays checkout "$revision"
fi
test "$(git -C tools/ProjectorRays rev-parse HEAD)" = "$revision"
if git -C tools/ProjectorRays apply --reverse --check ../../patches/projectorrays-findus.patch 2>/dev/null; then
    : # Already patched.
else
    git -C tools/ProjectorRays apply --check ../../patches/projectorrays-findus.patch
    git -C tools/ProjectorRays apply ../../patches/projectorrays-findus.patch
fi
findus_cppflags="-DVERSION_NUMBER=0.2.1 -DGIT_SHA=findus"
findus_ldflags=""
if command -v brew >/dev/null 2>&1; then
    findus_prefix=$(brew --prefix)
    findus_cppflags="$findus_cppflags -I$findus_prefix/include"
    findus_ldflags="-L$findus_prefix/lib"
fi
make -C tools/ProjectorRays clean
make -C tools/ProjectorRays -j4 CPPFLAGS="$findus_cppflags" LDFLAGS="$findus_ldflags" LDFLAGS_RELEASE=-Os
