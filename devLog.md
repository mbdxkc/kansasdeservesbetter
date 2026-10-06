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
