#!/usr/bin/env bash
# ============================================================================
#   kansasdeservesbetter.com
#   Build: minify the home page stylesheet
# ============================================================================
#   @file       tools/build.sh
#   @author     mediaBrilliance digitalxtudio
#   @updated    2026-11-03
# ============================================================================
#
#   index.html loads style.min.css. An edit to style.css ships as a no-op until
#   this runs: the site looks unchanged and nothing errors. 2026/ and es/ are
#   the frozen record, with their own stylesheet and script; nothing here
#   touches them.
#
#   USAGE
#     tools/build.sh           build and report
#     tools/build.sh --check   change nothing; exit 1 if a .min file is stale
#
#   REQUIRES  cleancss  (brew install clean-css-cli)
#
# ============================================================================

set -euo pipefail
cd "$(dirname "$0")/.."

CHECK=0
[[ "${1:-}" == "--check" ]] && CHECK=1

if ! command -v cleancss >/dev/null 2>&1; then
  echo "error: cleancss not found. brew install clean-css-cli" >&2
  exit 1
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

cleancss -O1 -o "$tmp/style.min.css" style.css

stale=0
if [[ -f style.min.css ]] && cmp -s "$tmp/style.min.css" style.min.css; then
  echo "ok     style.min.css"
elif (( CHECK )); then
  echo "stale  style.min.css"; stale=1
else
  cp "$tmp/style.min.css" style.min.css; echo "built  style.min.css ($(wc -c < style.min.css | tr -d ' ') bytes)"
fi

# Cache stamp. index.html loads the stylesheet as `style.min.css?v=<hash>`, the
# first 8 hex of the built file's SHA-256. GitHub Pages lets a browser reuse a
# file for 10 minutes, so an unstamped stylesheet can pair new HTML with old CSS.
hash="$(shasum -a 256 "$tmp/style.min.css" | cut -c1-8)"
want="style.min.css?v=$hash"
if grep -q "\"$want\"" index.html; then
  :
elif (( CHECK )); then
  echo "stale  index.html (style.min.css stamp)"; stale=1
else
  sed -i '' -E "s#\"style\.min\.css(\?v=[0-9a-f]+)?\"#\"$want\"#" index.html
  grep -q "\"$want\"" index.html || { echo "error: no style.min.css reference in index.html" >&2; exit 1; }
  echo "stamp  index.html -> $want"
fi

if (( stale )); then
  echo "Build is out of date. Run tools/build.sh" >&2
  exit 1
fi
