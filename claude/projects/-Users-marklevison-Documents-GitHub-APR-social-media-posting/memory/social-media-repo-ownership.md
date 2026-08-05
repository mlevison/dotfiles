---
name: social-media-repo-ownership
description: "The agreed division of labour across the three repos that touch social media, and the rule that keeps them from drifting"
metadata: 
  node_type: memory
  type: project
  originSessionId: 3db4ce36-9021-4bcd-9ef2-73f3e85ebe32
  modified: 2026-07-27T20:20:39.480Z
---

Social media work spans three places, and on 2026-07-27 Mark chose to **keep all three** rather than consolidate, fixing *ownership* instead:

- `social-media-posting` — the only place rules are **encoded**. Buffer API, validation, slot allocation, marking, metrics.
- `agile-pain-relief-astro` — content and data only (planning markdown, batch JSON, analytics), plus the authoring skills.
- `MarkPKM` vault — voice, judgement, and runbooks (`linkedin-style`, `reshare-queue-tune`, `weekly-analytics`).

**The rule:** any number or checkable rule (character limits, per-network URL counting, posts-per-weekday, UTM format, posted-marker syntax) lives in exactly one file, in code, with a test, exposed as an `npm run` command. Skills describe how to *write*; they call commands for anything checkable. Prose restating a rule is documentation, not a second implementation.

**Why:** the problem was never three locations, it was three *copies of the rules*. Diagnosis found the evergreen skill claiming 3 posts/weekday while the code scheduled 2, a 20-line character-count validator pasted into a skill duplicating tested code, and a vault runbook still describing a Playwright scraper replaced months earlier.

**How to apply:** before adding guidance to a skill, check whether it's a rule (→ code + command) or judgement (→ skill). When a skill and the pipeline disagree, the pipeline wins and the skill gets corrected.

See [[social-media-ai-vs-code-split]].
