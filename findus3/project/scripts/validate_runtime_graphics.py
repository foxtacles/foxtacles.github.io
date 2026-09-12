#!/usr/bin/env python3
"""Compare DirPlayer's native decoded images/score state with recovered data.

Build vm-rust/examples/findus_render_probe first. This deliberately bypasses
Lingo and audio, isolating file parsing, cast binding and authored composition.
It does not prove interactive game correctness.
"""
import argparse
import collections
import concurrent.futures
import json
import subprocess
from pathlib import Path
from urllib.parse import unquote, urlparse

from PIL import Image, ImageChops

BASE = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("movies", nargs="*", default=[])
    parser.add_argument("--frame", type=int, default=5)
    args = parser.parse_args()
    names = args.movies or ["KALENDER", "INTRO", "KICKER"] + [f"DAG{i:02d}" for i in range(1, 25)] + [f"KONSTR{i:02d}" for i in range(1, 4)] + ["PETTTALK"]
    output = BASE / "artifacts/runtime-tests/rendering"
    output.mkdir(parents=True, exist_ok=True)
    game = output / "aliased-game"
    game.mkdir(exist_ok=True)
    for source in (BASE / "artifacts/disc/MAIN").iterdir():
        if source.suffix.upper() not in (".DXR", ".CXT"):
            continue
        for name in (source.name, source.with_suffix(".cct" if source.suffix.upper() == ".CXT" else ".dcr").name):
            dest = game / name
            if not dest.exists():
                dest.symlink_to(source)
    binary = BASE / "tools/runtime-options/dirplayer-rs/vm-rust/target/debug/examples/findus_render_probe"
    manifest = json.loads((BASE / "artifacts/media/manifest.json").read_text())
    palettes = manifest["palettes"]
    media = manifest["media"]
    media = {(m["movie"], m.get("cast_library_index"), m.get("member_number")): m for m in media if m["type"] in ("bitmap", "pict") and m.get("status") == "exported"}

    def probe(name):
        directory = output / name
        movie_file = game / f"{name}.DXR"
        if not movie_file.exists():
            movie_file = game / f"{name}.CXT"
        try:
            run = subprocess.run([str(binary), str(movie_file), str(directory), str(args.frame)], capture_output=True, timeout=45)
        except subprocess.TimeoutExpired as exc:
            (output / f"{name}.log").write_bytes((exc.stdout or b"") + (exc.stderr or b""))
            return {"movie": name, "status": "timeout"}
        (output / f"{name}.log").write_bytes(run.stdout + run.stderr)
        if run.returncode:
            return {"movie": name, "status": "runtime_failure", "returncode": run.returncode}
        loaded = json.loads((directory / "loaded.json").read_text())
        comparisons = []
        for cast in loaded["casts"]:
            external = cast.get("external", cast["cast"] != 1)
            source_name = Path(unquote(urlparse(cast["file"]).path)).stem.upper() if external else name
            source_lib = 1 if external else cast["cast"]
            for bitmap in cast["members"]:
                asset = media.get((source_name, source_lib, bitmap["member"]))
                if not asset:
                    continue
                actual = Image.open(directory / bitmap["path"]).convert("RGB")
                expected = Image.open(BASE / "artifacts/media" / asset["output"])
                host_palette = None
                if asset.get("palette", {}).get("status") == "requires_host_movie_palette" and external:
                    palette_member = asset["palette"]["stored_member"]
                    candidates = [p for p in palettes if p["movie"] == name and p["member_number"] == palette_member]
                    if len(candidates) == 1:
                        host_palette = candidates[0]["output"]
                        colors = json.loads((BASE / "artifacts/media" / host_palette).read_text())["rgb"]
                        expected.putpalette([c for rgb in colors for c in rgb])
                expected = expected.convert("RGB")
                equal = actual.size == expected.size and ImageChops.difference(actual, expected).getbbox() is None
                comparisons.append({"cast": cast["cast"], "member": bitmap["member"], "source_movie": source_name, "source_cast": source_lib, "exact_rgb": equal, "palette_status": asset.get("palette", {}).get("status"), "host_palette": host_palette, "expected": asset["output"], "actual": str((directory / bitmap["path"]).relative_to(BASE)), "actual_palette": bitmap["palette"]})
        score_path = BASE / "artifacts/analysis/scores" / f"{name}.json"
        ground = json.loads(score_path.read_text()) if score_path.exists() else {"frames": []}
        states = {}
        for frame in ground["frames"]:
            if frame["frame"] > args.frame:
                break
            for sprite in frame["sprite_updates"]:
                states[sprite["channel"]] = sprite
        states = {ch: s for ch, s in states.items() if s["member"]}
        parsed = {s["channel_index"] - 5: s for s in loaded["score"] if s["member"]}
        differences = []
        for channel in sorted(states.keys() | parsed.keys()):
            a, b = states.get(channel), parsed.get(channel)
            fields = [key for key in ("cast", "member", "x", "y", "width", "height") if a is None or b is None or a[key] != b[key]]
            if fields:
                differences.append({"channel": channel, "fields": fields, "expected": a, "actual": b})
        stage = directory / "stage.png"
        return {"movie": name, "status": "rendered" if stage.exists() else "cast_assets_only", "authored_frame": args.frame if stage.exists() else None, "score_differences": differences, "bitmaps": comparisons, "stage": str(stage.relative_to(BASE)) if stage.exists() else None}

    with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:
        rows = list(pool.map(probe, names))
    comparisons = [b for row in rows for b in row.get("bitmaps", [])]
    summary = {"movies": len(rows), "statuses": dict(collections.Counter(row["status"] for row in rows)), "bitmap_instances_compared": len(comparisons), "bitmap_instances_exact_rgb": sum(b["exact_rgb"] for b in comparisons), "movies_with_score_differences": sum(bool(row.get("score_differences")) for row in rows)}
    result = {"scope": "Original files; authored frame snapshot without Lingo or audio; asset RGB comparisons against independent recovered PNGs. External casts may repeat across movies.", "summary": summary, "results": rows}
    (output / "validation.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(summary, indent=2))
    for row in rows:
        mismatches = [b for b in row.get("bitmaps", []) if not b["exact_rgb"]]
        if row["status"] not in ("rendered", "cast_assets_only") or row.get("score_differences") or mismatches:
            print(row["movie"], row["status"], "score differences:", len(row.get("score_differences", [])), "bitmap differences:", len(mismatches))


if __name__ == "__main__":
    main()
