---
name: reference-cakemail-form-replaces-tags
description: "Cakemail hosted-form submission replaces (not merges) a contact's tag set"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 7c4b92d6-45bf-42d6-92da-f31b7377dfa6
---

A Cakemail hosted-form submission (the `form_submission/<id>` endpoint we POST to browser-direct, e.g. `NEWSLETTER_SIGNUP_FORM_URL`) applies `tags[<name>]=true` fields in **every** contact state — new, `pending`, and already-`active`. Verified 2026-06-02 against all three. It auto-creates unknown tag names (no pre-creation needed), lowercased on storage (see [[reference-cakemail-lowercase-tags]]).

Two important side effects:
1. **Replaces, not merges:** the POST overwrites the contact's entire tag set with only the tags in that submission. Submitting `tags[SignupNewsletterForm]` then later `tags[SignupPopup]` left the contact with only `signuppopup`; the first was wiped. A POST with no `tags[...]` field leaves tags unchanged.
2. **Resubmitting an `active` subscriber resets them to `pending` and re-sends the double-opt-in.** So testing with a real, already-confirmed address both bounces you back through DOI and overwrites your tags. Always test with a fresh `+alias` address.

Corollary for debugging: since the form tags in all states, a signup that produces NO tag means the browser didn't send a `tags[...]` field (e.g. stale `client:only` island bundle — restart dev server), not a Cakemail-side failure. Confirm via DevTools → Network → the POST's request payload.

**Why this matters:** "last touch wins" is fine for per-placement source attribution ([[project-aiquiz-nurture-filter]] uses `SignupNewsletterForm`/`SignupWebinar`/`SignupBanner`/`SignupPopup` via the `source` prop on `form-submission.tsx`). But it's a hazard for `aiquiz`: a quiz-taker who later subscribes via the newsletter form would have their `aiquiz` tag overwritten and drop out of the AI nurture. Decide whether that's acceptable before relying on tags that must persist across multiple form touches.

**How to apply:** Don't assume tags accumulate across form submissions. If a tag must survive later submissions, either re-send it on every form, or apply it via the authenticated API `tagContactOnList` (the `/tag` endpoint, which the email-automation CLI uses) rather than the hosted form.

Caveat: observed on a `pending` (unconfirmed DOI) contact; behavior on a confirmed contact was not separately verified.
