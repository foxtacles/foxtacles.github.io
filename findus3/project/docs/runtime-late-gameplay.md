# Late-calendar browser validation

These are physical Chromium pointer/keyboard tests against the portable WebAssembly runtime, using the original Director movie data. The harness uses read-only VM inspection to locate visible hit points, observe authored state, and solve the sliding puzzle; it does not change gameplay globals or invoke game handlers to complete activities. Each JSON records the engine SHA-256, actions, checkpoints, and script errors. Screenshots sit beside their reports.

| Activity | Exercised behavior | Evidence |
| --- | --- | --- |
| Day 13 | Matched all eight left/right card pairs, observed completion, returned to calendar | [DAG13.json](../artifacts/runtime-tests/web/late-gameplay/DAG13.json) |
| Day 20 | Dragged all 13 decorations onto the tree; each authored placement flag accepted; completion frame 8 and calendar return | [DAG20.json](../artifacts/runtime-tests/web/late-gameplay/DAG20.json) |
| Day 21 | Solved the initial 3×3 puzzle with 16 legal adjacent-tile clicks, reached completion frame 30, returned to calendar | [DAG21.json](../artifacts/runtime-tests/web/late-gameplay/DAG21.json) |
| Day 22 | Selected all four paint pots and painted all 13 ornaments, then returned to calendar | [DAG22.json](../artifacts/runtime-tests/web/late-gameplay/DAG22.json) |
| Day 23 | Dragged Findus to record a 37-point dance route; released and observed its replay position advancing; returned to calendar | [DAG23.json](../artifacts/runtime-tests/web/late-gameplay/DAG23.json) |
| Day 24 | Used story navigation; assembled wheels in the required 3,2,1,4 order; observed all placement flags and the running mechanism; dressed Santa with head, clothing, shoes, and voice; continued to finale frame 41 and returned to calendar | [DAG24.json](../artifacts/runtime-tests/web/late-gameplay/DAG24.json) |

Days 14, 15, and 17 were assigned to the graphics validation work; 18 and 19 to the main integration work. Day 16 leads to the three construction activities, validated separately. The generic older `late-days` captures establish startup/navigation observations, not completed gameplay.

Run the focused checks with:

```sh
node runtime/dirplayer/late_playthrough.mjs DAG13 DAG20 DAG21 DAG22 DAG23 DAG24
```

The separate [natural Day 24 report](../artifacts/runtime-tests/web/late-gameplay-natural/DAG24.json) also passes: all nine main story chapters advance through their complete audio, with the wheel and Santa activities performed at their authored pauses. The concluding narration, Santa voice, picture changes, and final speech finish at the stable frame 55 before the calendar return. Run this approximately eight-minute check with `FINDUS_NATURAL_STORY=1 node runtime/dirplayer/late_playthrough.mjs DAG24`. The quicker Day 24 scenario above also validates the visible next-page story controls by navigation.

These are tested paths, not exhaustive coverage of every alternate puzzle size, costume, drawing, difficulty level, or input timing. Audio assertions use runtime completion/state; the checks do not independently transcribe or compare every sound sample.
