---
name: project-scoreapp-eviction
description: ScoreApp is being replaced with a self-hosted MDX-driven quiz engine in this repo. Existing ScoreApp webhook handler will be removed.
metadata: 
  node_type: memory
  type: project
  originSessionId: 6eee7ff8-24ab-447a-8680-e7b52fdf2035
---

ScoreApp is being ditched (poor usability). Replacement is a self-hosted quiz engine built inside this Astro repo using MDX content collections, a React 19 client island for the stepper, and an `/api/quiz-submit` endpoint that calls Cakemail directly via `src/lib/cakemail.ts`.

**Why:** Mark finds ScoreApp's UX unacceptable. Cakemail integration and lead-capture plumbing already exist in-repo, so the marginal cost of self-hosting is lower than the spec's "mock the webhook" framing suggests.

**How to apply:**
- The existing `src/pages/api/scoreapp-webhook.ts` + `SCOREAPP_WEBHOOK_SECRET` env var become dead code once the new quiz ships; remove them as part of the cutover (not silently leave in place).
- The `aiquiz` tag and the planned [[project-aiquiz-nurture-filter]] nurture sequence still apply to the new quiz, so tag the contact the same way on submit.
- When the spec and the existing repo conflict, the repo wins (e.g., React 19 not Svelte; real Cakemail helpers not mocks; `src/content.config.ts` not `src/content/config.ts`).
