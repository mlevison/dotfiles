---
name: reference-cakemail-token-auto-rotate
description: Cakemail refresh token rotates automatically every run; refresh-cakemail is recovery-only
metadata: 
  node_type: memory
  type: reference
  originSessionId: ce4c33f8-2292-4061-90da-79d18b6d9b26
---

The `email-automation/` CLI's `CAKEMAIL_REFRESH_TOKEN` is refreshed automatically: every run exchanges it for a short-lived access token, and if Cakemail rotates the refresh token in that response, `src/cakemail-client.ts` writes the new value back to the root `.env` itself (no manual step).

`npm run refresh-cakemail` is the **recovery path only** — used when the refresh token has fully expired (client throws `Cakemail refresh token expired. Run: npm run refresh-cakemail`). It does `grant_type=password` (prompts username + password) to mint a brand-new token and just *prints* it to paste into root `.env`; it parses no args (there is no `--purpose automation` flag — that was a stale doc claim, fixed 2026-06-17).

Related: [[reference-cakemail-lowercase-tags]], [[reference-cakemail-form-replaces-tags]].
