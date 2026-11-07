#!/usr/bin/env python3
"""Writes index.html, the results home page, from NBC News' Kansas race pages.

Run from the repo root, then run tools/build.sh. NBC's pages embed each race's
counts, percent in and call status. It does not list treasurer or insurance
commissioner, so those two are typed below from WIBW's results page; update
them, and WIBW_CALLS, by hand. Stops on any candidate it does not recognize.
"""
import datetime, email.utils, html, json, re, sys, urllib.request, zoneinfo

UA = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Safari/605.1.15"
NBC = "https://www.nbcnews.com/politics/2026-elections/"
WIBW = "https://www.wibw.com/politics/election-results/"
WON = ' class="won"'

NAMES = {
    "Hamilton": "Adam Hamilton, Democrat", "Marshall": "Roger Marshall, Republican", "Graham": "David C. Graham, Libertarian",
    "Holscher": "Cindy Holscher and KC Ohaebosim, Democrats", "Masterson": "Ty Masterson and Jeffrey Klemp, Republicans",
    "Mann": None,  # two different Manns; resolved per race below
    "Kobach": "Kris Kobach, Republican",
    "Proctor": "Pat Proctor, Republican", "Day": "Jennifer Day, Democrat", "Morgan": "Scott E. Morgan, United Kansas",
    "Reinhold": "Lauren Reinhold, Democrat", "Jacob": "Steven Jacob, Libertarian",
    "Schmidt": "Derek Schmidt, Republican", "Coover": "Don Coover, Democrat", "Hauer": "John Hauer, Libertarian",
    "Davids": "Sharice L. Davids, Democrat", "Jenkins": "Eric Jenkins, Republican", "Hohe": "Steven A. Hohe, Libertarian",
    "Estes": "Ron Estes, Republican", "Tyndell": "Katy Tyndell, Democrat", "Cranmer": "Drew Cranmer, Libertarian",
    "Yes": "Yes", "No": "No",
}
RACES = [
    ("Governor and lieutenant governor", "kansas-governor-results"),
    ("Attorney general", "kansas-attorney-general-results"),
    ("Secretary of state", "kansas-secretary-of-state-results"),
    ("State treasurer", None),
    ("Insurance commissioner", None),
    ("U.S. House, District 1", "kansas-us-house-district-1-results"),
    ("U.S. House, District 2", "kansas-us-house-district-2-results"),
    ("U.S. House, District 3", "kansas-us-house-district-3-results"),
    ("U.S. House, District 4", "kansas-us-house-district-4-results"),
    ("Constitutional amendment", "kansas-ballot-measures"),
]
WIBW_RACES = {
    "State treasurer": (98.9, [("Steven Johnson, Republican", 554383), ("Juan C. Luengo, Democrat", 479827), ("Eric Lund, Libertarian", 49091)]),
    "Insurance commissioner": (98.9, [("Daniel Hawkins, Republican", 530494), ("Dinah Sykes, Democrat", 513291), ("Ric Koehn, Libertarian", 38773)]),
}

# Race -> winner's displayed name, call text, source name, source URL. Only a call a source has reported.
WIBW_CALLS = {
    "State treasurer": ("Steven Johnson, Republican", "KWCH reports: Steven Johnson wins", "KWCH", "https://www.kwch.com/2026/11/04/morning-after-election-day-where-things-stand/"),
    "Insurance commissioner": ("Daniel Hawkins, Republican", "WIBW reports: Daniel Hawkins wins", "WIBW", WIBW),
}


def nbc(slug):
    req = urllib.request.Request(NBC + slug, headers={"User-Agent": UA})
    page = urllib.request.urlopen(req, timeout=30).read().decode("utf-8", "ignore")
    props = json.loads(re.search(r'<script id="__NEXT_DATA__"[^>]*>(.*?)</script>', page, re.S).group(1))["props"]["pageProps"]
    race = props["ballotMeasures"][0] if "ballotMeasures" in props else props["races"][0]["summary"]
    return props, race


def rows(race, title):
    out = []
    for c in race["candidates"]:
        last = c["lastName"] or c["name"]
        name = NAMES[last]
        if last == "Mann":
            name = "Tracey Mann, Republican" if "District 1" in title else "Chris Mann, Democrat"
        if not name:
            sys.exit(f"unknown candidate {last} in {title}")
        out.append((name, c["votes"], bool(c["isWinner"])))
    return sorted(out, key=lambda r: -r[1])


def table(rs):
    total = sum(r[1] for r in rs)
    body = "".join(
        f'\n              <tr{WON if r[2] else ""}><th scope="row">{html.escape(r[0])}</th><td>{r[1] / total * 100:.1f}%</td><td>{r[1]:,}</td></tr>'
        for r in rs)
    return f'<table>\n              <thead class="vh"><tr><th scope="col">Candidate</th><th scope="col">Share</th><th scope="col">Votes</th></tr></thead>\n              <tbody>{body}\n              </tbody>\n            </table>'


# ---- Senate
props, sen = nbc("kansas-senate-results")
assert sen["callStatusCode"] == "P" and sen["partyGain"] == "dem"
srows = rows(sen, "Senate")
assert srows[0][0].startswith("Adam Hamilton") and srows[0][2]
stotal = sum(r[1] for r in srows)
tally = "".join(
    f'\n          <li{WON if r[2] else ""}><span class="who">{r[0].split(",")[0].split()[-1]}</span><span class="pct">{r[1] / stotal * 100:.1f}%</span><span class="n">{r[1]:,} votes</span></li>'
    for r in srows)
# NBC sends this as ISO 8601 on some responses and as an HTTP date on others
raw = props["lastModified"]
stamp = datetime.datetime.fromisoformat(raw.replace("Z", "+00:00")) if raw[:4].isdigit() else email.utils.parsedate_to_datetime(raw)
stamp = stamp.astimezone(zoneinfo.ZoneInfo("America/Chicago"))
hour = stamp.strftime("%-I:%M") + (" a.m." if stamp.hour < 12 else " p.m.")
asof = f"{hour} Central, Nov. {stamp.day}"

# ---- everything else
cards = []
for title, slug in RACES:
    if slug is None:
        pct, typed = WIBW_RACES[title]
        called = WIBW_CALLS.get(title)
        rs = [(n, v, bool(called and called[0] == n)) for n, v in typed]
        call, done = (called[1], True) if called else ("Counting continues", False)
        pct_in = f"{pct}% reporting"
        src = f'<a href="{WIBW}">WIBW</a>' + (f'; call: <a href="{called[3]}">{called[2]}</a>' if called and called[3] != WIBW else "")
    else:
        _, race = nbc(slug)
        rs = rows(race, title)
        code = race["callStatusCode"]
        done = code == "P"
        if done:
            w = next(r for r in rs if r[2])
            call = "NBC News projects: passed" if title.startswith("Constitutional") else f"NBC News projects: {w[0].split(',')[0]}"
        else:
            call = "Too early to call" if code == "E" else "Counting continues"
        pct_in = f'{race["percentIn"]}% of expected vote in'
        src = f'<a href="{NBC}{slug}">NBC News</a>'
    q = ""
    if title.startswith("Constitutional"):
        q = ('\n            <p class="q">A yes vote would &ldquo;clarify that only a person who is a citizen of the United States is eligible '
             'to vote in this state.&rdquo; (<a href="https://sos.ks.gov/elections/proposed-constitutional-amendments.html">Kansas secretary of state</a>)</p>')
    cards.append(f'''          <li class="race">
            <h3>{title}</h3>
            <p class="call{" done" if done else ""}">{call}</p>{q}
            {table(rs)}
            <p class="src">{pct_in}. Source: {src}</p>
          </li>''')

page = open("tools/index.template.html").read()
for key, val in {"{{TALLY}}": tally, "{{SENATE_IN}}": f'{sen["percentIn"]}', "{{ASOF}}": asof, "{{RACES}}": "\n".join(cards)}.items():
    assert page.count(key) >= 1, key
    page = page.replace(key, val)
assert "{{" not in page
open("index.html", "w").write(page)
print("wrote index.html, as of", asof)
for r in srows:
    print(r)
