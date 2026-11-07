# kansasdeservesbetter

Kansas results from the Nov. 3, 2026 election, the public record of U.S. Sen. Roger Marshall (R-Kan.) that ran before it, and Project Speaker, the case for a contested House speaker election in January 2027. Every claim is sourced line by line.

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
├── speaker/        # Project Speaker: index.html; rotor.js and rep.js (sources) and their .min.js builds; reps.json (House members); og.png (share card, from tools/og-speaker.html)
├── fonts/          # Oswald (SIL OFL), latin subset, self-hosted
├── images/         # Public-domain photos (WebP 640 and 1200), studio mark
├── og.png          # Share card, built from tools/og.html
├── favicon.svg, robots.txt, sitemap.xml
├── tools/          # build.sh, results.py, petition.py, reps.py, index.template.html, og sources (not published)
├── .github/        # workflows/petition.yml: hourly signature count for speaker/
└── _config.yml     # Keeps internal files off GitHub Pages
```

Google Analytics (GA4, `G-SFSM1D23NT`) and Google Ads (`AW-18498605429`) count visits. The home page runs no other script; `speaker/` adds `rotor.js`.

## Build

Edit `tools/index.template.html` and `style.css`, never `index.html`. `tools/results.py` pulls current counts and writes the page; `tools/build.sh` minifies the stylesheet (and `speaker/rotor.js`) and stamps each URL with the file's hash. `tools/build.sh --check` changes nothing and exits 1 when a build is stale. `speaker/index.html` has no template: edit it directly. `build.sh` stamps its stylesheet link too.

## Project Speaker (`speaker/`)

**Moved to its own repo, [mbdxkc/projectspeaker](https://github.com/mbdxkc/projectspeaker), on Nov. 7, 2026.** Edit it there. This copy stays until projectspeaker.org's DNS points at the new repo, then `speaker/` comes out of this one.

Backs the change.org petition "House Democrats: CHOOSE A NEW SPEAKER." projectspeaker.org forwards to kansasdeservesbetter.com/speaker/ (Squarespace domain forwarding, 302, `@` and `www`).

- **The record:** eight items, each with its source and his own explanation. Money comes from FEC filings, votes from clerk.house.gov, quotes from the outlet that published them.
- **The hero rotates.** Ten headlines, each with a caption and a link to the record item behind it, change together every 6 seconds. "Earmarked." opens every cycle (and holds 10 seconds on first load) and the rest follow in random order. A Pause button, hover and keyboard focus stop it, and it stays still under reduced motion. One-line headlines are enlarged to fill the same space as two-line ones; "Earmarked." starts near that size in CSS (container query units), so the script only fine-tunes it. All of it is in `speaker/rotor.js`, explained in its comments; the page loads `rotor.min.js`, which `tools/build.sh` builds from it. To add or change a headline, edit the matching line in both the headline list and the caption list in `speaker/index.html`; the two lists must stay in the same order.
- **Call your representative** (`#call`, right after the hero): "Find my representative" asks for the visitor's location once, gets the congressional district from the U.S. Census Bureau's geocoder (119th Congress lines, the ones today's members were elected on) and looks the seat up in `speaker/reps.json`. The button then becomes "Call Rep. Name," dialing the member's Washington office, with what to say. Republicans, delegates, vacant seats, locations outside the U.S. and refused location each get their own message, and the Capitol switchboard and house.gov's address lookup are always on the page. `tools/reps.py` builds `reps.json` (43 KB) from the public congress-legislators list. All of it is explained in `speaker/rep.js`.
- **The signature count updates itself.** `.github/workflows/petition.yml` runs `tools/petition.py` and `tools/reps.py` every hour. The script reads the count and goal from the petition page and rewrites the line between `<!-- petition:start -->` and `<!-- petition:end -->`, only when the count has changed. The workflow commits that as github-actions[bot], and Pages redeploys. Never edit the count by hand, and pull before pushing, since the bot pushes to `main`.
- **Header and voice:** the shared header reads **America Deserves a Speaker** on this page only, and the page title and share name match. The thesis line above the hero button is "America deserves a speaker who had to win the job." The Kansas home page links here under its record buttons.
- **Colours:** House navy, Capitol gold and Democratic blue, set in the `speaker` section of `style.css` and scoped so the shared header and the home page are untouched.

## Deploy

GitHub Pages from `main`, custom domain kansasdeservesbetter.com. The petition workflow also pushes to `main`, so `git pull --rebase` before every push.

---

Copyright © 2026 mediaBrilliance. All rights reserved. See LICENSE.
