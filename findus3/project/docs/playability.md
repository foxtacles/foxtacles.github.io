# Interactive validation

The reference port runs the original movies and bytecode. These tests use real
browser mouse, key or touch events. Random puzzle layouts and live actor positions
are read to choose inputs; completion counters are not written by the tests.
Screenshots, state snapshots and runnable test programs remain in this workspace.

## Activity coverage

| Day | Verified behavior | Main evidence |
|---|---|---|
| 1 | Three complete laps through ordered checkpoints; elapsed-time display, acceleration, steering, restart and calendar return | [Race](../artifacts/runtime-tests/driving-round/report.json) |
| 2 | Rod angle and line control; fish lands in pan, success dialogue, restart and return | [Fishing](../artifacts/runtime-tests/fishing-round/report.json) |
| 3 | All 12 sound pairs, completion, restart and return; also a complete touch playthrough | [Sound memory](../artifacts/runtime-tests/playthrough/DAG03-completed.json) |
| 4 | Seven chicken hits and victory | [Chickens](../artifacts/runtime-tests/interactions-4-7-9/DAG04-completion/) |
| 5 | Three-hit nails across all four lanes, points, round ending, feedback, reset and return | [Nails](../artifacts/runtime-tests/interactions-1-2-5-6/DAG05.json) |
| 6 | Both slope choices; steering, jump/grab input, full 800-unit course, ending, replay and return | [Small slope](../artifacts/runtime-tests/interactions-1-2-5-6/DAG06.json), [steep slope](../artifacts/runtime-tests/interactions-1-2-5-6-steep/DAG06.json) |
| 7 | All nine randomized picture pieces and completion | [Picture puzzle](../artifacts/runtime-tests/interactions-4-7-9/DAG07-completion/) |
| 8 | All three spotlight captures, completion, restart and return | [Spotlight](../artifacts/runtime-tests/playthrough/DAG08-completed.json) |
| 9 | Rejected incorrect drop, all seven tree pieces, completion; also real touch dragging and return | [Tree](../artifacts/runtime-tests/interactions-4-7-9/DAG09-completion/) |
| 10 | Aiming, 113 shots, moving-target collisions, 253 points, full two-minute round, feedback, reset, restart and return | [Slingshot](../artifacts/runtime-tests/playthrough/DAG10-result.json) |
| 11 | All three spoken-rhyme matches, completion, restart and return | [Rhymes](../artifacts/runtime-tests/playthrough/DAG11-completed.json) |
| 12 | All six ingredient combinations through baking/result/reset, followed by calendar return | [Baking example](../artifacts/runtime-tests/playthrough/DAG12-6-9-completed.json) |
| 13 | All eight visual-memory pairs, restored green card graphics, completion and return | [Visual memory](../artifacts/runtime-tests/web/late-gameplay/DAG13.json) |
| 14 | Eleven house pieces and all 21 decorations, completion, restart and return | [House](../artifacts/runtime-tests/playthrough/DAG14-complete.json) |
| 15 | Twelve collected objects, bouncing and paddle control, victory, restart and return | [Bounce game](../artifacts/runtime-tests/playthrough/DAG15-complete.json) |
| 16 | All three construction drawings assembled and their mechanisms run; completion dialogue and return | [Construction 1](../artifacts/runtime-tests/construction/KONSTR01.json), [2](../artifacts/runtime-tests/construction/KONSTR02.json), [3](../artifacts/runtime-tests/construction/KONSTR03.json) |
| 17 | One- and two-player snowball modes, both full two-minute rounds, scores, keyboard controls, replay and return | [One player](../artifacts/runtime-tests/playthrough/DAG17-mode1-result.json), [two players](../artifacts/runtime-tests/playthrough/DAG17-mode2-result.json) |
| 18 | All six narrated chapters and their sound parts finish naturally; next/previous, restart and return | [Narration](../artifacts/runtime-tests/playthrough/DAG18-completed.json) |
| 19 | Five-note bird sequence completed, success, restart and return | [Birds](../artifacts/runtime-tests/playthrough/DAG19-completed.json) |
| 20 | All 13 tree decorations, praise and return | [Decorating](../artifacts/runtime-tests/web/late-gameplay/DAG20.json) |
| 21 | Sliding puzzle solved by legal moves, completion and return | [Sliding puzzle](../artifacts/runtime-tests/web/late-gameplay/DAG21.json) |
| 22 | All 13 ornaments painted using the four color pots, praise and return | [Painting](../artifacts/runtime-tests/web/late-gameplay/DAG22.json) |
| 23 | A pointer-drawn dance route records and replays with the characters; return | [Dance](../artifacts/runtime-tests/web/late-gameplay/DAG23.json) |
| 24 | All nine story chapters and concluding audio finish naturally; ordered wheel assembly, running mechanism, Santa head/coat/shoes/voice selections, finale and return; separate navigation check | [Full story](../artifacts/runtime-tests/web/late-gameplay-natural/DAG24.json), [navigation](../artifacts/runtime-tests/web/late-gameplay/DAG24.json) |

These are concrete playthrough checks, not an assertion that every possible
random seed, timing or input sequence has been exhaustively explored. Full
playthroughs primarily run in Chromium. Cross-engine and device checks below
cover the web platform and representative interactions.

Construction 2 also has an input-timing regression check. A short calendar tap
buffered during its blocking dialogue can be ignored by the original script's
live-button guard; it no longer leaves the player stuck with a pressed mouse.
The player remains responsive and a subsequent tap returns to the calendar.
[Dialogue input check](../artifacts/runtime-tests/construction-interrupt/KONSTR02.json).

A separate audit starts with the original launcher and visits all 24 calendar
doors, returning through each activity's own calendar button without reloading
the page. All 24 round trips pass, including day 16's construction redirect,
with zero VM/browser errors and all 37 requested Director assets returning HTTP
200. This checks state across movie changes independently of direct-entry
playthroughs. [Calendar audit](../artifacts/runtime-tests/calendar-all-days/report.json).

## Browser and device coverage

- Chromium 147, Firefox 148 and WebKit 26.4: original startup chain through the
  calendar; measured audible output, mute/unmute, continuously running sound
  clock, natural clip endings and `soundBusy` transitions. No script/page errors.
  [Audio/browser matrix](../artifacts/runtime-tests/browser-audio/).
- Pixel 7, iPhone 13 and iPad browser device profiles: portrait and landscape
  fullscreen layouts, touch start, all 12 memory pairs, restart and calendar
  return. Chromium and WebKit run actual touch events; these profiles emulate
  device viewports/input, rather than testing physical phone hardware.
  [Device reports](../artifacts/runtime-tests/mobile/).
- Chromium touch events also cover seven tree-piece drags, rejecting an invalid
  placement, and simultaneous on-screen key input/cancellation.
- A static server mounted under `/web/` runs the complete startup chain with all
  game requests kept inside that subdirectory. No root-path or case-sensitive
  hosting assumption is required. [Static hosting](../artifacts/runtime-tests/static-host/result.json).

## Independent runtime checks

- All 540 sounds decode to exact PCM samples against an independent decoder.
- 2,269 rendered bitmap instances, including all unique BITD assets and four PICT
  images, match independently exported pixels under the relevant palettes.
- Native regressions cover legacy sound properties, clocks, date rules, MacRoman
  names, frame dispatch, missing cast/script identities, asymmetric collision,
  mouse hit targets, queued inputs, and puppet-span behavior changes.
- The reported day-1 black background was reproduced by actual calendar entry.
  A contaminated-movie transition test now verifies that visibility and other
  sprite state cannot leak into the next movie.

See [audio](audio-runtime.md), [graphics](runtime-graphics.md),
[interaction tests](runtime-interaction-tests.md) and [build instructions](web-port.md).
