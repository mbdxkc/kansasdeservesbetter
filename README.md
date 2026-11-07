# kansasdeservesbetter

Kansas results from the Nov. 3, 2026 election, the public record of U.S. Sen. Roger Marshall (R-Kan.) that ran before it. Every claim is sourced line by line.

**by mediaBrilliance.io**

---

## Structure

```
/
├── index.html      # Results home page, written by tools/results.py
├── style.css       # Mobile first (source)
├── style.min.css   # What the page loads; built by tools/build.sh
├── 2026/           # The record through Election Day, frozen with its own CSS, script and share card
├── es/             # The same record in Spanish, frozen on 2026/'s CSS and script
├── fonts/          # Oswald (SIL OFL), latin subset, self-hosted
├── images/         # Public-domain photos (WebP 640 and 1200), studio mark
├── og.png          # Share card, built from tools/og.html
├── favicon.svg, robots.txt, sitemap.xml
├── tools/          # build.sh, results.py, index.template.html, og sources (not published)
└── _config.yml     # Keeps internal files off GitHub Pages
```

Google Analytics (GA4, `G-SFSM1D23NT`) and Google Ads (`AW-18498605429`) count visits. The home page runs no other script.

## Build

Edit `tools/index.template.html` and `style.css`, never `index.html`. `tools/results.py` pulls current counts and writes the page; `tools/build.sh` minifies the stylesheet and stamps its URL with the file's hash. `tools/build.sh --check` changes nothing and exits 1 when a build is stale.

## Project Speaker

Moved to its own repo, [mbdxkc/projectspeaker](https://github.com/mbdxkc/projectspeaker), and live at https://projectspeaker.org since Nov. 7, 2026. The home page links there under its record buttons.

## Deploy

GitHub Pages from `main`, custom domain kansasdeservesbetter.com.

---

Copyright © 2026 mediaBrilliance. All rights reserved. See LICENSE.
