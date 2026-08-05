---
name: Cakemail Migration (was Mailjet)
description: Migrating from Drip to Cakemail for course emails, post-course drip sequences, and newsletters. Phase 1 (pre/post-course transactional emails) is working.
type: project
originSessionId: c9bce4a3-0cfc-4cd8-a05e-0c6c052367c4
---
Started week of 2026-04-07 migrating from Drip. Initially chose Mailjet, switched to Cakemail on 2026-04-13.

**Why Mailjet was abandoned:** Mailjet cannot bridge transactional email recipients into marketing opt-in via a trigger link. Post-course drip emails include a "subscribe to newsletter" link -- when clicked, the platform must send a double opt-in confirmation. Mailjet requires a fresh signup form instead, which breaks the workflow.

**Why Cakemail:** Cakemail's workflow automation supports click-based triggers. Hosted in Canada (privacy law advantage).

**Current status (2026-04-16):**
- Phase 1 (pre-course emails): Working. Sends via Cakemail transactional API with dedup.
- Phase 2 (post-course): Immediate post-course email works. CSM enrollment in PostCourse CSM list works. 9-email automation sequence needs to be built in Cakemail UI.
- Phase 3 (newsletters): Not started.
- Cakemail API was significantly different from docs -- payload structure, sender IDs, custom attribute format all discovered through trial and error. Gotchas documented in CLAUDE.md and CAKEMAIL_MIGRATION_PLAN.md.
- CSPO templates had stale Drip placeholders and wrong URLs -- fixed 2026-04-16.

**How to apply:**
- Migration plan: `CAKEMAIL_MIGRATION_PLAN.md`
- Auth is OAuth 2.0 with refresh token in `.env`, auto-rotated by the client
- No maintained Node SDK -- uses raw `fetch` with thin wrapper (`cakemail-client.ts`)
- Keep existing Drip code as fallback for newsletters
