---
name: APR Analytics Architecture
description: Where APR content analytics lives after the 2026-04-20 consolidation — raw data in Astro repo, analysis and experiments in vault.
type: project
originSessionId: 4b482b80-8ec5-4a24-a3a0-1c4fe2fd4a7e
---
APR content analytics is split across two repos by function (consolidated 2026-04-20):

- **Raw data pulls stay in the Astro repo** at `/Users/marklevison/Documents/GitHub/APR/agile-pain-relief-astro/analytics/`. Includes `history.json`, `Ahrefs/`, `google/`, `posthog/`, `email-engagement/newsletter-engagement.json`. Pulled via `npm run scrape` and `npm run posthog-export` in that repo.
- **Analysis and business thinking live in the vault** at `APR/Analytics/`. The single live snapshot is `content-performance-snapshot.md` (overwritten, not dated — Mark wants one place to look). Companion durable-findings docs: `email-engagement-findings.md` and `traffic-sources-findings.md`. Ongoing action list: `content-work-plan.md`. Per-experiment notes are under `APR/Analytics/Experiments/` with an index at `_Experiments Index.md`.

**Why:** Obsidian Kanban = writing capture + idea pool; OmniFocus = committed work with dates / monitoring schedules; raw data stays where the pull scripts write it.

**How to apply:**

- For content performance questions → invoke `apr-content-performance` skill (reads from Astro paths, writes to vault).
- For the weekly loop → invoke `apr-weekly-analytics` (runs the npm scripts, then the analyzer).
- New marketing experiment → two linked artifacts: (1) vault note in `APR/Analytics/Experiments/` named `<Idea> YYYY-MM-DD.md` with frontmatter `status` and `review_after`; (2) OmniFocus project with the same name under `APR Business Owner > Marketing Experiments`, containing execution tasks plus a deferred "Check results" task.
- All currently-active experiments (as of 2026-04-20) are gated on `review_after: 2026-05-18` — don't act on them before that date.
- Analytics has no course registration or revenue data — factor this gap into performance interpretation.
