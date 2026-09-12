# Data layout, verification and recovery-tool changes

## Resource identity

The stable identity is `(input container, resource ID)`. Each `Lscr-ID.ls` has a
matching `.lasm`, raw `chunks/Lscr-ID.bin`, and parsed header JSON. A named alias
under `casts/` is only a convenience: three pairs of records have colliding
labels/member names. The resource-indexed export retains all of them.

`artifacts/analysis/movies/<NAME>.json` records cast-library order, external paths,
member numbers, CASt chunk IDs, asset children from KEY*, source-resource IDs,
handler names, globals and properties. External file paths must be resolved by
the loader, not used as names for local cast resources. This disc's external
casts reuse numeric ID 1024, which belongs to their own file's resource map.

All published `.CXT` files on this disc have an MV93 container codec. Unmodified
ProjectorRays therefore gives them `.dir` output suffixes. The pipeline keeps
that raw output and copies them to conventional `.cst` names in
`artifacts/editable/MAIN/`, without rewriting their codec. Opening and resaving
these reconstructed authoring files in original Director has not been tested.

## Timeline format

Score and film-loop JSON come from the **original** dumped VWSC/SCVW chunks,
not a runtime trace. Each score has 48-byte records, with six control records
followed by sprite channels. Frames apply byte deltas to the previous state.
The export supplies a complete control state and the changed sprite records on
each frame. Carry sprite records forward until changed; a zero record removes
the corresponding authored sprite.

Sprite fields include member/cast references, position, dimensions, ink/trails/
stretch flags, colors, blend, rotation/skew raw values and behavior-detail index.
Control data includes frame scripts, tempo, transition, sound and palette
references. Span records include bounds, channels, keyframes, tween parameters,
behavior script references and initializer text. Raw records are retained for
unknown fields and future parser corrections.

These are **authored states**. Lingo changes such as `puppetSprite`, visibility,
member swaps, depth order and calls to `go` are not applied. Tween interpolation,
ink compositing, registration/matte logic and sound cue scheduling remain runtime
operations. The 1,878 main frames and 626 film-loop frames are structural counts,
not a linear playback duration.

Format offsets were checked against pinned ScummVM
[score.cpp](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/engines/director/score.cpp),
[frame.cpp](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/engines/director/frame.cpp), and
[spriteinfo.h](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/engines/director/spriteinfo.h).

## Text and encoding

Raw game bytes remain in the chunk dumps and canonical script files. Most
identifiers are ASCII; nine resource-indexed source files contain legacy high
bytes. Some Swedish-looking identifiers do not decode plausibly as either
MacRoman or Windows-1252. Do not silently rename these symbols. Their raw bytes
and Lnam name-table indices remain authoritative.

The patched JSON writer represents legacy bytes as U+00NN, an explicitly
reversible byte transport, rather than claiming those code points are the
correct displayed text. The analysis index uses MacRoman as a display
interpretation of names and text because these external containers declare a
Mac authoring platform. Use raw chunks/name IDs when exact identity matters.
Plain STXT text is exported separately; its style trailer is retained as hex.
The five XMED rich-text assets are decoded into text/font/style/run metadata and
lossless Paige section/token data in `artifacts/analysis/xmed/`. Their content
appears to be authoring notes. Rendering the layouts and proving runtime
reachability remain separate questions.

## ProjectorRays fixes

Pinned upstream revision:
`6f9bcebf626b43719abe2affcbbcb041d154d666`.
The complete changes are in `patches/projectorrays-findus.patch`:

1. Skip external cast entries when binding a movie's local CAS*/Lctx. Repeated
   external IDs previously renamed the same local cast to names such as `dagar`,
   `honor` or `Routs`.
2. Export every parsed Lscr by resource ID, avoiding named-alias collisions.
3. Also expose unmapped records in the named alias output. Most are empty.
4. Produce valid JSON escaping for strings and four-character codes. Upstream
   emitted C-style `\xNN`/`\v`, which JSON rejects.
5. Remove shadowed, uninitialized Lnam fields so JSON exposes the names actually
   parsed in the base class.
6. Emit `castCount` instead of a duplicate `itemsPerCast` key.
7. Report each handler's own `globalsOffset`, not the enclosing script's offset.

These changes repair export and binding behavior; they do not replace the
decompiler's expression/control-flow reconstruction algorithm. The MPL-2.0
license of upstream ProjectorRays continues to apply to its modified files.

## Verification boundary

`scripts/verify_artifacts.py` re-reads resource maps from original and rebuilt
containers. It checks that every live resource ID survives, that only container
maps/configuration/cast source-text records change, and that all bytecode, names,
media and timelines remain byte-identical. Original files may omit a final
single-byte RIFF pad; resource bounds are still checked individually.

The sector extractor checks MODE1 sync and header framing, not raw EDC/ECC or
subchannel correctness. HFS files retain both forks. Native projector manifests
separate verbatim embedded payloads from rebased Director containers.

An independent instruction audit supplements the resource preservation check.
Neither proves the decompiled Lingo will recompile identically or that a
particular open source runtime reproduces every game behavior. Those questions
need original-runtime reference captures and complete interactive testing.
