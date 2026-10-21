#!/usr/bin/env bash
# ============================================================================
#   kansasdeservesbetter.com
#   Build: minify the stylesheet and the page script
# ============================================================================
#   @file       tools/build.sh
#   @author     mediaBrilliance digitalxtudio
#   @updated    2026-10-21
# ============================================================================
#
#   index.html loads style.min.css and js/site.min.js. An edit to style.css or
#   js/site.js ships as a no-op until this runs: the site looks unchanged and
#   nothing errors. Run it after every edit to either file.
#
#   USAGE
#     tools/build.sh           build and report
#     tools/build.sh --check   change nothing; exit 1 if a .min file is stale
#
#   REQUIRES  cleancss, terser  (brew install clean-css-cli terser)
#
# ============================================================================

set -euo pipefail
cd "$(dirname "$0")/.."

CHECK=0
[[ "${1:-}" == "--check" ]] && CHECK=1

for tool in cleancss terser; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "error: $tool not found. brew install clean-css-cli terser" >&2
    exit 1
  fi
done

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

cleancss -O1 -o "$tmp/style.min.css" style.css
terser js/site.js --compress --mangle --output "$tmp/site.min.js"

stale=0
for pair in "style.min.css:style.min.css" "site.min.js:js/site.min.js"; do
  built="$tmp/${pair%%:*}"; dest="${pair#*:}"
  if [[ -f "$dest" ]] && cmp -s "$built" "$dest"; then
    echo "ok     $dest"
  elif (( CHECK )); then
    echo "stale  $dest"; stale=1
  else
    cp "$built" "$dest"; echo "built  $dest ($(wc -c < "$dest" | tr -d ' ') bytes)"
  fi
done

# Cache stamps. index.html loads each minified file as `file?v=<hash>`, the
# first 8 hex of the built file's SHA-256. GitHub Pages lets a browser reuse a
# file for 10 minutes, so an unstamped stylesheet can pair new HTML with old
# CSS. A changed file is a changed URL; an unchanged one keeps its cached copy.
# es/index.html reaches the same files through "../", so the match allows it.
for page in index.html es/index.html; do
  [[ "$page" == es/* ]] && up="../" || up=""
  for pair in "style.min.css:style.min.css" "site.min.js:js/site.min.js"; do
    dest="${pair#*:}"
    hash="$(shasum -a 256 "$tmp/${pair%%:*}" | cut -c1-8)"
    want="$up$dest?v=$hash"
    if grep -q "\"$want\"" "$page"; then
      continue
    elif (( CHECK )); then
      echo "stale  $page ($dest stamp)"; stale=1
    else
      sed -i '' -E "s#\"$up$dest(\\?v=[0-9a-f]+)?\"#\"$want\"#" "$page"
      grep -q "\"$want\"" "$page" || { echo "error: no $dest reference in $page" >&2; exit 1; }
      echo "stamp  $page -> $want"
    fi
  done
done

if (( stale )); then
  echo "Build is out of date. Run tools/build.sh" >&2
  exit 1
fi
