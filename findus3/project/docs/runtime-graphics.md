# Runtime graphics verification

DirPlayer successfully decodes all 2,047 nonempty BITD bitmap assets and all four PICT images from the original game. The native validator loads the original Director files and compares RGB pixels against the independent recovery exporter: **2,269 raster image instances, 2,269 exact RGB matches**, covering all 2,051 unique assets. Shared casts account for repeated instances.

The validator renders authored frame 5 of all 30 movie files without dispatching Lingo or sound. All 30 parsed sprite-state snapshots match the independently recovered score data for cast/library reference, location, width and height. The PETTTALK external cast is decoded separately without a score. This isolates parsing and rendering; it does not establish interactive game completion.

PETTTALK has 54 images with a host-relative palette reference. When it is loaded by KONSTR01–03, the comparison applies each host's independently recovered member-1 CLUT to the preserved bitmap indices. These match the runtime exactly. Its standalone preview retains the documented Mac system fallback.

## Fixes

- Director BITD control byte `0x80` is a repeat of 129 bytes, while QuickDraw PackBits treats it as a no-op. Raw BITD is identified by exact decoded stride length rather than `>=`. Three regression tests cover both rules; none of Findus's original streams exercise these edge cases.
- Director 2-bit images use the standard four-gray palette regardless of the stored CLUT. This corrects DAG04 member 5 (39 × 39), which otherwise decoded black/gray pixels as yellow. The fourth regression test also checks that ordinary 8-bit Mac palette colors are preserved.
- A retired script slot in DAG05 reached a browser-only warning function and aborted native execution. It now uses the existing portable logger; script behavior is unchanged.
- Explicit `rollOver(n)` and `sprite(n).rollover` must test the named sprite rectangle even when the sprite is invisible. Hidden highlight sprites are used as menu hot spots. The new helper preserves normal visible/matte event picking. A regression checks hidden highlights, empty channels and rectangle edges.
- QuickDraw PICT cast members were previously loaded as Unknown. The added PICT v2 reader handles the disc's 8-bit indexed PackBitsRect pictures, their embedded color tables and top-left registration. It rejects unsupported drawing operations, clipping, transfer modes and malformed rows. QuickDraw's `0x80` no-op has a separate regression from Director BITD's repeat rule.
- Loading another movie reused the previous score's channel objects. A calendar highlight hidden on channel 3 therefore hid DAG01's full background on that same channel. `Score::load_from_dir` now replaces the complete score before loading the next movie, clearing sprite properties and score caches while leaving the player's global Lingo data intact. The native transition regression contaminates all prior channels with visibility, puppet, moveable, trails, ink, blend, transforms, dimensions, constraints and colors; the resulting DAG01 stage PNG matches a fresh load exactly. The browser reproduction uses two actual clicks on calendar door 1.

- A puppeted channel kept the previous span's script instances after `endSprite`, preventing the next span from installing its own behavior. KONSTR01 frame 33's empty `mouseUp` script (member 66) therefore intercepted the assembly pieces on frame 34, which authors the drag script (member 27). Exiting puppeted spans now clears their behavior lifecycle and cached `scriptInstanceList`, while preserving all visual/puppet properties. This matches ScummVM `channel.cpp`'s explicit script-ID update for puppeted channels. The original-movie native regression fails before the fix and passes afterward for both affected channels.

- Input queues preserve the button state of each mouse move. A pre-press hover cannot drag the old target, and a pre-release movement still updates its target after the host's physical release arrives. The native queue regression covers both directions.
- Keyboard events carry a scoped key identity: `the key` and `the keyCode` read the particular queued event during `keyDown`/`keyUp`, while `keyPressed` and modifier polling retain the current physical state. This prevents simultaneous Up/Right input from making both callbacks read Right. Native Lingo callbacks verify both keys, release behavior, and scope restoration on nested events and errors.

The bitmap RLE/2-bit palette rules and rollover distinction were cross-checked with the pinned ScummVM Director sources (`images.cpp`, `castmember/bitmap.cpp`, `score.cpp`, `channel.cpp`). The existing DirPlayer fork is GPL-3.0-only; source changes and test programs remain source-distributed with the project.

## Reproduce

Configure the local Rust environment as in the runtime build instructions, then from `tools/runtime-options/dirplayer-rs/vm-rust`:

```sh
cargo test --lib bitd_tests
cargo test --lib rollover_tests
cargo test --lib queued_mouse_move_tests
cargo test --lib keyboard
cargo test --lib pict::tests
cargo build --example findus_render_probe
cargo run --example findus_puppet_span_probe -- /absolute/path/to/KONSTR01.DXR
cargo run --example findus_transition_probe -- /absolute/path/to/KALENDER.DXR /absolute/path/to/DAG01.DXR /absolute/path/to/transition-output
```

From the project root:

```sh
.venv/bin/python scripts/validate_runtime_graphics.py
```

The probe source is preserved at `runtime/dirplayer/findus_render_probe.rs`. Output is in `artifacts/runtime-tests/rendering/validation.json`; each movie directory contains decoded bitmaps, `loaded.json`, `sprites.json` and a `stage.png` snapshot. `runtime/dirplayer/interactive_audit.mjs` records real browser mouse actions and read-only debugger inspection separately under `artifacts/runtime-tests/interactions-4-7-9`.

The puppet-span probe is preserved at `runtime/dirplayer/findus_puppet_span_probe.rs`; before/after logs are in `artifacts/runtime-tests/puppet-span-{before,after}.log`.

The transition probe is preserved at `runtime/dirplayer/findus_transition_probe.rs`; its verified output is in `artifacts/runtime-tests/movie-transition`. `node runtime/dirplayer/calendar_day1_regression.mjs` exercises the actual calendar navigation in the browser.

## Interactive graphics and hit testing

Three browser playthroughs use actual pointer movements, button presses and drags. Debugger reads only identify sprite geometry and the randomized piece identities; the tests never write game state. They run against the reference server at `http://127.0.0.1:8766`:

```sh
node runtime/dirplayer/play_dag04.mjs
node runtime/dirplayer/play_dag07.mjs
node runtime/dirplayer/play_dag09.mjs
```

- DAG04: select easy mode, hit seven animated chickens without a miss, reach the victory screen at frame 10 (`klubba=49`, `tupp=35`).
- DAG07: drag all nine randomized picture pieces into place and reach frame 15 with `klar=9`.
- DAG09: verify an incorrect drop resets the piece and leaves `klar=0`, then drag all seven tree pieces into place and reach frame 15 with `klar=7`.

All three completed with zero VM errors. JSON action/state evidence and completion screenshots are under `artifacts/runtime-tests/interactions-4-7-9/DAGxx-completion`. The original custom cursor PNG/hotspot appears in browser CSS, and the invisible game cursor used by DAG04 is honored. These are bounded successful playthroughs, not an exhaustive test of every difficulty or losing path. The tests depended on the VM's cooperative `updateStage` yield and the audio Loading/busy-state fixes as well as the named-rollover correction.

The slingshot test, `node runtime/dirplayer/slingshot_playthrough.mjs`, also completed the full authored 120-second DAG10 round. It reads the original seven projectile paths and live target rectangles to choose a mouse position, then presses/releases the real mouse button. The verified run scored **253 points from 113 presses**, reached `clockTime=0` and `SpeletSlut=2`, completed the highest score-tier feedback branch, reset to `clockTime=120`, `AntalPoang=0`, `SpeletBorjat=0`, and started a fresh round with another real click. The calendar button then returned to KALENDER. There were zero VM or browser errors. Evidence is in `artifacts/runtime-tests/playthrough/DAG10-result.json`, with round, replay and calendar screenshots alongside it. This tests actual projectile/target collision and scoring; it does not substitute debugger state writes for gameplay.

`node runtime/dirplayer/bounce_playthrough.mjs` completes DAG15 by steering the paddle with real pointer moves. Read-only ball and fruit positions guide the pointer; the original scripts calculate the bounces, gravity and catches. The verified run collected 12 items and reached the success sequence with all three lives remaining. A real click restarted with score zero and three lives, and another returned to the calendar. Evidence is in `artifacts/runtime-tests/playthrough/DAG15-{complete,restart,return}.json` and matching screenshots, with zero VM/browser errors.

`node runtime/dirplayer/gingerbread_playthrough.mjs` completes DAG14 through both stages: it verifies an incorrect structural drop resets, assembles all 11 movable house pieces, places all 21 decorations within the original nonrectangular mask regions, and reaches frame 15. Real clicks restart the house with `klar=0` and return to the calendar. The run has zero VM/browser errors; evidence is in `artifacts/runtime-tests/playthrough/DAG14-{house,complete,restart,return}.{json,png}`. This exposed an input queue issue fixed in the shared runtime: a mouse move queued before a press must retain its original button state, otherwise the previous drag target could be moved over the next piece.

`node runtime/dirplayer/snowball_playthrough.mjs 1` and `node runtime/dirplayer/snowball_playthrough.mjs 2` complete full DAG17 rounds in both modes. One player scored 21:19 with 27 throws; two players scored 17:17 with 34 throws. The two-player test verifies real left/right keyboard movement and uses actual pointer throws; both players score, the timer expires, feedback finishes, a real click starts a fresh round, and the calendar button returns. Neither test writes VM state. Evidence is in `artifacts/runtime-tests/playthrough/DAG17-mode{1,2}-result.json` and matching screenshots, with zero VM/browser errors.
