# Open source runtime assessment

Research and local tests: 2026-09-11. This title is a **Macromedia Director 7 / Lingo** game. A Flash Xtra bundled inside its projector is not evidence that the game itself is an SWF. Director movie/cast files are the right input to compatible interpreters.

## Recommendation

Use **the patched DirPlayer runtime as the browser reference**, with the extracted original DXR/CXT movies and the manifest-based filesystem layer. The local port now renders the calendar, runs the launcher and audio in Chromium, Firefox, and WebKit, and passes original-script gameplay checks. See [audio verification](audio-runtime.md) and [interaction evidence](runtime-interaction-tests.md) for the tested activities and remaining checks. The baseline failures below record the initial investigation and are superseded where the accompanying runtime patches fix them.

Use **ScummVM Director as the independent reference implementation and a possible native/mobile target**. Its source already identifies the German game, but the entry is marked unstable and does not exactly match this disc's Windows projector size. A detection entry is not a compatibility certificate. Both projects have web deployment paths; first establish game compatibility, then choose the production wrapper.

## Pinned evidence

| Component | Examined revision | Local location |
|---|---|---|
| ScummVM source | `37007c3660b991e6fddfa5b7e9fde16dab1813a3` | `tools/runtime-options/scummvm` (sparse checkout) |
| DirPlayer source | `68376fbb4494a6bbad4c70081ecdcb99814a74c9` | `tools/runtime-options/dirplayer-rs` |
| DirPlayer released polyfill | v0.8.1, tag commit `7f632b416b55ec351341feda4db2a444564217aa` | `tools/runtime-options/dirplayer-polyfill-0.8.1` |
| Released ZIP SHA-256 | `6f5000412c50833345a630ade25fb70359dc4e1aae66352c80de7da77542162c` | `tools/runtime-options/dirplayer-polyfill-0.8.1.zip` |
| Patched polyfill SHA-256 | `6b3b9adab664f39cd3d2501d59f6dee6318b67def5fbb3cd223d94c0862fbcdf` | `tools/runtime-options/dirplayer-rs/dist-polyfill/dirplayer-polyfill.js` |

Latest release metadata was read from the official GitHub API; search-engine release snippets lagged behind v0.8.1. Source checkout and released binary are explicitly separate baselines.

## DirPlayer

DirPlayer is a Rust Director interpreter with a WASM target, a React debugger/Electron application, and a self-contained embeddable JavaScript polyfill. Its existing parser, Lingo VM, score, cast members, bitmap compositor, audio, and debugging facilities are directly useful here. This project is GPL-3.0-only. [Project README](https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/README.md), [crate license/build metadata](https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/vm-rust/Cargo.toml), [release v0.8.1](https://github.com/igorlira/dirplayer-rs/releases/tag/v0.8.1).

### Initial baseline browser probes

The local harness loads files through HTTP at `127.0.0.1`; game assets were not uploaded to a third-party service. The old Windows or PowerPC executables were not run. Chromium executed the open source WASM interpreter. These initial results precede the current port. They are startup smoke tests, not completion tests.

| Input/configuration | Observation |
|---|---|
| `INTRO.DXR`, released v0.8.1 | Successfully parses, renders orange publisher-logo artwork, advances its timeline, then requests `kicker.DXR`. The next movie does not produce a playable calendar. |
| `KALENDER.DXR`, v0.8.1, before external-cast aliases | Requests `SHARED.cct` and `DAGAR.cct`, both missing on the original disc path; then displays `Script error: OpCode.kOpGet call not implemented propertyID=1 propertyType=4`. |
| `KALENDER.DXR`, v0.8.1, with aliases | Successfully loads the two external casts. Stage remains predominantly black, with a small numeral `1` at lower left. No completed menu interaction verified. |
| `KALENDER.DXR`, current source + sound-getter patch, with aliases | Builds and loads; same incomplete visible calendar stage. Absence of the former error does not establish overall game correctness. |
| `DAG12.DXR`, current source + patch, direct entry | Parses the movie and external casts; remains black. Two script members with `script_id 0` are skipped with warnings. No playable scene verified. |
| `DAG01.DXR`, v0.8.1 direct entry | Parses its 870 mapped chunks; stage stays black. Direct entry may omit globals and setup from the launcher/calendar, so this is not sufficient to conclude that day one's gameplay logic is unsupported. |

The browser-rendered intro stage is saved as `artifacts/runtime-tests/browser-INTRO-release.png`. This was captured from the actual WebGL canvas, with `?capture=1` enabling `preserveDrawingBuffer` solely for capture; it is not an extracted asset or reconstructed mockup.

See `artifacts/runtime-tests/dirplayer-http.log` for exact local file requests and `artifacts/runtime-tests/dirplayer-{cargo,vite,npm}.log` for build evidence.

### A concrete missing opcode and local patch

The failure is a real missing legacy bytecode path, not a missing third-party Xtra:

* `kOpGet`, property type `0x04` = sound-channel property.
* Property ID `0x01` = volume.
* The game uses `the volume of sound 2` in `KALENDER/casts/Internal/BehaviorScript 13.ls` and `BehaviorScript 39.ls`.
* Current DirPlayer implements the corresponding setter and exposes the value through the modern `sound(N).volume` handler, but the legacy `kOpGet` dispatcher does not route property type `0x04` to it.

`patches/dirplayer-legacy-sound-getter.patch` adds that dispatch using the existing shared property map and `SoundChannelDatumHandlers::get_prop`, covering all sound properties already supported there. This avoids inventing a volume constant or changing original game scripts. [Upstream get/set dispatcher](https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/vm-rust/src/player/bytecode/get_set.rs), [sound property map](https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/vm-rust/src/director/lingo/constants.rs), [sound-channel state](https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/vm-rust/src/player/handlers/datum_handlers/sound_channel.rs).

The modified source builds successfully for `wasm32-unknown-unknown` using local `rustc 1.98.1`, `wasm-bindgen 0.2.108`, and Vite. The upstream crate emits many warnings, but the build completed successfully. This is a candidate upstream fix; it has not been submitted or merged.

### Filesystem and APIs to handle explicitly

1. **Cast suffixes and letter case.** DirPlayer requests `.cct` for the disc's `.CXT` files. The harness resolves case-insensitively and maps `.cct`→`.CXT`, `.dcr`→`.DXR` only when the requested file is absent. These are HTTP routing aliases; the original data is unchanged. A production loader should resolve using the disc manifest instead of assuming a case-sensitive browser server behaves like a Windows CD filesystem.
2. **Startup/search paths (subsequently fixed).** The initial native bytecode probe found that `KICKER` stops with `Symbol 'pathName' is not a built-in symbol` at `exitFrame:3`, bytecode 1. This is another concrete compatibility gap, not a file-not-found error. The correct value of `pathName` needs projector-launch-directory semantics; simply treating it as `moviePath` risks changing relative path behavior after a movie transition. `KICKER` derives `the pathName` and assigns `the searchPaths` using either Windows or classic Mac separators, then loads `KALENDER`. Preserve the intended root directory and movie-change semantics. Directly opening arbitrary day movies is a diagnostic convenience, not the complete launch sequence.
3. **FileIO and persistence.** `SHARED16` contains `new(xtra("fileio"))`, `openFile`, `status`, `setPosition`, `readLine`, `writeString`, and `closeFile`. DirPlayer has a FileIO implementation, but its writable store is an in-memory `virtual_fs` map, and browser open/save dialogs return an empty result. Persistent saves require a verified storage adapter if these routines are reached. The presence of a script in an external cast does not prove that it is used by this game. [FileIO implementation](https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/vm-rust/src/player/xtra/fileio/mod.rs).
4. **Optional Xtras.** DirPlayer can host Xtras rewritten as WASM modules. This does not run the disc's native `.X32` or classic Mac Xtra binaries directly. The standard bitmap/text/font/mixer features should first use the runtime's built-in equivalents. [Xtra manager](https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/vm-rust/src/player/xtra/manager.rs), [external-Xtra bridge](https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/vm-rust/src/player/xtra/external.rs).
5. **Flash is optional to this experiment.** The harness sets `data-disable-flash`, so the probe specifically demonstrates Director execution without Ruffle. If real embedded SWF assets are later found, DirPlayer already supports a Ruffle bridge; removing this flag and shipping its Ruffle assets is a separate test. [Polyfill entry point](https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/polyfill/src/standalone.tsx).

### Reproduce the initial browser experiment

The current web port uses `python3 scripts/serve_web.py` on port 8766. To inspect the historical polyfill experiment separately, run from the project root:

```sh
python3 runtime/dirplayer/serve.py --port 8767
```

Open `http://127.0.0.1:8767/?movie=INTRO` for the released runtime or `http://127.0.0.1:8767/?movie=KALENDER&patched=1` for the locally rebuilt runtime. `movie` can be any existing movie stem, for example `DAG12`. Add `&capture=1`, then use **Capture stage** to write the current visible stage to `artifacts/runtime-tests/browser-<movie>-<runtime>.png`. Without the capture flag the browser may clear the WebGL backing buffer before export, resulting in a black PNG. The HTTP server listens on loopback only. The loader is a compatibility experiment, not a finished public game port.

Build the patched checkout with the already installed project-local toolchain:

```sh
cd tools/runtime-options/dirplayer-rs
export RUSTUP_HOME="$PWD/../rustup"
export CARGO_HOME="$PWD/../cargo"
export PATH="$CARGO_HOME/bin:$PATH"
cargo build --manifest-path vm-rust/Cargo.toml --target wasm32-unknown-unknown
../wasm-bindgen-0.2.108-aarch64-apple-darwin/wasm-bindgen \
  vm-rust/target/wasm32-unknown-unknown/debug/vm_rust.wasm \
  --out-dir vm-rust/pkg --target web
node_modules/.bin/vite build -c vite.config.polyfill.js
```

The final command deliberately builds the Director polyfill only; the optional Ruffle submodule is not needed for this probe. For a clean environment, follow upstream installation instructions, preserve the pinned commit, and apply the saved patch. The recorded command uses the downloaded Apple Silicon wasm-bindgen tool; substitute the matching official build on another host.


### Initial native harness matrix: superseded diagnostics

An additional freshly compiled native **DirPlayer** probe attempted 40 frames of `INTRO`, `KICKER`, `KALENDER`, and each of the 24 day movies in isolated processes. It executes Director data through the open source VM; it does not execute the original EXE. Results and per-movie logs are at `artifacts/runtime-tests/native/matrix.json`.

* `KICKER` reports the missing `pathName` built-in and stops at frame 1.
* `DAG03` and `DAG23` reach frames 2 and 3 respectively, remain marked playing, and produce black 640×480 PNGs. Their game scenes are not verified.
* Most other probes hit a limitation of the upstream **native test harness**: `SoundChannel::start_sound` unwraps an absent WebAudio context at `sound_channel.rs:1854`. Five day movies instead reach a WASM/JavaScript import that cannot execute on the native target. These failures do **not** establish corresponding browser incompatibilities.

The browser probes above remain the relevant rendering evidence. Do not convert this native matrix into a percentage of supported games. Its useful outcomes are the independent launcher failure, proof that source builds natively, reproducible trace files, and identification of where the native test backend needs additional work.

The probe source and runner are preserved under `runtime/dirplayer/`. To rebuild and rerun:

```sh
cp runtime/dirplayer/findus_probe.rs tools/runtime-options/dirplayer-rs/vm-rust/examples/findus_probe.rs
export RUSTUP_HOME="$PWD/tools/runtime-options/rustup"
export CARGO_HOME="$PWD/tools/runtime-options/cargo"
export PATH="$CARGO_HOME/bin:$PATH"
cargo build --manifest-path tools/runtime-options/dirplayer-rs/vm-rust/Cargo.toml --example findus_probe
python3 runtime/dirplayer/native_matrix.py
```

## ScummVM Director

Current source contains these German entries under game ID `pettsonjk` (display title `Pettson o Findus julkalender`):

```cpp
MACGAME1_l("pettsonjk", "", "Findus3", "0944b962ebb00f4b5d5149d220f8449b", 115401, Common::DE_DEU, 702),
WINGAME1_l("pettsonjk", "", "FINDUS3.EXE", "7c18c9a6af2694156bf09ed195c1ab09", 6268578, Common::DE_DEU, 702),
```

Here `702` denotes Director 7.0.2, and the active `SUPPORT_STATUS` macro is `ADGF_UNSTABLE`. This disc's Windows file is **2,441,786 bytes**, with the same MD5 of its first 5,000 bytes, `7c18c9a6af2694156bf09ed195c1ab09`. The shared prefix hash identifies the projector family; the mismatching total size means this is not an exact known Windows variant. The detection table must use the correct size/hash and should ideally include distinguishing content. [Pinned detection source](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/engines/director/detection_tables.h#L9778).

A sensible next test is a development ScummVM build with the Director engine enabled, pointed at the full extracted disc tree. Preserve both native projector and movie files for its detector. For web deployment, ScummVM includes an official Emscripten target with browser storage and HTTP-loaded data. This route is credible but has not been built or played against this disc in this investigation. [Emscripten build documentation](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/dists/emscripten/README.md), [Director engine configuration](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/engines/director/configure.engine).

ScummVM also provides an independent implementation of Director file structures, Lingo semantics, bitmap decoders, score channels and Xtras. It is valuable even if DirPlayer becomes the shipping runtime: compare ambiguous bytecodes and asset metadata against both implementations.

## Other tooling and execution strategies

| Tool / strategy | Relevance and limits |
|---|---|
| ProjectorRays | Decompiles Director scripts/assets for understanding and patching. It is not a game runtime; use it alongside DirPlayer/ScummVM. The extraction work elsewhere in this repository covers this route. |
| Ruffle | Open source Rust Flash/SWF emulator with web and desktop targets. Useful for an actual embedded SWF, but it does not replace the Director/Lingo container runtime. [Ruffle project](https://github.com/ruffle-rs/ruffle). |
| Infinite Mac / SheepShaver / related Mac emulators | Emulate a classic Mac environment so the original PowerPC projector can execute. Infinite Mac includes browser-based classic Mac emulation, including Mac OS 9. This is a potential way to obtain reference behavior and recordings before implementing a direct runtime port; this title was not tested there. It preserves the original OS/runtime stack rather than reimplementing Lingo. [Infinite Mac source and emulator build instructions](https://github.com/mihaip/infinite-mac). |
| Recompiling native projector code | Poor first target: it reimplements a generic Director runtime that these projects already provide, while the game's distinctive logic is Lingo bytecode. Native analysis remains useful for extracting embedded movies and identifying unusual Xtra dependencies. |

A full playthrough across the calendar, all 24 days, construction activities, audio, returns to the calendar, and save/date behavior remains the acceptance test. Successful parsing, a rendered logo, or a fixed startup opcode alone does not satisfy that test.
