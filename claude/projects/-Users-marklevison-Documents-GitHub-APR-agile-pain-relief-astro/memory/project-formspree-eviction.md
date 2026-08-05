---
name: project-formspree-eviction
description: "Formspree is only used by the contact form; eviction is a small, deferred task — no urgency as of 2026-05-26"
metadata: 
  node_type: memory
  type: project
  originSessionId: 0f2176aa-5f54-4f20-aadd-8b3a46925b58
---

Formspree's only remaining runtime use is the contact form at `src/components/global/contact-form/form.tsx`, which POSTs to `https://formspree.io/f/xkgjnqdw`. Nothing else in the site references Formspree (only doc mention is `email-automation/DRIP-TO-CAKEMAIL-MIGRATION.md`).

**Why:** Mark is consolidating away from third-party form/email vendors as part of the broader Drip → Cakemail migration. Formspree is the last holdout. Confirmed on 2026-05-26 as low-priority — not blocking anything.

**How to apply:** When Mark decides to act, the work is ~1 hour:
1. Add a new Astro endpoint (e.g. `src/pages/api/contact.ts`) following the pattern in `src/pages/api/newsletter.ts`.
2. Change the `fetch()` URL in `form.tsx` to point at the new endpoint.
3. Pick a sender. Three viable options identified:
   - **Cakemail transactional** — reuses existing creds; need to verify the plan supports transactional/one-off send (their primary product is broadcast).
   - **Resend / Postmark** — cleanest fit, new API key, free tier covers volume.
   - **Netlify Forms** — simplest; replace `fetch` with a `data-netlify` form attribute, no endpoint or secret needed.
4. Set one env var on Netlify if not using Netlify Forms.

Decision still open. If Mark mentions contact-form changes, surface this as a chance to also evict Formspree.
