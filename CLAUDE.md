# kansasdeservesbetter/CLAUDE.md
> Kansas results from Nov. 3, 2026, and the full sourced record of Sen. Roger Marshall at /2026/ and /es/
> Deploy: GitHub Pages from `main` (mbdxkc/kansasdeservesbetter), https://kansasdeservesbetter.com

## What this site is

**Since Nov. 3, 2026:** Adam Hamilton won. `/` is the results page, and the record moved to `/2026/` (English) and stays at `/es/` (Spanish). Both are frozen on `2026/style.min.css` and `2026/site.min.js`, sharing `images/` and `fonts/`; `tools/build.sh` touches neither. Their only edits were the path changes and an archive strip above the header. The rest of this file's record, ICE, voting and ballot sections describe those archived pages.

**Results page:** `tools/results.py` writes `index.html` from `tools/index.template.html` and NBC News' race pages, so edit the template, never `index.html`. Treasurer and insurance commissioner are typed in the script from WIBW because NBC does not list them. Write "NBC News projects" only where NBC's `callStatusCode` is `P`, and leave a race uncalled until a source calls it. Every count carries its as-of time and "unofficial" until certified. Run `tools/results.py`, then `tools/build.sh`. `og.png` comes from `tools/og.html`; the old card's source is `tools/og-2026.html`.

Since 2026-10-06 this is the only live site. It carries the full record (18-slide carousel, nine patient cases, votes, words, money, FAQ, voting dates) in a clean voice. fuckrogermarshall.com was retired that day and forwards here (301, Squarespace domain forwarding); its repo stays for history only. It is also the Google Ads landing page, and is expected to grow into a broader civic project after the election.

## Project Speaker (/speaker/)

- Added 2026-11-07: **Project Speaker**, headline "Earmarked." (Nov. 7; "Open the gavel" retired, and "No gavel for AIPAC" declined as overstating donors' earmarks as AIPAC control), backing the change.org petition "House Democrats: CHOOSE A NEW SPEAKER" (Nicole Whitted). projectspeaker.org forwards here (Squarespace Domains → Website → Domain forwarding, Nov. 7: rules for `@` and `www`, **302** and Remove paths, so every address lands on /speaker/ in one hop; verified http and https, with and without www). 302 on purpose: a 301 is cached by browsers, which would strand returning visitors if Project Speaker later moves to its own repo at projectspeaker.org. Saving the `@` rule deleted the Squarespace Defaults; the Email Security records (SPF `-all`, DMARC reject) stay, so the domain cannot be spoofed for mail. Canonical, og:url and the sitemap stay on kansasdeservesbetter.com/speaker/. Google Ads final URLs must use kansasdeservesbetter.com, not the forwarding domain
- The shared header reads **America Deserves a Speaker** (Valdez, Nov. 7; also the page title and og:site_name) on this page only (text change in `speaker/index.html`; the mark links to `#top`). Below 430px the nav link shows "Sign" (" the petition" is visually hidden, not removed, so the accessible name still contains the visible text), because the full label overflowed 320-360px screens by 4-44px
- Colours are scoped to `body.speaker main` and the footer (House navy `#0d1b33`, Capitol gold `#d8b86a`, Democratic blue `#1f4fbf` buttons); the shared header keeps the site's black and sunflower. `tools/build.sh` stamps both `index.html` and `speaker/index.html`
- **Hero rotor** (`speaker/rotor.js`, explained in its comments; the page loads `rotor.min.js`, which `tools/build.sh` builds with terser and stamps, so run the build after any edit): ten headlines in `#rotor` and ten captions in `#rotor-cap`, paired by position, so add, remove or reorder them in both lists together. Each headline's `data-ref` is its record item (1-6 → `#item-N`, 0 → `#act`). Every headline and caption restates an item in the record and may not claim anything the record does not. "Earmarked." stays first; the rest shuffle. 6-second interval, .5s fade (`CONFIG.fade` must match the CSS transition)
- **Call your representative** (`#call`, Nov. 7): `speaker/rep.js` geolocates on tap only, gets the district from the Census geocoder as JSONP (it sends no CORS headers) with `vintage=ACS2025_Current`, which returns **119th** districts; `Current_Current` returns the 2026 (120th) lines, which do not match today's members in redrawn states. Seat → member comes from `speaker/reps.json`, built hourly by `tools/reps.py` from congress-legislators (`district` 0 = at-large, D.C. and territories). Tested: KS-3 Davids, KS-2 Schmidt (Republican note), D.C. Norton (delegate note: no floor vote, caucus voting rights unverified so not claimed), London (no district), location refused. `.speaker [hidden]` carries `!important` because `.cta` sets display
- **Share card:** `speaker/og.png` from `tools/og-speaker.html` (render command in its header). Its lines restate record item 1, so re-render if that figure changes, and bump `?v=` on `og:image` and `twitter:image`, since social sites cache by URL
- **The signature count updates itself.** `.github/workflows/petition.yml` runs `tools/petition.py` hourly; it rewrites the text between `<!-- petition:start -->` and `<!-- petition:end -->` only when the count moves, reading the goal too, and commits as github-actions[bot]. Pull before every local push. Never hand-edit the count
- **From the petition, fact-checked Nov. 7:** speaker is next in line after the vice president (3 U.S.C. § 19, govinfo); in all 16 speaker ballots since 2023 (15 in Jan. 2023, one Jan. 3, 2025) no Democrat voted for anyone but Jeffries (clerk XML; Trone did not vote on 2023 roll call 15). Caucus nominee vote **Nov. 18** is reported by ABC News and Bloomberg Government ("two people familiar"); Fox News said mid-December. Keep the attribution and the conflict until the caucus announces a date. The petition's own lines ("not the right choice," "establishment," "dark money") are opinion and stay hers
- Same record rules as below: FEC for money (AIPAC figures are donors' earmarks through AIPAC PAC, C00797670, not the PAC's own funds; the two joint committees also fund the DCCC and other members), clerk.house.gov for votes, his own explanation beside each item. No individual donor names. Massie amendment (roll call 243, July 15, 2026): Democrats split 103 yes, 98 no, 10 present, so never "most Democrats voted for it"

## The record rules

Marshall's lawyers sent a cease-and-desist over an opponent's ad on Sept. 30, 2026. Every line here is read by people looking for an error.

- **Every claim links to its source.** Roll calls to senate.gov or clerk.house.gov, money to fec.gov, quotes to the outlet that published them. Verify against the primary page before adding; agent or memory research is a lead, not a source
- **Arrests:** 81 patients were arrested **after missing court dates** in debt suits his practice filed. Never "arrested over $50," never "jailed for debt"
- **Zimmerman:** owed about $3,600, paid about $50 a month at 18 percent. Never imply the debt was $50
- **"Keeping the hospital's lights on"** and "Judges issue warrants" come from spokesperson Payton Fuller's statement (KAKE). Attribute them to the spokesperson, not to Marshall in person. His own words: "Those were common, common business practices" (State Fair debate, Sept. 12, 2026)
- **PACT Act:** he voted against cloture July 27, 2022, then YES on final passage Aug. 2. Never "voted against the PACT Act"
- **IVF (June 13, 2024):** a vote against advancing the bill, not a vote on IVF itself
- **Insulin (Aug. 7, 2022):** the cap failed for private insurance and survived for Medicare
- **Rural hospitals (roll call 333):** a motion to commit with instructions on rural hospitals. Senate page says only "Motion to Commit"; the floor log names it
- **Money:** FEC totals are dated to their report (latest: Pre-General, Oct. 1-14, 2026, filed Oct. 22; cash on hand $809,806). Next report: Post-General, through Nov. 23, due Dec. 3, after the election; update the numbers and the dates together. The PAC figure is FEC's other-political-committee contributions (line 11C, party committees excluded) summed over the 2022, 2024 and 2026 cycles; individual donors are summed the same way. Individuals lead ($3,298,320 to $2,910,495 at the Pre-General, 88 percent), so never say PACs outgave people, and since Oct. 23 not "nearly as much" either: the copy says "close behind" ("poco menos" in Spanish). Check the method on each update: the 2026-cycle totals should rise by exactly the new report's line 11A and 11C period amounts The 18 percent in-state share is of itemized individual dollars only, from FEC's contributions-by-state data, which lags filings; it stays dated through July 15 until FEC processes the October report
- **Taxpayer funds and the 2020 campaign:** Kansas Reflector and MS NOW records (texts, calendars, video) "appear to show" his office using taxpayer funds for campaign travel; experts say "likely crossed the line." Always "appear to show" or "records show," never "he illegally used." Keep the campaign lawyer's denial (Ryan Dollar: "fully comply with both FEC rules and Senate ethics," "a disgruntled employee") beside it, and "No ethics finding has been made." Cite the KCUR republication (Oct. 10, 2026): kansasreflector.com returns 403 to fetchers, so the Reflector original is unverified by us. The Kansas City Star's "14 trips, $18,886" appears only secondhand there; keep it off until the Star piece is read
- **Florida house:** his office told MS NOW in October 2026 that he had sold it (via the same KCUR piece). Past tense from here on
- **Stock disclosures:** "up to 17 months late" for one dependent child's trades. No penalty or ethics finding is established
- Include his walk-backs and his office's explanations where the source carries them. It is what makes the rest hold

## Spanish edition (/es/)

- Added 2026-10-21: `es/index.html` is the full page in Spanish plus one section the English page does not carry, **ICE en Kansas** (`#ice`), after the patients. It loads `2026/style.min.css`, `2026/site.min.js`, the font and images through `../`
- **Every edit to the English record is an edit to the Spanish one.** The two pages share no markup, so a corrected number, date or source has to be made twice. Grep `es/index.html` for the same claim before committing
- Quotes are translated and the footer says so; source links stay to the English originals. Voice: `tú`, never `usted`, in plain everyday Spanish as spoken in southwest Kansas (Valdez, Oct. 21, 2026): "clínica" not "consultorio," "la gran ley de gastos" not "megaley," "el seguro de Obamacare" not "créditos fiscales para las primas." Simpler words never loosen a record rule: "a 81 los arrestaron después de faltar a la corte" keeps the qualifier. US number format ($2,787,645), Spanish dates (3 de noviembre de 2026). The FEC-style disclaimer appears in Spanish and again in English
- Each page links to the other on its own line under the kicker, with `hreflang` alternates in both heads and in `sitemap.xml`. The Pause button takes its Spanish words from `data-*` attributes; `2026/site.js` falls back to English
- `2026/og.png` is English-only; the Spanish page reuses it

## ICE section rules

- **Liberal, Sept. 22-24, 2026** comes from KCUR / Kansas News Service (Sept. 24, 2026): officials learned Monday night, "dozens" detained per Vice Mayor Janeth Vazquez, ICE gave no count, 120 students absent at Meadowlark Elementary on Sept. 23, the Duran/Navarrete stop. The widely repeated "104 arrests" is attributed to the U.S. Attorney's Office but no such release was found; keep it off until one is read
- Keep the federal side beside it: DHS Secretary Markwayne Mullin (KCTV5, paraphrased: no worksite operations in Kansas, targets with final removal orders) and Sen. Jerry Moran's account of Mullin's assurance (KCUR)
- **Marshall now:** the Sept. 23, 2026 X post, text from The Kansas City Star (Sept. 24). It asks for coordination with local police; do not characterize it as opposing ICE. **Marshall before:** his own Aug. 25, 2025 release (marshall.senate.gov/?p=80799) and the March 2026 X post as quoted by the Star. "Illegal immigrants" and "illegal aliens" are his words, translated literally inside quotation marks
- **Votes:** H.R. 1, roll call 372 (July 1, 2025); "more than $75 billion" for ICE over four years and $45 billion for detention are the National Immigration Forum's figures (July 2025 PDF), attributed by name. Laken Riley Act, S. 5, roll call 7 (Jan. 20, 2025), described as the Senate page does: custody for aliens charged with theft
- **Numbers:** Liberal 68 percent Hispanic or Latino is the 2020 Census (13,499 of 19,825, via KU's Institute for Policy & Social Research; census.gov QuickFacts returns 403 to fetchers). National detention (65,765 held, 70.6 percent with no criminal conviction, July 11, 2026) is TRAC. Leavenworth: 4-1 permit vote March 10, 2026, about 20 detainees by March 19 (KCTV5). Later population figures exist only on Wikipedia; keep them off

## Clean voice

- **No profanity anywhere served:** page, CSS, share card, file names. Google Ads rejects it and requires the shown domain to match the landing page
- **Never add an automatic redirect** on this page (meta refresh, JS or server). A forwarding landing page reads as a bridge page
- **"Paid for by Valdez Campos."** stays in the footer while the site is an ad destination, beside "Not authorized by any candidate or candidate's committee"

## Voting dates

- Registration closed Oct. 13, 2026, and advance voting opened Oct. 14. Since Oct. 14 the site names neither date: the Vote section and date strip say "Vote early: now to Nov. 2", the registration FAQ is gone and checking registration points only to VoterView. Never tell anyone to register. The Oct. 14, 2020, Zoom call in the taxpayer-funds item is history, not a voting date, and stays
- Mail ballots must ARRIVE by 7 p.m. on Election Day; the postmark grace period ended Jan. 1, 2026 (K.S.A. 25-1132, L. 2025, ch. 8)

## Also on the ballot

- Added 2026-10-19 below the Vote section: every statewide race, all four U.S. House races and the one constitutional amendment, candidates alphabetical by last name with party, no advocacy in any race but the Senate's. Legislature, State Board of Education, judges and local races point to VoterView
- Candidates come from county election offices' official general-election lists, because each county ballot carries every statewide race: Johnson (statewide, District 3), Shawnee (statewide, District 2), Saline (statewide, District 1, updated Sept. 15), Sedgwick (District 4). The three that carry the statewide races agree name for name. The secretary of state's candidate list blocks automated fetches (CloudFront 403); check it by hand if a name is ever disputed
- **Sedgwick County's list omits the statewide minor-party nominees** (Graham, Morgan, Lund, Koehn) that the other three carry. The first version of this section used it alone and published a ballot missing four candidates for about two hours. Never source the statewide races from Sedgwick
- Third-party candidates: David C. Graham (Libertarian) is on the ballot for U.S. Senate, so the FAQ answer to "Who is running against Roger Marshall?" names him beside Hamilton
- The amendment text quotes the secretary of state's explanatory statement verbatim
- The footer reads "Paid for by Valdez Campos. Not an endorsement." (Valdez's wording, Oct. 19, 2026)

## Site

- **Build:** index.html loads `style.min.css`. Edit `style.css`, then run `tools/build.sh`, which minifies it and stamps its URL with an 8-hex SHA-256 (`--check` to verify). An unbuilt source edit ships as a no-op. Only the Google tag and the JSON-LD stay inline
- The only JavaScript (`2026/site.js`, on the archived pages) drives the two carousels (arrows, keyboard, mouse drag; only the top one autoplays, with pause and reduced-motion respected). A second small listener sends the `vote_link_click` Analytics event when a Vote-section link to voteks.org or sos.ks.gov is clicked (source citations excluded). It is reporting only. The campaign has no conversion goals: it bids Maximize clicks and is judged on clicks, so zero conversions in Ads reports is expected, not a broken tag (confirmed 2026-10-18). `gtag('config', 'AW-18498605429')` sits in the existing gtag block; never add a second gtag.js script tag
- Photos are public domain only (U.S. Senate, USDA), credited on each slide. Never news-agency or image-search photos
- Hero sized by screen height and width so headline, intro and "Make a plan to vote" fit the first screen; re-measure after any hero copy change
- Self-hosted Oswald. The one third-party script is the Google tag: GA4 `G-SFSM1D23NT` (added 2026-10-15) and Google Ads `AW-18498605429` (added 2026-10-16), which set `_ga` and Google Ads cookies; the footer says "Uses Google Analytics and Google Ads to count visits." Never reinstate a "no cookies" or "no tracking" claim while the tag ships
- AP style: no Oxford comma, abbreviated months with dates, hyphenated ranges
