# GitHub Pages deployment

The online reference player is at https://foxtacles.github.io/findus3/.
The complete static build, all 39 game containers, portable ZIP and matching
runtime source archive are published in the `findus3/` directory of
`foxtacles/foxtacles.github.io`. The `project/` directory also contains the
recovery/build tools, documentation, decompiled Lingo and analysis inventories.

The repository already publishes its `main` branch root through GitHub Pages.
Its root `.nojekyll` keeps the player and game data as plain static files.
All runtime requests resolve relative to `/findus3/`.

To update the site after building and packaging the port:

```sh
git clone git@github.com:foxtacles/foxtacles.github.io.git tools/github-pages-publish
python3 scripts/stage_pages.py --checkout tools/github-pages-publish
git -C tools/github-pages-publish add --force findus3
git -C tools/github-pages-publish commit -m "Update Findus web reference port"
git -C tools/github-pages-publish push origin main
```

For an existing clean checkout, run `git pull --ff-only` instead of cloning it.
Check the Pages deployment status before testing the online URL. No runtime
build, external assets service or backend is required on GitHub's servers.
