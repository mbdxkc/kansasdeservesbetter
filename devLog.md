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
