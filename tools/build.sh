#!/usr/bin/env bash
# ============================================================================
#   kansasdeservesbetter.com
#   Build: minify the home page stylesheet
# ============================================================================
#   @file       tools/build.sh
#   @author     mediaBrilliance digitalxtudio
#   @updated    2026-11-07
# ============================================================================
#
#   index.html and speaker/index.html load style.min.css. An edit to style.css ships as a no-op until
#   this runs: the site looks unchanged and nothing errors. 2026/ and es/ are
#   the frozen record, with their own stylesheet and script; nothing here
#   touches them.
#
#   USAGE
#     tools/build.sh           build and report
#     tools/build.sh --check   change nothing; exit 1 if a .min file is stale
#
#   REQUIRES  cleancss  (brew install clean-css-cli)
#             terser    (npm install -g terser), for speaker/rotor.min.js and rep.min.js
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
# speaker/ loads the same stylesheet through ../ and takes the same stamp
for page in index.html speaker/index.html; do
  want="style.min.css?v=$hash"
  if grep -q "style\.min\.css?v=$hash\"" "$page"; then
    :
  elif (( CHECK )); then
    echo "stale  $page (style.min.css stamp)"; stale=1
  else
    sed -i '' -E "s#(\"(\.\./)?)style\.min\.css(\?v=[0-9a-f]+)?\"#\1$want\"#" "$page"
    grep -q "style\.min\.css?v=$hash\"" "$page" || { echo "error: no style.min.css reference in $page" >&2; exit 1; }
    echo "stamp  $page -> $want"
  fi
done

# speaker/rotor.js and speaker/rep.js are the commented sources; the page
# loads the .min.js builds. terser strips the comments and shortens names.
# Same check-or-build pattern as the stylesheet, and each script tag in
# speaker/index.html takes its file's hash as ?v=.
if ! command -v terser >/dev/null 2>&1; then
  echo "error: terser not found. npm install -g terser" >&2
  exit 1
fi
for js in rotor rep; do
  terser "speaker/$js.js" -c -m --comments false -o "$tmp/$js.min.js"
  if [[ -f "speaker/$js.min.js" ]] && cmp -s "$tmp/$js.min.js" "speaker/$js.min.js"; then
    echo "ok     speaker/$js.min.js"
  elif (( CHECK )); then
    echo "stale  speaker/$js.min.js"; stale=1
  else
    cp "$tmp/$js.min.js" "speaker/$js.min.js"; echo "built  speaker/$js.min.js ($(wc -c < "speaker/$js.min.js" | tr -d ' ') bytes)"
  fi
  jshash="$(shasum -a 256 "$tmp/$js.min.js" | cut -c1-8)"
  if grep -q "\"$js\.min\.js?v=$jshash\"" speaker/index.html; then
    :
  elif (( CHECK )); then
    echo "stale  speaker/index.html ($js.min.js stamp)"; stale=1
  else
    sed -i '' -E "s#\"$js\.min\.js(\?v=[0-9a-f]+)?\"#\"$js.min.js?v=$jshash\"#" speaker/index.html
    grep -q "\"$js\.min\.js?v=$jshash\"" speaker/index.html || { echo "error: no $js.min.js reference in speaker/index.html" >&2; exit 1; }
    echo "stamp  speaker/index.html -> $js.min.js?v=$jshash"
  fi
done

if (( stale )); then
  echo "Build is out of date. Run tools/build.sh" >&2
  exit 1
fi
