# reccmp assessment for Findus wartet auf Weihnachten

Assessment date: 2026-09-11. Tool capabilities below were checked against their maintainers' documentation. Disc-specific findings were read directly from the extracted files in this project.

## Decision

Use Director/Lingo decompilation as the main recovery path. Use `reccmp` later if a native, game-specific function actually needs reconstruction. The extracted game contains Director movies and casts, and its Windows launcher identifies itself as Director Player 7.0.2r85. The launcher is not an appropriate proxy for the amount of game logic recovered.

`reccmp` compares manually reconstructed C++ compiled back into a Windows binary against the original machine code. Its documented supported target is 32-bit x86 C++ built with older Microsoft Visual C++ toolchains. It does not recover Lingo, ActionScript, sprites, sound, timelines, or casts. Its source-address annotations and the rebuilt program's PDB connect original addresses to the reconstructed functions. **The original game's PDB is not required; the rebuilt program's PDB is.** [reccmp overview](https://github.com/isledecomp/reccmp), [build configuration schema](https://github.com/isledecomp/reccmp/blob/master/reccmp/project/config.py).

## Evidence from this disc

| Observation | Direct evidence | Meaning |
| --- | --- | --- |
| Windows x86 launcher | `artifacts/disc/FINDUS3.EXE`: PE machine `0x014c`, PE32, image base `0x00400000`, entry RVA `0x1000` | The launcher is 32-bit native Windows code. |
| Old Microsoft linker | PE optional-header linker version `5.10`; Microsoft Visual C++ Runtime Library string at file offset `0x138d8` | Compatible with the general era targeted by reccmp, but the exact compiler/options are not proved by a linker version alone. |
| Director version | UTF-16 version resource: `Director Player`, `7.0.2r85`, `Macromedia Director`; version string at `0x25d2c` | Positive identification of the native Director projector. |
| Native code is a small part of the launcher package | Outer PE has `.text`, `.rdata`, `.data`, `.rsrc`; raw sections end at `0x27c00`, while the complete file is 2,441,786 bytes | Appended material must be parsed as a projector package; loading only the outer PE into a decompiler misses most of that material. |
| Original debug metadata absent from outer PE | Debug data directory RVA and size are zero | Not an obstacle to reccmp's intended workflow, because new debug symbols come from the reconstructed build. |
| Director game containers | `MAIN/START.DXR`, `INTRO.DXR`, `KALENDER.DXR`, `DAG01.DXR`–`DAG24.DXR`, other `.DXR` movies and `.CXT` casts | These are the primary sources of game-specific scripts and media. |
| Flash support is packaged with Director | Embedded paths beginning near `0x1b8fc4` include `DIRECTOR 7\\xtras\\Flash Asset\\Flash Asset.x32`, alongside Text, Font, DirectSound, and MacroMix Xtras | A Flash-related string in this executable does not establish that the game itself is Flash. Actual cast payloads must establish Flash usage. |

Launcher SHA-256: `6168d6891c974d4df896eb74892765fa420daf4b5891e40da7766d69c4c7043b`.

The outer PE identification does not establish the architecture of every embedded object or the whole original disc. The disc can contain platform-neutral Director data and additional platform-specific material independently of its Windows launcher.

## Tools matched to each layer

| Layer | Tool | Intended result and boundary |
| --- | --- | --- |
| Director movies/casts and Lingo bytecode | [ProjectorRays](https://github.com/ProjectorRays/ProjectorRays/blob/master/README.md) | Reconstruct Lingo and editable `.DIR`/`.CST` files from protected/published Director input. Its maintainers identify it as a work in progress, so every failure and script gap must remain visible. |
| Director runtime semantics | [ScummVM Director engine source](https://github.com/scummvm/scummvm/tree/master/engines/director) | Reference implementations for archive parsing, cast members, score/sprites, audio, events, and Lingo. Presence of these implementations alone does not prove this title is playable. |
| Actual embedded SWF, if any | [JPEXS Free Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler) | Extract Flash assets and ActionScript and inspect SWF timelines. Use on positively identified SWF payloads, not arbitrary Director files. |
| Native launcher or custom Xtra | [Ghidra](https://github.com/NationalSecurityAgency/ghidra) | Static disassembly, C-like decompilation, references, and scripting for native routines. Recover behavior and data structures before attempting a source rebuild. |
| Native alternative | [Cutter/Rizin](https://github.com/rizinorg/cutter) | Cross-platform native analysis UI with an available Ghidra decompiler integration. Useful if its inspection workflow fits the task better. |
| Native execution trace | [x64dbg/x32dbg](https://x64dbg.com/) | Windows debugger for EXEs/DLLs, module loading, memory, imports, and breakpoints. Select its 32-bit debugger for this launcher. |
| Reconstructed native implementation | [reccmp](https://github.com/isledecomp/reccmp) | Compare functions and layout after compiling a reconstruction; produce HTML/JSON progress evidence. This is a validation stage, not the source recovery stage. |

ProjectorRays's documented Unix invocation is `./projectorrays decompile <input path>`. It can operate on a file or directory and emits restored Director project files. The tool also documents Boost, mpg123, and zlib as build dependencies. [ProjectorRays usage](https://github.com/ProjectorRays/ProjectorRays/blob/master/README.md).

## Recommended recovery order

1. Keep the disc and extracted originals immutable. Record image/container/file hashes and offsets linking every recovered object to an original. Decompile working copies.
2. Decode all movies, all external casts, and projector-embedded movies. Export both readable Lingo and original bytecode/disassembly so decompiler guesses can be checked.
3. Export a structured manifest of cast IDs, member types/names, linked files, shared-cast order, sprite channels, score frames, labels, palettes, registration points, and sound metadata. Source text without these mappings cannot reproduce a Director game.
4. Inventory every Lingo call that crosses into an Xtra, an XObject, the filesystem, printing, the clock, or another movie. Classify a native module as a portability requirement only when game code or runtime tracing demonstrates that dependency.
5. Establish original-runtime behavior traces: initial state, movie changes, puzzle actions, completion conditions, persistence, timing, and input coordinates. Compare recovered control flow with those observations.
6. For any necessary undocumented native routine, inspect the module with Ghidra and dynamically verify the routine's contract. Prefer reimplementing that narrow contract in the future port rather than reconstructing unrelated runtime subsystems.
7. If native binary fidelity is useful, start the separate reccmp workflow below. Keep its function-match metrics separate from Lingo recovery coverage and gameplay compatibility.

These steps are project recommendations inferred from the architecture identified on this disc; they are not claims that a tool performs the complete workflow automatically.

## Concrete future reccmp workflow

This is a proposed workflow, **not a claim that a native reconstruction has been built or matched**. Do not fabricate function addresses, placeholder comparisons, or a success percentage. A useful target begins with a real recovered native implementation and a compiler toolchain suitable for its original binary.

The current package metadata requires Python 3.10 or newer. [reccmp Python requirement](https://github.com/isledecomp/reccmp/blob/master/pyproject.toml).

Use a dedicated native reconstruction directory with a pinned reccmp version. After identifying the exact original module, run:

```sh
python3 -m venv .venv
.venv/bin/python -m pip install reccmp
.venv/bin/reccmp-project create --originals /absolute/path/to/the/identified/module.dll --cmake-project
```

The generated CMake skeleton still needs recovered source and a suitable Windows x86 C++ compiler. Build it with debug information and a linker PDB while preserving the original optimization strategy as closely as possible. Record the compiler, linker, runtime libraries, calling conventions, structure packing, and optimization flags. Do not infer all of these from `5.10` alone.

Add a `FUNCTION` annotation using the actual original virtual address and the generated target name. Use `STUB` for incomplete functions. `STUB` annotations do not participate in assembly comparison. Native global variables and virtual tables have separate annotation types. [reccmp annotation specification](https://github.com/isledecomp/reccmp/blob/master/docs/annotations.md).

After building, run the following from the directory holding the reconstructed binary; replace `MODULE` with the target name from the generated configuration:

```sh
reccmp-project detect --what recompiled
reccmp-reccmp --target MODULE --html comparison.html
reccmp-reccmp --target MODULE --json comparison.json --silent
reccmp-decomplint --target MODULE
```

Use `reccmp-stackcmp`, `reccmp-datacmp`, `reccmp-vtable`, or `reccmp-verexp` when stack/global/vtable/export behavior is relevant. [reccmp commands](https://github.com/isledecomp/reccmp#tooling).

The configuration is split into a shared `reccmp-project.yml`, a local `reccmp-user.yml` describing original file locations, and a local `reccmp-build.yml` locating the rebuilt module and its PDB. Keep the first under version control, and exclude machine-specific paths in the latter two. [reccmp project files](https://github.com/isledecomp/reccmp/blob/master/docs/project_files.md).

## What success means for a web port

Recompiling the Windows Director player is not a necessary milestone for a web port. The useful deliverable is the game behavior, assets, and an explicit specification of the Director services it uses. A TypeScript/Canvas/WebAudio implementation or a compatible runtime compiled to WebAssembly will produce different native instructions, so reccmp's x86 match percentages cannot assess the quality of that port.

Use separate acceptance measurements:

- **Recovery coverage:** every original container parsed; every script accounted for; every media item exported or explicitly documented as unresolved.
- **Semantic coverage:** each scene, transition, puzzle, calendar rule, save path, and platform-specific operation described from recovered code and data.
- **Behavioral fidelity:** repeatable input traces produce the expected screen, audio, game state, and progression.
- **Native fidelity, only if pursued:** reccmp matches for specific reconstructed native targets, clearly scoped to those targets.

The principal uncertainty is not whether an old x86 launcher can be disassembled. It is whether all Director data, scripts, embedded media, and runtime edge cases can be recovered and validated. That uncertainty should remain explicit until the corresponding coverage evidence exists.
