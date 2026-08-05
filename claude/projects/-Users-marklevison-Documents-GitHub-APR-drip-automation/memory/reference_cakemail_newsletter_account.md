---
name: Cakemail signup account
description: Which Cakemail account owns the dedicated refresh token used by the Astro site's newsletter-signup endpoint
type: reference
originSessionId: 0116aa91-76b8-4f33-bd77-e288549b917e
---
The `CAKEMAIL_SIGNUP_REFRESH_TOKEN` env var used by `src/pages/api/newsletter-signup.ts` belongs to the Cakemail account `mlevison+cakemail@gmail.com`.

This is a separate account from the primary one used by `email-automation/src/cakemail-client.ts`. The split exists because the automation CLI rotates its refresh token on each use — sharing would cause the two systems to invalidate each other.

To regenerate the token, run `cd email-automation && npm run refresh-cakemail -- --purpose signup` and log in as `mlevison+cakemail@gmail.com`. The script prints the env var with the correct name (`CAKEMAIL_SIGNUP_REFRESH_TOKEN`) and reminds you to set it as a Netlify env var, NOT in `email-automation/.env`.
