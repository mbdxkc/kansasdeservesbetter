# kansasdeservesbetter devLog

Newest entries at the bottom. Every entry ends with Mistakes → Rules.

---

## 2026-10-05 — Launch build

A clean one-pager for Google Ads: the headline, the four patient figures, three votes (Medicaid cuts, the $35 insulin cap, the ACA credits), a button to the full record and the Kansas voting dates, with "Paid for by Valdez Campos." in the footer. Shares fuckrogermarshall.com's stylesheet, font and studio mark; the story, voices, FAQ and carousel rules were cut.

Chosen over a redirect from mediabrilliance.io (Google follows redirects and requires the display domain to match the landing domain) and over masked forwarding (an invisible frame breaks on phones and reads as cloaking).

### Mistakes → Rules

- **A landing page that forwards on its own is a bridge page.** Give it real content and let the visitor click through
- **Count against the destination before writing a number.** The button's lead-in said "nine more votes" when the full site has nine in total and this page shows three
- **A comment in a served CSS file is published text.** The first draft named the profane domain in `style.css`; on an ads landing page nothing served may carry it

---

## 2026-10-05 — SEO pass, live on its domain

Live at https://kansasdeservesbetter.com with HTTPS enforced. Added six quick answers matched to how people search (did he sue patients, were they arrested, his health care votes, who is running against him, the registration deadline, when early voting starts), each sourced; keyword-bearing section headings; a nav to every section; and one structured-data graph (WebSite, Organization, Person, WebPage, FAQPage). Lighthouse 100 in all four categories, 53 KB, zero HTML errors, no profanity in any visible text.

During setup the fuckrogermarshall repo's Pages custom domain was switched to this domain by mistake, taking fuckrogermarshall.com offline for about 15 minutes and serving the profane site here. Restoring its `CNAME` file brought it back.

### Mistakes → Rules

- **Each Pages repo owns exactly one domain.** Changing a custom domain field moves the domain to that repo and takes the old one offline. A second site gets its own empty repo and its own `CNAME`; never point an existing site's field at a new domain
- **Say "create a new empty repo," not "create a repo,"** to anyone working in the GitHub UI next to an existing one. The near-miss started at a settings page that already existed

---

## 2026-10-06 — The full record moves here; the old domain retires

Valdez retired fuckrogermarshall.com. Before its domain forwards, the full site moved here so nothing was lost: the version just before the harsh rewrite (`76ea97a` in that repo), with this site's name, share card, favicon and URLs, and "Paid for by Valdez Campos." added to the footer. The one-pager and its "See the full record" button are gone, since this page is now the full record. Lighthouse 100 in all four categories, 124 KB, zero HTML errors, no profanity in any served file; the hero fits the first screen at every size measured.

### Mistakes → Rules

- **Move the content before you forward the domain.** A redirect to a summary page that links back to the redirected domain is a loop, and the full record would have existed nowhere


---

## 2026-10-06 — Corrections go to Valdez directly

The footer's "Send a correction" link now opens mail to vc3030@gmail.com instead of the studio inbox, keeping mediaBrilliance's address off the campaign. No separate contact page: the correction link is the one contact the site needs.

---

## 2026-10-06 — SEO pass on the full record

Lighthouse already scored SEO 100; the gains were in what Google reads. Section headings now carry the searched name and topic ("The patients Roger Marshall sued," "Roger Marshall's voting record," "Who funds Roger Marshall," "How to vote in the Kansas Senate race") instead of "The votes" and "The money." The kicker says "Kansas Senate race," and the patients intro names "medical debt lawsuits, wage garnishments and arrest warrants," two phrases people search that the page never used. Two FAQs added (the $35 insulin vote, when early voting starts), mirrored in the FAQPage data. Article dateModified, the modified-time meta and the sitemap lastmod moved to Oct. 6.

### Mistakes → Rules

- **A perfect Lighthouse SEO score checks the plumbing, not the words.** The page scored 100 while never saying "medical debt" or "Kansas Senate," the two phrases most likely to bring someone to it. Count the searched terms in the visible text

---

## 2026-10-07 — The carousel fits one phone screen

On a phone the 18-slide carousel's heading, card and arrows ran about 750px tall against roughly 600px of visible screen, so the arrows sat below the fold. Every card takes the height of the tallest slide (the Florida house: photo, caption, quote, source), so that one slide set the size of all 18. Under 600px wide: photos crop to 2:1, slide text, quotes and sources step down, padding tightens, and the Florida caption is shorter ("He lists a $124,200 Kansas cabin as home. His Sarasota, Fla., vacation house was later valued at $1.2 million."). Heading to arrows now measures 560px at 430x700, 543 at 390x660 and 537 at 375x600, each inside the screen below the sticky header. The hero fold is unchanged.

### Mistakes → Rules

- **In an equal-height carousel the tallest slide is the only one that matters.** Measure each slide's natural height and trim that one; shrinking the rest changes nothing

---

## 2026-10-12 — Taxpayer funds on campaign trips (Kansas Reflector and MS NOW)

Added the Kansas Reflector and MS NOW investigation (via KCUR, Oct. 10, 2026) as a "Who funds" item: 2020 texts, calendars and video that appear to show his office booking campaign trips with taxpayer funds, Robertson's "Primary purpose is what we say it is," the Oct. 14, 2020, all-staff campaign Zoom, the experts' view and the campaign lawyer's denial. A new FAQ ("Did Roger Marshall use taxpayer money for his campaign?") went into both the page and the FAQPage JSON-LD. The Florida house item and FAQ now note his office told MS NOW he sold it. dateModified, `@updated` and the sitemap moved to Oct. 12.

Every quote was matched against the KCUR article's text, not a summary. kansasreflector.com answers 403 to curl and to the fetch tool, so the page cites the KCUR republication it could read and names the Reflector and MS NOW in the copy. The Star's Sarasota trip figure appears there only secondhand and stayed off. W3C: 0 errors; JSON-LD parses; the money section renders at 1280 and 600.

### Mistakes → Rules

- **An investigation's verbs are part of the claim.** The reporters wrote "appear to show" and experts said "likely crossed the line"; copying the verbs, the denial and "no ethics finding" is what lets the item survive a hostile read
- **Cite the copy you could read.** A republication you verified beats an original you could not open; name the originating outlets in the text so credit survives

**Commit:** 49c4dca

---

## 2026-10-12 — FAQ: early-voting question removed

Removed "When does early voting start in Kansas?" from the FAQ and its FAQPage JSON-LD at Valdez's request. With nine questions the grid left an empty cell beside it; eight fill the rows. The early-voting dates stay in the Vote section, the date strip and the closing slide. W3C: 0 errors; JSON-LD parses.

### Mistakes → Rules

- **An FAQ question lives in two places.** Removing it from the markup without the JSON-LD leaves Google a question the page no longer answers

---

## 2026-10-12 — Vote section for after the registration deadline

Rewrote the Vote section for Oct. 14 through Nov. 3. The "Register by Oct. 13" card is gone; the intro says registration closed Oct. 13, "Check your registration" leads, and the mail card split in two: apply by Oct. 27, and return by 7 p.m. Nov. 3, with the postmark rule stated from K.S.A. 25-1132 (read on ksrevisor.gov: receipt by 7 p.m., effective Jan. 1, 2026). The date strip swapped "Register by Oct. 13" for "Mail ballot apply by Oct. 27"; the registration FAQ (page and JSON-LD) now answers in the past tense and points to VoterView. Six cards keep the grid full. W3C: 0 errors; JSON-LD parses; the strip still fits three lines on a 390px phone under the unchanged hero.

Pushed Oct. 12 at Valdez's request, a day before the deadline. So nothing on the page is false while registration is still open, the copy is tense-neutral: the intro says "Kansas registration closes Oct. 13, 2026," the FAQ answers with the date alone, and the registration card adds "Through Oct. 13 you can still register or update" with the state link. The first draft said "Registration closed Oct. 13," which would have told eligible people a day early that they could not register.

### Mistakes → Rules

- **A deadline change is a sweep, not a section edit.** The request named one section; the same date lived in the strip, the FAQ and its JSON-LD, and all four would have contradicted each other
- **Date-driven copy that ships early must be true on both sides of the date.** Write the deadline as a fact ("closes Oct. 13") rather than a state ("closed"), and keep the action available until it lapses. On a voter page a false "closed" is voter suppression, not a typo

---

## 2026-10-12 — Footer: "Paid for by" line restored

Reverted a654f3e the same hour. Valdez chose to keep "Paid for by Valdez Campos." on the page while it is an ad destination, so the landing page carries the disclaimer the small search ads rely on. CLAUDE.md's footer rule is back to its original wording.

### Mistakes → Rules

- **Name the dependency when removing a compliance line.** The removal shipped before the reason it was there (the ads' disclaimer resting on the landing page) was stated; say it before the push, not after

---

## 2026-10-12 — Footer: dot separators replaced with space

The middle dot between footer phrases read as a stray bullet, most of all when a line held one phrase plus a dot. Replaced `span + span::before { content: "·" }` with a 1.5em gap on wide screens; phones still stack each phrase on its own line with no gap. Rendered at 1400px.

### Mistakes → Rules

- **A decorative separator is only invisible when both sides are full.** Any edit that leaves one phrase on a line exposes the dot; spacing degrades without a trace

---

## 2026-10-12 — Footer: plain sentences

The 1.5em gap that replaced the dots read as broken spacing on the live site. After that rejection, offered four layouts with previews; Valdez chose plain sentences. The gap rule is gone, so the phrases sit on one line separated by the markup's single space, like ordinary prose. Phones still stack each phrase. Rendered at 1400px.

### Mistakes → Rules

- **Swapping one separator for another is still a design guess.** The gap shipped on a one-screenshot check; the faster route was the four-option preview offered after it failed. Offer the options first when a visual call is the user's to make
