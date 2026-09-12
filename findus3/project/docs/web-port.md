# Web reference port

The port executes the original Director 7 movies and Lingo bytecode in a patched
[DirPlayer](https://github.com/igorlira/dirplayer-rs) Rust/WebAssembly runtime.
The game logic, recorded German dialogue, images, timeline and original controls
come from the supplied disc. No Flash plugin, Windows executable or server-side
emulator is involved.

## Run

The local build is in `dist/web/`:

```sh
python3 scripts/serve_web.py
```

Open http://127.0.0.1:8766/ and press **Spielen**. The first gesture enables audio.
The checked calendar option makes all 24 days available. Uncheck it before
starting to use the original calendar's date rules.

Mouse, touch, and physical keyboards are supported. **Tasten** opens an on-screen
keypad and appears automatically on touch devices; several keys can be held at
once. **Vollbild** keeps the game and keypad together, with a browser-sized fallback
where the native fullscreen API is unavailable. **Ton an/aus** mutes output without
stopping the game's sound clock or its narration-dependent scripts.

For a phone or tablet on the same local network, run with `--host 0.0.0.0` and open
`http://<your-computer-LAN-address>:8766/` on that device. The computer must remain
running. Alternatively, put the complete `dist/web/` directory on a static web
server. HTTP(S) is required; opening `index.html` directly as a file does not load
WebAssembly and movie fetches correctly. No account, backend API, CDN or external
runtime download is required by the built player.

The original stage is 640×480. It scales to the device without changing game
coordinates. Touch input supplies the short hover/press intervals required by
original polling menus; pointer capture keeps a drag held outside the stage.
Controls are released on cancellation, focus loss and backgrounding.

## Rebuild

First recover the local game data as described in the repository README. Install
Git, Python 3, Rust/rustup, and the matching wasm-bindgen CLI:

```sh
rustup target add wasm32-unknown-unknown
cargo install wasm-bindgen-cli --version 0.2.108 --locked
python3 scripts/build_runtime.py
```

`tools-lock.json` pins the runtime revision and patch. `build_runtime.py` checks
that revision, applies the patch and builds the WASM, then assembles the static
site. `--release` selects Rust's release profile; the normal development profile
is already optimized. `build_web.py` can reassemble the site after web-shell-only
changes without recompiling Rust.

When developing runtime changes, save the complete patch before a clean rebuild:

```sh
python3 scripts/freeze_runtime.py
python3 scripts/build_runtime.py
python3 scripts/package_web.py
```

The package command creates `dist/findus-web.zip`, a SHA-256 inventory and the
matching modified runtime source archive under `dist/web/source/`. The build
records the compiler version, profile, exact runtime source hashes and generated
JS/WASM hashes in `engine/build-info.json`; packaging checks those against the
current files and rejects stale binaries or web-shell files. It does not
publish anything. The engine is GPL-3.0-only; the original game content has its
own copyright and is separate from that license. Keep the matching source and
license with any distributed runtime package.

To rebuild from an unpacked web package, extract
`source/dirplayer-findus.tar.gz`. It contains a single `findus-port/` directory
with the complete already-patched runtime in its expected build location,
licenses, build scripts and a verified source snapshot; a Git checkout is not
required for this archive. Install Rust and wasm-bindgen as above, then run:

```sh
cd findus-port
python3 scripts/build_runtime.py --game-dir /absolute/path/to/findus-web/game
python3 scripts/serve_web.py
```

This reuses the original containers included in the web package, so disc
recovery is not needed again. `--game-dir` also works with `build_web.py` when
reassembling a changed shell. The recorded compiler version in the package's
`engine/build-info.json` identifies the original toolchain. Standard Rust
package dependencies are restored from the included Cargo lockfile.

The unpacked runnable ZIP includes `README.txt` and `scripts/serve_web.py`; from
its `findus-web/` directory, `python3 scripts/serve_web.py` starts the local game.

## Runtime changes

Compatibility work covers legacy sound-channel properties; PCM decoding and
sound scheduling; original date, path and filename rules; MacRoman cast metadata;
PICT and bitmap decoding; rollover and collision behavior; movie-change state
reset; queued mouse input; frame/event dispatch; and cooperative yielding from
Lingo polling loops. The original DXR/CXT bytes are unchanged.

Detailed evidence is in `docs/audio-runtime.md`, `docs/runtime-graphics.md`,
`artifacts/runtime-tests/` and the runnable probes under `runtime/dirplayer/`.
Playthroughs use actual browser input. Where a puzzle is randomized, tests read
its original state to choose the correct inputs; they do not set the winning
state. Static asset comparisons and native script probes provide independent
checks, but do not replace interactive playthroughs.

All 24 activities and all three construction projects have interactive
playthrough evidence, including full narrated stories, timed rounds, puzzle
completion and calendar navigation. The [validation report](playability.md)
lists the exact paths exercised and links their saved results. Cross-browser
checks cover Chromium, Firefox and WebKit; touch playthroughs cover emulated
phone and tablet profiles. Physical device hardware and every possible random
layout or input timing have not been exhaustively tested.
