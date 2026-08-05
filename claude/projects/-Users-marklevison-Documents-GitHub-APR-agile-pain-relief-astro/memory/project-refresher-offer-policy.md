---
name: project-refresher-offer-policy
description: How to build the audience for free-seat refresher offers to alumni (CSM/CSPO) and how to deliver them
metadata: 
  node_type: memory
  type: project
  originSessionId: b8f34569-a821-4aba-a1a5-86a7c9c90fe7
---

Free refresher-seat offers to past students. Audience is built from Cakemail tags, NOT a standing list.

**Audience rule (all three filters):**
1. Include `Interested - Refresher - {COURSE}` (e.g. `Interested - Refresher - CSM`).
2. Exclude `DO NOT NOTIFY - Refresher - {COURSE}` (hard suppression; if both Interested + DNC, DNC wins).
3. Exclude anyone who already attended a refresher — they carry a `Course - <session-date> - …` tag for the refresher session, separate from their original training. Known refresher session dates: `2026-03-05` (CSM Mar 5–6), `2025-07-14`/`2025-07-15` (CSPO Jul 14–15). Extend when a new refresher runs.

**Why:** Mark spotted that someone we were about to email had already attended the March refresher. Don't offer the same person a second free seat.

**How to apply:** Source data is the migration exports `email-automation/migration/{all-people,subscribers-people}.csv`. Filtered CSM list materializes to `migration/refresher-csm-interested.csv`. Cleaner durable signal going forward: a dedicated `Attended - Refresher - {COURSE}` tag so filter 3 is one tag check, no date table.

**Delivery:** direct/transactional send (`sendTransactional()` → `/v2/emails`), one rendered email per recipient — no new list (its `list_id` is only relay context, doesn't subscribe anyone). Run via `npm run send-refresher` (`src/send-refresher.ts`): `--test-send <email>` for one preview, `--audience <csv> --send` for the real send. Pass `senderId: SENDER_ID_MARK` so it comes from Mark, not contact@. Cakemail auto-appends an unsubscribe button to the transactional footer (confirmed on a test send), so no manual compliance footer needed. Full policy in `email-automation/CLAUDE.md` → "Refresher offers". Template base: `templates/course/reference-archive/refresher-promo-csm-*.md`. Related: [[feedback-action-litmus]].
