# Decoded media and remaining rendering work

`scripts/export_media.py` converts the game’s extracted Director media into portable assets. The current run exports **2,047 bitmap PNGs, four PICT PNGs, 540 PCM WAVs, and 19 palettes**, with **zero decoder failures**. Two additional bitmap members are deliberately empty: DAG15’s `Layer 20` cast members have zero width/height and no BITD child. They remain in the manifest as `empty_bitmap`, rather than receiving invented pixels.

Run after the ProjectorRays chunk export:

```sh
.venv/bin/pip install Pillow==12.3.0
.venv/bin/python scripts/export_media.py
.venv/bin/python scripts/export_xmed.py
```

The default output is `artifacts/media/`. The global `manifest.json` maps each asset to its movie, cast-library index/name, cast slot, CASt chunk, media chunk, original member name, and source/output SHA-256. The mapping follows MCsL → KEY* → CAS* → CASt → KEY* media children, including non-1 starting cast slots and multiple internal cast libraries. `summary.json` reports coverage; `failures.json` is an empty array for this disc. Names decode the legacy MacRoman bytes retained in the ProjectorRays JSON.

## Bitmap decoding

The exported BITDs comprise 1,848 indexed 8-bit images, 132 monochrome images, 63 32-bit images, three nonempty 16-bit images, and one 2-bit image. The exporter reads the D7 bitmap geometry, pitch, registration point, alpha threshold, update flags, and palette reference from each CASt record. It handles both literal and Director RLE streams, packed 1/2-bit pixels, RGB555, and the per-row planar storage of compressed 16/32-bit images.

Every decoded stream exactly matches the declared pitch × height; no zero padding or dropped overrun hides truncation. Every PNG is reopened and its dimensions and pixel bytes checked against the decoded image. Canvas and image-relative registration points are retained in the manifest. These matter when placing a sprite at its score coordinates.

All 63 32-bit BITDs have a constant zero first plane. The PNGs use opaque RGB, consistent with Director’s BITD pixel decoder. Sprite ink, matte transparency, and compositing still belong to the renderer. No white/black background removal is applied. The original chunks preserve the storage bytes and unused plane.

The PNGs retain indexed pixels when applicable. Palette provenance is explicit:

| Palette category | Images | Interpretation |
|---|---:|---|
| Directly identified | 1,518 | Includes four PICT color tables, built-in palettes, local custom palettes, and direct RGB |
| Unique movie palette inferred | 479 | The cast stores global library reference 0; the matching palette slot is unique among that movie’s embedded libraries |
| Requires host movie context | 54 | PETTTALK refers to custom palette member 1, absent from the external cast; previews use Mac system colors |

The 54 PETTTALK images preserve their exact indices, so they can be recolored when the host palette is selected. Even a directly identified source palette does not prove final screen colors: Director can dither against or change the score palette during playback. The 19 custom CLUT resources are exported as ordered RGB arrays. Built-in tables come from the pinned ScummVM reference file `tools/reference/scummvm-graphics-data.h`, whose GPL-3.0-or-later copyright/license header is retained.

## PICT images

The four DAG18 `tomte*.PCT` members contain PICT version 2 drawings with a single 8-bit PackBitsRect operation and embedded 256-color tables. The exporter walks and validates the complete version/header/comment/clip/bitmap/end opcode sequence, row lengths, color-table indices, source/destination bounds, and copy mode. All four decode without omitted operations.

`artifacts/media/pict/DAG18/` also preserves standalone `.pict` files made by prepending the conventional 512-byte zero header to the unchanged resource bytes. macOS `sips` initially reported a successful conversion but produced a blank white image; those outputs were discarded. The committed Python decoder produced visible illustrations and passes the structural checks. All four were visually inspected together in `pict-contact-sheet.png`.

## Audio

The 540 `snd ` chunks are zero-byte markers. The playable audio is in **540 `sndH`/`sndS` pairs**, using Director’s MoaSoundFormat header and uncompressed PCM samples. The exporter parses the 100-byte headers and preserves sample rate, frame count, byte rate, bit depth, channels, playback bounds, and loop bounds. The compression GUID is zero for every sound. Header size and frame-count calculations match every sample stream exactly.

All sounds are mono: 493 use unsigned 8-bit PCM and 47 use signed 16-bit big-endian PCM. WAV export swaps the latter to little endian without resampling. Rates are 22,050 Hz for 534 sounds, 11,025 Hz for three, 44,100 Hz for two, and 22,254 Hz for one. WAVs are reopened and their frame counts and full PCM payloads verified. Total duration across all stored sound members is approximately 61 minutes 32 seconds, including duplicated assets.

Playback and loop bounds are metadata rather than WAV `smpl` loops; a portable player must apply them alongside the game’s Lingo sound-channel logic. The raw headers and samples remain available in the decompiled chunk directories. This verification establishes faithful PCM export, not an auditory comparison against the original runtime.

## Coverage boundary

The independent score exporter also decodes all nine SCVW filmloop timelines (626 frames) into `artifacts/analysis/filmloops/`; movie score timelines are in `artifacts/analysis/scores/`. Text exports are in `artifacts/analysis/text/`. A filmloop is a reusable timeline referencing cast members, not a missing bitmap or encoded video file.

All five rich-text XMED payloads are also decoded by `scripts/export_xmed.py` into `artifacts/analysis/xmed/`. It preserves every source byte across 17 Paige sections per document, expands the variable-length numeric/repeat/pointer encoding, and exports exact text, fonts, all style records, colors, point sizes, bold/italic/underline, character runs, paragraph runs, and known paragraph fields. Original CR line endings and raw run positions remain intact. The JSON retains unknown housekeeping fields as expanded numeric values and raw bytes, without assigning guessed meanings.

The recovered content is `Tyskland -->` (PETTTALK), `Grafik -->`, `Script -->`, `Ljud -->`, and a multiline backdrop-position/size note (DAG17). The four labels use Geneva 12; the backdrop note's active style is Arial 14, bold, dark red. The style prefix values on this disc are last valid indices (0 for one style, 4 for five), matching the independent section-header record counts; treating that prefix as a count would incorrectly discard a sole style. The exporter verifies all record boundaries and preserves both fields.

The contents appear to be authoring notes. Static score scanning found no authored sprite-update references to the four DAG17 rich-text members, but dynamic Lingo reachability is not established. PETTTALK is an external cast, so its usage requires host bindings. Text layout/fonts, sprite ink and matte semantics, dynamic palettes, and complete score/Lingo execution still require a renderer/runtime implementation. Media coverage is therefore not an end-to-end playable port, and no claim of screen-for-screen equivalence is made.

Representative bitmap backgrounds and all four PICT illustrations were visually checked. `artifacts/media/contact-sheet.png` and `artifacts/media/pict-contact-sheet.png` are reproducible inspection sheets; adjacent JSON files identify their source assets.

## Format references

- [Director bitmap cast fields](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/engines/director/castmember/bitmap.cpp), [BITD decoding](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/engines/director/images.cpp), and [built-in palette tables](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/engines/director/graphics-data.h).
- [Director MoaSoundFormat decoding](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/engines/director/sound.cpp).
- [ScummVM PICT v2 decoding](https://github.com/scummvm/scummvm/blob/37007c3660b991e6fddfa5b7e9fde16dab1813a3/image/pict.cpp).
- [DirPlayer Paige/XMED text, numeric packing, styles, fonts, and paragraph decoding](https://github.com/igorlira/dirplayer-rs/blob/68376fbb4494a6bbad4c70081ecdcb99814a74c9/vm-rust/src/director/chunks/xmedia_styled_text.rs). The source-informed standalone XMED exporter is marked GPL-3.0-only, matching DirPlayer; it does not require DirPlayer to run. The license text is retained in `LICENSES/GPL-3.0.txt`.
