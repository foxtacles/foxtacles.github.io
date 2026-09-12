# Director 7 audio compatibility

The supplied game has 540 `sndH`/`sndS` sound pairs. Every `sndH` is the 100-byte Director 7 MoaSoundFormat header; empty legacy `snd ` chunks are not the audio payload. The corresponding `sndS` is uncompressed mono PCM. No Flash or MP3 decoder is needed for these sounds.

| Encoding | Rate | Assets |
| --- | ---: | ---: |
| Unsigned 8-bit PCM | 22,050 Hz | 489 |
| Unsigned 8-bit PCM | 11,025 Hz | 3 |
| Unsigned 8-bit PCM | 22,254 Hz | 1 |
| Big-endian signed 16-bit PCM | 22,050 Hz | 45 |
| Big-endian signed 16-bit PCM | 44,100 Hz | 2 |

This was verified from every extracted header and by decoding every sample through the patched DirPlayer decoder. All 540 assets have full-sound loop ranges; none requires an internal loop subrange. The complete per-asset result, including duration, extrema, and RMS, is [audio-audit.json](../artifacts/runtime-tests/audio-audit.json). Its `exact_pcm_match` checks compare every decoded float with direct unsigned-8 or big-endian signed-16 conversion, not just file sizes.

## Fixes in DirPlayer

Based on DirPlayer revision `68376fbb4494a6bbad4c70081ecdcb99814a74c9`, in `vm-rust/src/player/handlers/datum_handlers/sound_channel.rs`:

- Convert unsigned PCM8 to PCM16 using `(sample - 128) * 256`. The previous factor 257 overflowed `i16` for byte 0 and changed a negative peak into a positive one.
- Treat `SoundChunk` bytes as already stripped audio data. The previous `00 01` / `00 02` signature heuristic discarded 84 real sample bytes; original `DAG05/chunks/sndS-789.bin` triggers this defect.
- Emit correct RIFF lengths and reject zero WAV channels, sample widths, or rates before calculating frame counts.
- Return sound-channel duration/currentTime in milliseconds and retain the current member even for a sound that plays once.
- Make `soundBusy` a pure channel-state query and mark it as an asynchronous poll for backward-loop yielding. Its former Loading timeout used the previous sound’s start timestamp, prematurely skipping DAG07’s puzzle setup.
- Invalidate pending PCM decode tasks and old `ended` callbacks on stop, including a task stopped before its first poll. Clear queued sounds and release playback nodes.
- Apply current channel volume and pan after asynchronous PCM decoding, so changes made during loading are retained. Normalize Lingo pan from −100…100 to Web Audio −1…1.
- Copy PCM into Web Audio buffers explicitly in the synchronous segment path; `get_channel_data` returns copied Rust data. Apply start/end offsets, loop settings, and a stale-ended guard there too.
- Support master `soundLevel` 0…7 and `soundEnabled` in SoundManager without overwriting channel volumes. KALENDER's original speaker controls use levels 7, 4, and 1. Global property routing is supplied by the accompanying runtime property patch.
- Keep host mute separate from authored sound settings: it changes gain while the audio clock and busy state continue, and restores the latest authored level when unmuted.
- Add a silent native PCM backend driven by the decoded sample count and explicit elapsed time. It retains busy/paused state and supports finite/infinite full-buffer loops, enabling native script and renderer tests without calling Web Audio imports. This is a test backend, not a native audio output device.

The focused patch is [dirplayer-audio-compatibility.patch](../patches/dirplayer-audio-compatibility.patch). Browser audio uses real Web Audio source completion events; it is not forced idle using guessed wall-clock timeouts.

## Verification and reproduction

The sound-channel unit suite includes 18 tests ([result](../artifacts/runtime-tests/audio-unit-tests.json)) and covers PCM extrema and byte order, the raw-prefix regression, a synthetic 100-byte D7 header, RIFF sizes, invalid metadata, duration, completion, loop counts, pause, decode cancellation, queued sounds, pan, and master gain. Tests contain synthetic audio only.

From the project root, with the isolated Rust toolchain installed:

```sh
export RUSTUP_HOME="$PWD/tools/runtime-options/rustup"
export CARGO_HOME="$PWD/tools/runtime-options/cargo"
export PATH="$CARGO_HOME/bin:$PATH"
cargo test --manifest-path tools/runtime-options/dirplayer-rs/vm-rust/Cargo.toml --lib sound_channel::
cp runtime/dirplayer/findus_audio_audit.rs tools/runtime-options/dirplayer-rs/vm-rust/examples/findus_audio_audit.rs
cargo run --manifest-path tools/runtime-options/dirplayer-rs/vm-rust/Cargo.toml --example findus_audio_audit -- "$PWD/artifacts/decompiled" > artifacts/runtime-tests/audio-audit.json
```

The audit requires the original game's extracted assets; it does not embed or fetch game data. Its adjacent sndH/sndS resource-ID pairing is checked for this disc (540/540 pairs), not claimed as a universal Director file-format rule.

The native scene probe is independently useful:

```sh
cp runtime/dirplayer/findus_probe.rs tools/runtime-options/dirplayer-rs/vm-rust/examples/findus_probe.rs
cargo build --manifest-path tools/runtime-options/dirplayer-rs/vm-rust/Cargo.toml --example findus_probe
python3 runtime/dirplayer/native_matrix.py --out artifacts/runtime-tests/native-audio-fixed
```

The first run after fixing audio reached 40 steps in INTRO and every day movie with no reported script error or panic. Results and rendered screenshots are in [native-audio-fixed/matrix.json](../artifacts/runtime-tests/native-audio-fixed/matrix.json). KICKER and KALENDER still encountered `js_sys::Date::now` in `nothing_async` in that run; this is a separate native-runtime clock issue, not a decoder failure. Direct-entry startup tests do not establish complete playability, narration sequencing, or interaction correctness.

## Remaining boundaries

Headless Chromium 147.0.7727.15, Firefox 148.0.2, and WebKit 26.4 on Apple Silicon macOS each passed a real Web Audio graph probe: nonzero output samples, silent host mute with an advancing clock, natural finite completion, and complete launcher-to-calendar startup without script errors. The 10.147-second INTRO clip ended after 10.149 seconds in each engine; channel 2 returned to idle after each 1.904-second clip. See [browser-audio/matrix.json](../artifacts/runtime-tests/browser-audio/matrix.json) and per-engine screenshots. The probe uses output analysers and read-only channel snapshots; it does not replace sound data or inject game logic.

All three engines passed again after the final keyboard-identity and physical mouse-state fixes (build 30670). The tested WASM SHA-256 is `4dc7b377f8438a38e366c768f23d42dd7e73b4bcdf521f6c6cb73f90204d6cdd`; the reports record this identity. The separate [single-session navigation test](runtime-interaction-tests.md) also enters all 24 activities through their calendar doors and returns without reloading the VM.

Run `node runtime/dirplayer/browser_audio_probe.mjs chromium firefox webkit` against the built host on port 8766. Browser binaries are installed with the project's Playwright CLI (`node tools/runtime-options/dirplayer-rs/node_modules/playwright/cli.js install firefox webkit`). These are browser-engine tests on macOS, not tests on physical iOS/Android devices. Full gameplay and narration sequencing beyond the tested scenes remain separate acceptance checks. This work does not add native audio output or a native compressed-audio decoder. The existing channel pause/resume Web Audio implementation suspends the shared context and remains a broader compatibility limitation; the supplied game has not been observed to depend on per-channel pause.
