# kansasdeservesbetter/CLAUDE.md
> The full sourced record of Sen. Roger Marshall, Kansas Senate race, Nov. 3, 2026
> Deploy: GitHub Pages from `main` (mbdxkc/kansasdeservesbetter), https://kansasdeservesbetter.com

## What this site is

Since 2026-10-06 this is the only live site. It carries the full record (18-slide carousel, nine patient cases, votes, words, money, FAQ, voting dates) in a clean voice. fuckrogermarshall.com was retired that day and forwards here (301, Squarespace domain forwarding); its repo stays for history only. It is also the Google Ads landing page, and is expected to grow into a broader civic project after the election.

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
- **Money:** FEC totals are dated to their report (latest: October Quarterly, July 16-Sept. 30, 2026, filed Oct. 15). Next report: Pre-General, through Oct. 14, due Oct. 22; update the numbers and the dates together. The PAC figure is FEC's other-political-committee contributions (line 11C, party committees excluded) summed over the 2022, 2024 and 2026 cycles; individual donors are summed the same way. Since the October report individuals lead ($2,880,798 to $2,787,645), so never say PACs outgave people. The 18 percent in-state share is of itemized individual dollars only, from FEC's contributions-by-state data, which lags filings; it stays dated through July 15 until FEC processes the October report
- **Taxpayer funds and the 2020 campaign:** Kansas Reflector and MS NOW records (texts, calendars, video) "appear to show" his office using taxpayer funds for campaign travel; experts say "likely crossed the line." Always "appear to show" or "records show," never "he illegally used." Keep the campaign lawyer's denial (Ryan Dollar: "fully comply with both FEC rules and Senate ethics," "a disgruntled employee") beside it, and "No ethics finding has been made." Cite the KCUR republication (Oct. 10, 2026): kansasreflector.com returns 403 to fetchers, so the Reflector original is unverified by us. The Kansas City Star's "14 trips, $18,886" appears only secondhand there; keep it off until the Star piece is read
- **Florida house:** his office told MS NOW in October 2026 that he had sold it (via the same KCUR piece). Past tense from here on
- **Stock disclosures:** "up to 17 months late" for one dependent child's trades. No penalty or ethics finding is established
- Include his walk-backs and his office's explanations where the source carries them. It is what makes the rest hold

## Clean voice

- **No profanity anywhere served:** page, CSS, share card, file names. Google Ads rejects it and requires the shown domain to match the landing page
- **Never add an automatic redirect** on this page (meta refresh, JS or server). A forwarding landing page reads as a bridge page
- **"Paid for by Valdez Campos."** stays in the footer while the site is an ad destination, beside "Not authorized by any candidate or candidate's committee"

## Voting dates

- Registration closed Oct. 13, 2026, and advance voting opened Oct. 14. Since Oct. 14 the site names neither date: the Vote section and date strip say "Vote early: now to Nov. 2", the registration FAQ is gone and checking registration points only to VoterView. Never tell anyone to register. The Oct. 14, 2020, Zoom call in the taxpayer-funds item is history, not a voting date, and stays
- Mail ballots must ARRIVE by 7 p.m. on Election Day; the postmark grace period ended Jan. 1, 2026 (K.S.A. 25-1132, L. 2025, ch. 8)

## Site

- **Build:** index.html loads `style.min.css` and `js/site.min.js`. Edit `style.css` and `js/site.js`, then run `tools/build.sh`, which minifies both and stamps their URLs with an 8-hex SHA-256 (`--check` to verify). An unbuilt source edit ships as a no-op. Only the Google tag and the JSON-LD stay inline
- One page. The only JavaScript (`js/site.js`) drives the two carousels (arrows, keyboard, mouse drag; only the top one autoplays, with pause and reduced-motion respected). A second small listener sends the `vote_link_click` Analytics event when a Vote-section link to voteks.org or sos.ks.gov is clicked (source citations excluded). It is reporting only. The campaign has no conversion goals: it bids Maximize clicks and is judged on clicks, so zero conversions in Ads reports is expected, not a broken tag (confirmed 2026-10-18). `gtag('config', 'AW-18498605429')` sits in the existing gtag block; never add a second gtag.js script tag
- Photos are public domain only (U.S. Senate, USDA), credited on each slide. Never news-agency or image-search photos
- Hero sized by screen height and width so headline, intro and "Make a plan to vote" fit the first screen; re-measure after any hero copy change
- Self-hosted Oswald. The one third-party script is the Google tag: GA4 `G-SFSM1D23NT` (added 2026-10-15) and Google Ads `AW-18498605429` (added 2026-10-16), which set `_ga` and Google Ads cookies; the footer says "Uses Google Analytics and Google Ads to count visits." Never reinstate a "no cookies" or "no tracking" claim while the tag ships
- AP style: no Oxford comma, abbreviated months with dates, hyphenated ranges
