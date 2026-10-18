# kansasdeservesbetter

The public record of U.S. Sen. Roger Marshall (R-Kan.), sourced line by line, and how Kansans vote on Nov. 3, 2026. The only live site since Oct. 6, 2026 (the earlier domain forwards here) and the landing page for paid ads.

**by mediaBrilliance.io**

---

## Structure

```
/
├── index.html      # Hero, dates strip, 18-slide carousel, patient cases, votes, words, money, FAQ, vote dates
├── style.css       # Mobile first; breakpoints 600 and 900 (source)
├── style.min.css   # What the page loads; built by tools/build.sh
├── js/site.js      # Carousels and the Vote-link event (source; page loads site.min.js)
├── fonts/          # Oswald (SIL OFL), latin subset, self-hosted
├── images/         # Public-domain photos (WebP 640 and 1200), studio mark
├── og.png          # Share card, built from tools/og.html
├── favicon.svg, robots.txt, sitemap.xml
├── tools/          # build.sh, og.html (not published)
└── _config.yml     # Keeps internal files off GitHub Pages
```

Google Analytics (GA4, `G-SFSM1D23NT`) counts visits and outbound source clicks. One small script, `js/site.js`, drives the carousels.

## Build

The page loads `style.min.css` and `js/site.min.js`. Run `tools/build.sh` after editing `style.css` or `js/site.js`, or the edit ships as a no-op. It minifies both and stamps each URL in `index.html` with the file's hash. `tools/build.sh --check` changes nothing and exits 1 when a build is stale.

## Deploy

GitHub Pages from `main`, custom domain kansasdeservesbetter.com.

---

Copyright © 2026 mediaBrilliance. All rights reserved. See LICENSE.
