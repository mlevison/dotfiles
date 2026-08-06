---
name: reference-cakemail-form-replaces-tags
description: "Cakemail hosted-form submission replaces (not merges) a contact's tag set"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 7c4b92d6-45bf-42d6-92da-f31b7377dfa6
  modified: 2026-08-05T23:47:24.791Z
---

A Cakemail hosted-form submission (the `form_submission/<id>` endpoint we POST to browser-direct, e.g. `NEWSLETTER_SIGNUP_FORM_URL`) applies `tags[<name>]=true` fields in **every** contact state — new, `pending`, and already-`active`. Verified 2026-06-02 against all three. It auto-creates unknown tag names (no pre-creation needed), lowercased on storage (see [[reference-cakemail-lowercase-tags]]).

Two important side effects:
1. **Replaces, not merges:** the POST overwrites the contact's entire tag set with only the tags in that submission. Submitting `tags[SignupNewsletterForm]` then later `tags[SignupPopup]` left the contact with only `signuppopup`; the first was wiped. A POST with no `tags[...]` field leaves tags unchanged.
2. **Resubmitting an `active` subscriber resets them to `pending` and re-sends the double-opt-in.** So testing with a real, already-confirmed address both bounces you back through DOI and overwrites your tags. Always test with a fresh `+alias` address.

Corollary for debugging: since the form tags in all states, a signup that produces NO tag means the browser didn't send a `tags[...]` field (e.g. stale `client:only` island bundle — restart dev server), not a Cakemail-side failure. Confirm via DevTools → Network → the POST's request payload.

**Why this matters (revised 2026-08-05 — the original framing understated it badly):** this is not merely "last touch wins" on attribution tags we apply ourselves. The April 2026 Drip migration imported 3,650 contacts onto the **Newsletter Subscribers** list carrying ~4 tags each — 358 `Alum*`, 554 `NewsletterAlumni`, 760 `Interest*`, 2,243 `Signup*`, 21 refresher tags of which 7 are `SuppressRefresherCSM` suppressions (counts from `email-automation/migration/drip-import-2026-04-23.json`). The **first** time any of them submits **any** hosted form — newsletter, popup, banner, quiz, AI download — that whole set is replaced by the two or three tags in that one submission. Losing a suppression tag is the worst case. Tags are list-scoped, so the parallel tags on Course Students are safe.

Nothing was lost as of 2026-08-05 (no form signups in a long while), but the exposure goes live the moment the quiz is promoted to that list.

**How to apply:** Don't assume tags accumulate across form submissions, and don't add a `tags[...]` field to a browser form without deciding what it destroys. A POST with **no** `tags[...]` field leaves tags untouched, so sending nothing is the safe default. If a tag must survive, apply it via the authenticated API `tagContactOnList` (the `/tag` endpoint, which the email-automation CLI uses), which merges — not the hosted form.

Caveat: observed on a `pending` (unconfirmed DOI) contact; behavior on a confirmed contact was not separately verified.
