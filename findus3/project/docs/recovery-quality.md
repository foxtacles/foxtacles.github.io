# Recovery quality and independent audit

The extraction has complete **structural Lingo coverage** for this disc: all 829 recovered script resources contain 969 handlers, and every handler is present in both source and disassembly. This establishes a sound basis for a port. It does not establish that recompiling the reconstructed source reproduces the original program, or that an open-source runtime plays every activity correctly.

## What was independently checked

Run `python3 scripts/audit_lingo.py` after decompilation. The machine-readable result is [artifacts/lingo-audit.json](../artifacts/lingo-audit.json); the audit implementation is [scripts/audit_lingo.py](../scripts/audit_lingo.py).

| Measurement | Result |
| --- | ---: |
| Containers, including both embedded startup movies | 40 |
| Original dumped `Lscr` resources | 829 |
| Raw-byte handler headers | 969 |
| Reconstructed source handler declarations | 969 |
| Disassembly handler declarations | 969 |
| Independently counted bytecode instructions | 62,470 |
| Compiled handler bytes | 131,405 |
| Zero-handler script resources | 84 |
| Empty source/disassembly files | 82 each |
| Non-UTF-8 source files | 9 |
| Structural audit failures | 0 |

The audit reads the D7 handler count/table offset and each 42-byte handler entry directly from original dumped `Lscr` bytes. It compares every field against ProjectorRays JSON, resolves handler names against original raw `Lnam` Pascal strings, and compares those names with both outputs. It independently walks instructions using the encoded operand-width bits and compares every byte offset with `.lasm`. It checks bytecode bounds and requires identical source/disassembly resource sets. This is stronger than counting files or accepting the decompiler's exit status, but does not independently validate opcode mnemonic/operand interpretation or the source's reconstructed control flow.

The two nonempty zero-handler source files are `DAG10/Lscr-1590` and `DAG10/Lscr-1618`: each contains only `global listSize`. Empty resources are therefore not evidence of failed decompilation. All scripts have a unique name-table context in this dataset. The cast manifest associates 811 scripts with a member and leaves 18 without a member binding; those 18 all have zero handlers. Member binding and executable resource identity are separate concepts.

The raw-byte audit uses the dumped resources. The separate container verification must establish that those dumps correspond to all original resource-map entries; the audit is not a replacement for that check. Hashes in the decompilation manifest and audit retain provenance.

## Resource identity and patched decompiler

The [ProjectorRays patch](../patches/projectorrays-findus.patch) corrects several material export problems:

- External cast entries reuse resource IDs local to their own file. Resolving them against the current movie had repeatedly renamed its local cast—for example, calendar scripts appeared under the external `dagar` library. Skipping external entries when loading local `CAS*`/`Lctx` fixes that ownership error while the analysis manifest retains the full library order and dependency paths.
- Dumping all deserialized script resources to `scripts-by-chunk/Lscr-<resource-ID>` captures scripts without cast-member bindings and avoids filename collisions. These paths are the canonical script identities. The `casts` directory is a browsing convenience; some names still collide, including in `SHARED16`, `DAG19`, and `DAG18`, so it must not be the input to coverage measurements or an automated port.
- Removing shadow fields from `ScriptNamesChunk` exposes the name data actually read by its base class. JSON now reports the true cast count and each handler's own globals offset.
- JSON string escaping now produces valid JSON and preserves individual legacy byte values as `U+00NN`. This is a byte transport convention, not Unicode decoding.

The analysis resolves member scripts through `CASt.info.scriptId`, the owning library's `Lctx` slot, and its `Lscr` resource. This agrees with ProjectorRays' context/member lookup. External cast resources sometimes retain packed `Lscr.castID` values from different authoring-library positions; these values should not override the cast relationship established by the actual importing movie.

The review identified that old dump files could survive a rerun, making comparisons between two stale file sets misleading. The decompilation driver was updated to recreate each per-input dump directory and remove the prior generated container before running. Resource-ID outputs, raw chunk inventory, hashes, and the independent audit should be retained together.

Generated `.dir`/`.cst` files are reconstructed authoring containers. Their presence is not proof that Director has opened, recompiled, and successfully played them. Do not use their filename extension or decompiler completion status as a compatibility result.

## Legacy encoding: unresolved identifiers are preserved

The nine non-UTF-8 source paths are enumerated in the audit JSON. This is not a failure to recover bytes: the raw name tables contain those bytes, and both ProjectorRays `ScriptNames::read` and ScummVM `LingoArchive::addNamesV4` preserve name strings without applying Unicode decoding. See the [ProjectorRays name reader](https://github.com/ProjectorRays/ProjectorRays/blob/master/src/lingodec/names.cpp) and [ScummVM bytecode loader](https://github.com/scummvm/scummvm/blob/master/engines/director/lingo/lingo-bytecode.cpp).

`DAG02` illustrates why a blanket conversion is unsafe:

| Original bytes | Where used | Interpretation |
| --- | --- | --- |
| `sp 9A` | String literal naming rod artwork | MacRoman gives the plausible Swedish `spö`. |
| `spNumSp E0` | `Lnam-958`, name 30 | MacRoman gives `spNumSp‡`; CP1252 gives `spNumSpà`. |
| `l E2 ngd` | `Lnam-958`, name 42 | MacRoman gives `l‚ngd`; CP1252 gives `lângd`. |

The movie's `DRCF` platform field is Macintosh. Its `FXmp-968` table maps byte `E0` to Windows byte `87` and `E2` to `82`, which still displays as `‡` and `‚`; the map does not repair these names. ScummVM uses platform-sensitive decoding and the FXmp cross-platform map for display strings, while retaining raw bytecode names; see its [cast text decoder](https://github.com/scummvm/scummvm/blob/master/engines/director/cast.cpp) and [font-map loader](https://github.com/scummvm/scummvm/blob/master/engines/director/fonts.cpp).

Historical compiler normalization or earlier text corruption may explain the identifiers, but this has not been established. Do not replace the bytes with guessed Swedish letters. A port should keep raw name IDs/bytes as identity and use explicit, reversible aliases for developer-facing names if needed. MacRoman-rendered names in analysis reports are display interpretations; the raw chunks and `U+00NN` JSON strings remain the reference. Cast text, labels, filenames, string literals, and identifiers need separate encoding decisions.

## Decompiled source and score caveats

No emitted `ERROR`, unknown-name/argument/local placeholders, or unsupported-opcode warning was found in the inspected generated source, disassembly, or decompilation logs. This only means that ProjectorRays accepted the patterns it encountered. Its source reconstructor uses heuristics to recover loops, cases, and conditionals; lack of diagnostics is not a proof of equivalence.

Concrete patterns checked during review include:

- `DAG21/Lscr-180.mouseUp` repeats shuffling **while** `check_completed()` is true. The branch at bytecode offset 24 exits on false and the instruction at 41 loops to 20. The surprising condition is supported by the bytecode: it rejects accidentally solved initial boards. It should not be inverted as an apparent decompiler mistake.
- `DAG02/Lscr-960.kollaKanten` has a tight `repeat while maxvinkel > 1` whose body calls other handlers. `nyPosLina` reduces the global amplitude by `vinkelDec`; the loop is not missing its update. Converting it into a browser-blocking loop nevertheless needs care because rendering/input timing is part of the runtime contract.
- Decimal values such as `0.14999999999999999` are expanded representations of recovered floating-point constants. Their appearance alone does not justify rounding all arithmetic. Integer `/` operations in `DAG21/Lscr-176` determine tile rows, so JavaScript's numeric rules cannot simply replace Lingo's.
- `go(...)` can be followed by further bytecode in the same handler. Treating every movie/frame change as a JavaScript `return` changes the program. The frame-event and movie-transition behavior needs a reference-runtime trace.

The score parser's six 48-byte control records, sprite offsets, coordinate order, cast/member fields, and color/ink fields agree with ScummVM's D7 frame reader. It reconstructs authored delta state and preserves raw records. It does not execute Lingo, apply puppet mutations, resolve tween interpolation, render ink effects, or establish event ordering. The recovered 1,878 movie score frames and film-loop timelines provide essential program data, not a finished playback engine. See [ScummVM's frame decoder](https://github.com/scummvm/scummvm/blob/master/engines/director/frame.cpp).

The strongest next validation is an original-runtime session with deterministic inputs, stage captures, audio/channel events, and movie/frame transitions for each activity. The [game architecture report](game-architecture.md) lists concrete paths to exercise. Until those comparisons pass, describe the work as complete extraction and substantial static reverse engineering, with runtime fidelity still to validate.
