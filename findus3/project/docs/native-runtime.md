# Native runtime and hybrid Macintosh disc analysis

The game is authored in **Macromedia Director 7**, running the **7.0.2r85** player. The Windows executable and Macintosh application are native projectors that embed a small Director startup movie plus the player libraries and media Xtras. Flash Asset is one bundled Xtra, which does not establish that the game itself is Flash. The application-specific logic is in Director movies/casts and Lingo bytecode.

## Extraction and provenance

Run from the project root:

```sh
python3 -m venv .venv
.venv/bin/pip install machfs==1.3 macresources==1.2 pefile==2024.8.26
.venv/bin/python scripts/extract_projector.py artifacts/disc/FINDUS3.EXE artifacts/projector
.venv/bin/python scripts/extract_hfs.py artifacts/CD01.iso artifacts/mac
```

Extraction is read-only with respect to the image and original executables. No original executable was run. `manifest.json` files preserve source offsets, original names, SHA-256 hashes, fork sizes, and parsed native metadata. `raw/` preserves the original embedded movie and compressed Xtra wrappers. Rebased `.dir` files record each modified 32-bit offset, so original data and transformations remain distinguishable.

## Windows

Original `FINDUS3.EXE`: 2,441,786 bytes; SHA-256 `6168d6891c974d4df896eb74892765fa420daf4b5891e40da7766d69c4c7043b`. PE32 machine `0x014c` (Intel i386), GUI subsystem, linker 5.10, preferred image base `0x00400000`, entry RVA `0x1000` (VA `0x00401000`). The PE timestamp is 1999-05-23 23:32:34 UTC. There are no COFF symbols or PE debug directory. The shim identifies itself as `OTTO` / `Otto.exe`.

The last four bytes contain little-endian offset `0x27c00`, whose header is `00JP` (the little-endian representation of `PJ00`). Its APPL container pointer is `0x1b8ce8`. Three 52-byte records identify the embedded DLLs. The APPL dictionary associates nine Xtras and `Start.dir` with the original authoring-system paths. The latter mentions `C:\WINDOWS\Skrivbord\Fredrik\Start.dir`; this is a provenance string, not a live dependency.

| Component | Bytes | Original offset | Version | Entry VA |
|---|---:|---:|---|---|
| `native/projector-shim.exe` | 162,816 | `0x0` | 7.0.2r85 | `0x401000` |
| `native/dirapi.dll` | 967,168 | `0x27ce8` | 7.0.2r85 | `0x68001110` |
| `native/iml32.dll` | 394,752 | `0x113ee8` | 7.0.2r85 | `0x69001110` |
| `native/msvcrt.dll` | 280,576 | `0x1744e8` | 5.00.7128 | `0x78008ff0` |
| `xtras/Mix Services.x32` | 64,000 | `0x1b92f6` | 1.16 | `0x6d28d700` |
| `xtras/Sound Import Export.x32` | 54,784 | `0x1c10aa` | 7.0.2r85 | `0x6d2cba50` |
| `xtras/TextXtra.x32` | 333,824 | `0x1c7102` | 7.0.2r85 | `0x6a04d090` |
| `xtras/Text Asset.x32` | 50,688 | `0x1f84c6` | 7.0.2r85 | `0x6d00a150` |
| `xtras/Font Xtra.x32` | 230,400 | `0x1fe6a0` | 7.0.2r85 | `0x6a12ee90` |
| `xtras/Font Asset.x32` | 49,152 | `0x21ed5e` | 7.0.2r85 | `0x6d046bf0` |
| `xtras/MacroMix.x32` | 35,328 | `0x2244a6` | 7.0.2r85 | `0x6e141e60` |
| `xtras/DirectSound.x32` | 16,384 | `0x227740` | 7.0.2r85 | `0x6e1431c0` |
| `xtras/Flash Asset.x32` | 286,720 | `0x229988` | 7.0.2r85 | `0x6a239370` |

`Start.dir` begins at `0x25194e`, is 10,472 bytes, and has a little-endian `XFIR/MV93` container. `artifacts/projector/Start.dir` rebases the imap pointer and 28 mmap entries. It can be passed directly to ProjectorRays. The executable startup movie must be analyzed separately from `MAIN/START.DXR`; byte equality is not assumed.

The Xtras use an outer literal `RIFF` wrapper with big-endian sizes, an `Xtra` form, and a `FILE` chunk. Its 28-byte header records Finder type/creator, expanded data/resource lengths, and compressed lengths. The two forks are separately zlib-compressed. All nine Windows data forks decompress to valid PE32 binaries, and all size checks pass.

## Macintosh

The ISO also contains an Apple partition map and classic HFS partition. The HFS partition starts at 512-byte block 4,875 (byte 2,496,000) and spans 226,047 blocks. Its partition label is `Toast 3.5.7 PPC Partition`. The extraction preserves 44 files, including hidden Finder desktop databases, with separate data and resource forks and file type/creator/flags/timestamps. It retains all 38 Main movie/cast files; each is **byte-for-byte identical** to its Windows ISO9660 counterpart. These assets do not require a second independent content decompilation.

`Findus3` has Finder type `APPL` / creator `PJ00`, a 2,925,496-byte data fork, and a 122,714-byte resource fork. The `vers` resources identify Macromedia Director 7.0.2r85. The data fork starts with a big-endian `PJ00` header pointing to APPL at `0x21af08`. Five `cfrg` records identify **PowerPC (`pwpc`) PEF/Code Fragment Manager** fragments. This is a classic Mac OS executable, not Mach-O. No m68k fragment appears in `cfrg`, and there is no `CODE` resource; a legacy WDEF resource is present.

| PEF fragment | Original data-fork offset | Extracted bytes | Loader main section:offset |
|---|---:|---:|---|
| `Director 7.0 Resources` | `0x10` | 53,091 | `1:0x7f0` |
| `DPLib` | `0xcf80` | 1,449,830 | `1:0x33bc` |
| `IMLLib` | `0x16eef0` | 550,996 | `1:0x1ac8` |
| `MacromediaRuntimeLib` | `0x1f5750` | 76,242 | `-1:0x0` |
| `WinSock Lib` | `0x208124` | 77,282 | `-1:0x0` |

These loader positions are PEF section-relative main descriptors, not raw PowerPC instruction entry addresses. Section 1 is packed data; relocation/unpacking and transition-vector resolution are needed before treating them as native call targets. `WinSock Lib` declares length zero in `cfrg`; its extraction length is inferred from PEF section extents and the fact that the following bytes are projector data. Native manifests also include sections, imported libraries/symbols, and export counts. The original entire data fork remains preserved.

The Mac APPL embeds seven Xtras: Mix Services, Sound Import Export, TextXtra PPC, TextAsset PPC, Font Xtra PPC, Font Asset PPC, and Flash Asset PPC. They have preserved resource forks, parsed resource inventories, and PowerPC PEF metadata. Windows-only MacroMix and DirectSound Xtras are absent. Mac `Start.dir` is at `0x2c7aaa`, is 10,510 bytes, and has a big-endian `RIFX/MV93` container; the rebased extraction is `artifacts/mac/projector/Start.dir`. Original authoring paths include `Findus warted ver2:Skarp version:Mac:Start.dir`.

## Reverse engineering scope and limitations

For a portable implementation, recover Lingo, score/timeline data, cast-member metadata, and media first. Reimplement the behaviors and rendering semantics or use a compatible Director runtime. Native decompilation of the commercial player would mostly reconstruct generic Director infrastructure and is much larger than the application-specific code. The extracted DLL/Xtra imports and exports provide targeted entry points if unsupported runtime behavior later needs investigation. A bundled Xtra does not prove any particular cast member actually uses it.

This report covers structural extraction and native-format identification, not a complete source decompilation of the proprietary x86/PowerPC player. No execution equivalence, platform emulation, or arbitrary-path safety for untrusted images is claimed. The extraction scripts deliberately validate this disc’s observed Director 7 structures rather than claiming support for all projector generations. For a native matching project, reccmp requires reconstructed source and a suitably comparable build; an EXE alone is not an automatic decompilation input. The Lingo/Director artifacts are the productive portability boundary.

## Format references

- [ScummVM Director projector loader and mmap rebasing](https://github.com/scummvm/scummvm/blob/master/engines/director/resource.cpp).
- [machfs HFS reader](https://github.com/elliotnunn/machfs).
- [GNU binutils PEF structure reader](https://chromium.googlesource.com/native_client/nacl-toolchain/+/refs/tags/binutils-2.20/binutils/bfd/pef.c).
- [ProjectorRays supported reconstruction workflow](https://github.com/ProjectorRays/ProjectorRays/blob/master/README.md).
