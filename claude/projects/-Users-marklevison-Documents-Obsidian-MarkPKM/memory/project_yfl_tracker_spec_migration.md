---
name: project-yfl-tracker-spec-migration
description: "YFL expense tracker is migrating off rigid SpecDriven AI toward Matt Pocock's lightweight approach; Phase 1 (freeze specs) done 2026-06-24"
metadata: 
  node_type: memory
  type: project
  originSessionId: 4ee4961c-94b4-459f-95a0-248fb2739762
---

Project: `/Users/marklevison/Documents/GitHub/expnese-tracker-attempts/yfl-expense-tracker-svelte-generated` (SvelteKit + Supabase family expense tracker).

Mark is moving it off PaulDuvall/claude-code's SpecDriven AI methodology (rigid `#{#id}` specs, traceability matrices, coverage tables, authority levels, `spec-synchronization` rule) toward a Matt Pocock style lightweight approach. He is removing PaulDuvall/claude-code (the `x*` skills) entirely on 2026-06-24. He never actually ran spec sync or `spec:validate`. Evidence the rigid approach failed: the sync rule was created after an audit found 22 of 25 specs out of date.

Chosen target: **tests as the living spec** (Matt) plus **frozen one-page design notes for non-trivial features** (borrowed from obra), keeping `CLAUDE.md` as the shared domain language. See [[reference-matt-vs-obra-skills]].

**Phase 1 DONE (2026-06-24):** Added "FROZEN: historical design records" banners to `specs/README.md` and `specs/GETTING_STARTED.md`. Specs left in place, `#{#id}` tags in code/tests left alone, nothing deleted.

**Next when Mark resumes:** install `mattpocock/skills` into the project's `.claude/skills/`, then start each feature with `/grill-with-docs` (alignment interview that replaces upfront spec-writing; `tdd` auto-engages on build). `/ask-matt` routes if unsure.

**Pending:** Phase 2 (deprecate `spec-synchronization` rule, drop/shrink `spec:validate`, remove "spec before code" mandate from project guidance), Phase 3 (lightweight loop + design notes in `docs/design/`), Phase 4 (optional: backfill tests for any spec acceptance criteria not yet covered).
