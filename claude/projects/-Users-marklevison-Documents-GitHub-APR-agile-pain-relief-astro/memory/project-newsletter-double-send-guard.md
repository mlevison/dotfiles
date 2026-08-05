---
name: project-newsletter-double-send-guard
description: Why send-newsletter aborts on duplicate campaign names and treats --test-send as preview-only
metadata: 
  node_type: memory
  type: project
  originSessionId: 22649124-a517-4261-acab-01f9370eedb5
---

On 2026-06-11, the GenAI "Rabbit Holes" newsletter went to the whole Newsletter Subscribers list **twice** (two campaigns, same name, both scheduled for 2026-06-12 10:00am ET, both delivered).

**Root cause (three things lined up):**
1. **No idempotency.** `send-newsletter` calls `createCampaign` on every run, POSTing a brand-new campaign each time. Re-running the command is literally how the list gets emailed twice. (Unlike the template path, where `upsertTemplate` dedups by name.)
2. **`--test-send` was additive, not preview-only.** `--test-send mark@ --schedule Fri` sent the test copy AND scheduled the real send in the same command. Mark saw the test land, assumed nothing was committed, and re-ran with `--schedule` to "actually" send it. That second run created a second scheduled campaign.
3. **`--schedule` has no confirmation prompt** (added deliberately per [[feedback-no-confirmation-prompts]]), so nothing surfaced the second commit.

**Fixes shipped (in `email-automation/src/send-newsletter.ts` + `cakemail-client.ts`):**
- **Duplicate guard, no `--force`.** Before `createCampaign`, `findCampaignsByName()` checks the list for the exact campaign name (`{date} - {subject}`). If a match exists in a committed state (scheduled / delivering / delivered), the CLI **aborts** and tells Mark to delete it in Cakemail first. Mark explicitly rejected a `--force` escape: the friction of a manual delete is the safety. Same-name *drafts* don't block (they can't send); they're listed as a cleanup nudge.
- **`--test-send` is preview-only:** combining it with `--send` or `--schedule` now errors. Preview leaves a draft; dispatch is a separate run.

**Why:** a duplicate send to the whole list is high-blast-radius and unrecallable; a CLI that creates a fresh campaign per run needs a name-uniqueness gate, and preview must never also commit.

**How to apply:** Keep the no-`--force` rule if revisiting this code. Don't reintroduce a flag that lets `--test-send` dispatch in one shot. If lightening the guard, scope the lookup to dispatch runs rather than removing it. Cakemail campaign statuses seen: `draft`/`incomplete` (not sent), `scheduled`, `delivering`, `delivered`. Relates to [[feedback-no-confirmation-prompts]] and [[feedback-action-litmus]].
