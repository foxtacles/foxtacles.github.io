# Findus wartet auf Weihnachten — recovered Director project

The supplied disc is a **Macromedia Director 7.0.2 / Lingo application**, with a
640×480 stage, an advent-calendar shell, 24 day entries and three construction
movies. Its game-specific code is Director bytecode, not x86 or ActionScript.
The Windows player is x86 PE32; the classic Mac player is PowerPC PEF/CFM.
Both projectors identify as **7.0.2r85**. They bundle a Flash Xtra, but the
recovered cast inventory contains no Flash movie members.

This workspace contains a reproducible disc extraction, game-code decompilation,
asset export, architecture report, and a working browser reference port using
a patched open source Director runtime. All 24 activities and the three
construction projects have interactive playthrough evidence; see the
[validation report](docs/playability.md) for coverage and its limits.

## Play the web port

[Play online on GitHub Pages](https://foxtacles.github.io/findus3/).
The [deployment notes](docs/github-pages.md) explain how to update that build.

```sh
python3 scripts/serve_web.py
```

Open http://127.0.0.1:8766/ and press **Spielen**. The build is in `dist/web/`.
It supports mouse, touch and keyboard input, with an on-screen keypad, fullscreen
and sound controls. See [running, rebuilding and packaging the web port](docs/web-port.md).

## Start here

- [Game architecture and every day/activity](docs/game-architecture.md): startup,
  calendar rules, controls, shared state, game algorithms and port semantics.
- [Open source runtimes and actual tests](docs/open-source-runtimes.md): DirPlayer,
  ScummVM, browser tests and the reference runtime's compatibility changes.
- [Native player and hybrid Mac/Windows disc](docs/native-runtime.md): binaries,
  versions, embedded movies, Xtras, offsets, forks, imports and entry points.
- [Why reccmp is a secondary tool here](docs/reccmp-assessment.md): it compares
  reconstructed native code; ProjectorRays recovers this game's Lingo directly.
- [Recovery quality and remaining uncertainty](docs/recovery-quality.md).
- [Media export details](docs/media-export.md).
- [Data layout and tool fixes](docs/data-layout.md).

## Recovery results

| Recovered material | Result |
|---|---|
| Raw disc | 57,883 MODE1 sectors; ISO9660 plus classic HFS hybrid filesystem |
| Windows filesystem | 39 files: projector, 31 movies, 7 external casts |
| Macintosh filesystem | 44 files preserved with data/resource forks and Finder metadata |
| Shared platform content | All 38 Mac Main movie/cast files exactly match Windows counterparts |
| Director containers decompiled | 40: 38 external files plus both embedded startup movies |
| Script resources | 829 resource-indexed source/disassembly pairs, including empty records |
| Executable Lingo handlers | 969, approximately 18,588 decompiled source lines |
| Main movie timelines | 1,878 frames, labels, sprite updates, behavior attachments and span data |
| Film loops | 9, containing another 626 frames |
| Bitmap media | 2,047 PNGs; the other 2 bitmap members are empty |
| Sound media | 540 PCM WAVs, about 61.5 minutes including duplicate assets |
| Other media | 4 PICT images decoded to PNG, 19 palettes, 41 plain-text and 5 rich-text resources |
| Native extensions | 9 Windows and 7 Mac Xtras extracted; platform runtime libraries identified |

Counts include the three equivalent startup-script copies (external, Windows
embedded, Mac embedded). They are resource counts, not counts of unique source
algorithms. Some script records contain no executable handlers.

The independent [verification report](artifacts/verification.json) checks the
disc-file hashes and every retained live resource ID. **All original Lingo
bytecode, name tables, score, bitmap and sound payloads are unchanged in the
reconstructed containers.** Container maps, protection configuration and cast
source-text fields are the intended rewritten data. The
[Lingo audit](artifacts/lingo-audit.json) checks raw handler/instruction coverage.
These checks establish structural preservation, not behaviorally equivalent
execution or successful recompilation of every recovered handler in Director.

## Open source execution and the port direction

**DirPlayer powers the reference web port.** The patched Rust/WASM engine runs
the original startup → intro → kicker → calendar flow and the original game
bytecode. Compatibility work includes sound scheduling, graphics, Mac text
encoding, paths/date rules, mouse input and frame/sprite lifecycle. The static
package runs without Flash or a browser extension.

**ScummVM provides an independent implementation to compare against.** Its pinned
Director detection table lists the German game as `director:pettsonjk`, Director
7.0.2, marked unstable. This disc's Windows projector has a different size from
the known entry. No full ScummVM playthrough has been performed.

The original DXR/CXT files remain the executable reference. Browser tests use
actual input, including complete randomized puzzles; native audits independently
compare every decoded bitmap and sound. See [web port](docs/web-port.md),
[audio](docs/audio-runtime.md), and [graphics](docs/runtime-graphics.md).

Port-critical details already established include local-date gating, Director
ticks/timers, old keyboard codes, numeric coercion, sprite registration points,
ink/matte behavior, indexed palettes, sound-channel scheduling, film loops, and
classic Mac/Windows path conventions. In September–November the actual active
calendar code permits **day 1 only**. The web port offers an explicit unlocked
calendar option, enabled by default; unchecking it restores the original date
rules.

## Reproduce extraction and recovery

Keep the original `CD01.img`, `.ccd`, `.cue` and `.sub` in this directory.
Python 3.11+, Git, curl, make, a C++17 compiler, Boost, mpg123 and zlib are needed.
On macOS the native build dependencies can be installed with
`brew install boost mpg123`; Debian/Ubuntu package names are in the bootstrap
script. No original Windows/Mac executable is run by the extraction pipeline.

```sh
./scripts/bootstrap.sh
./scripts/recover.sh
```

The bootstrap pins ProjectorRays, applies the saved fixes, builds it locally and
installs pinned Python dependencies in `.venv`. The recovery command validates
sector framing, extracts both filesystems/projectors, decompiles every container,
indexes scripts/media, decodes timelines, verifies byte preservation, and exports
media. Tool versions and patches are recorded in [tools-lock.json](tools-lock.json).
The optional runtime experiments have separate commands in their report.

Original image SHA-256:
`984b616f34f5d96ed9e0f6a7a00f229afd7386b1460908451daf649fd90b333d`.

## Main output locations

| Path | Purpose |
|---|---|
| `artifacts/disc/` | Exact Windows ISO9660 file bytes |
| `artifacts/mac/` | HFS files/forks, resource inventories and native Mac fragments |
| `artifacts/projector/` | Windows embedded startup, libraries and Xtras |
| `artifacts/decompiled/<MOVIE>/scripts-by-chunk/` | Authoritative stable `Lscr-ID.ls` and `.lasm` pairs |
| `artifacts/decompiled/<MOVIE>/casts/` | Human-friendly named script aliases; names can collide |
| `artifacts/decompiled/<MOVIE>/chunks/` | Original binary chunks and parsed JSON metadata |
| `artifacts/editable/` | Reconstructed `.dir`/`.cst` containers with source text restored |
| `artifacts/analysis/movies/` | Cast/member/resource identity, handlers, globals and dependencies |
| `artifacts/analysis/scores/` | Authored movie frame states, deltas, labels and behavior spans |
| `artifacts/analysis/filmloops/` | Decoded film-loop timelines |
| `artifacts/analysis/text/` | Plain text exports; style bytes retained in movie index |
| `artifacts/analysis/xmed/` | Rich text, font/style/run data and raw Paige sections |
| `artifacts/media/` | Exported bitmaps/audio/palettes and coverage/provenance manifests |
| `artifacts/runtime-tests/` | Runtime audits, browser playthroughs, screenshots and device tests |

Original assets and generated binaries stay local under ignored directories.
Scripts, reports and patches are separate from the proprietary disc content.
See the runtime/tool reports for the upstream open source licenses.
