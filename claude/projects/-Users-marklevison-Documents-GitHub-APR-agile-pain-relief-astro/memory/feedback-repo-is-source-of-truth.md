---
name: feedback-repo-is-source-of-truth
description: The APR repo is the only source of truth for the website; never cite Obsidian vault docs as authoritative
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f6fd7536-3278-4158-96c2-6fbba59ef941
  modified: 2026-07-29T14:45:38.236Z
---

The `agile-pain-relief-astro` repo is the **only** source of truth for the website. Docs in Mark's Obsidian vault (handoffs, specs, design briefs, anything under `~/Documents/Obsidian/MarkPKM/`) are transitional working material.

**Why:** Those docs get deleted once the work lands, and they go stale the moment the code moves on. A `CLAUDE.md` line pointing at one (e.g. the quiz look-and-feel spec, "section 11 of Quiz C - Astro Implementation Handoff.md") sends a future reader to a file that no longer exists, and implies the repo's own description is only a summary of the real authority.

**How to apply:** Never cite an external vault path as the authority for how something works. When such a doc informs a decision, copy the part that still matters into `CLAUDE.md`, `HISTORY.md`, an ADR, or a code comment, and drop the pointer. Exceptions are genuinely external and durable: vendor documentation, and the read-only captures in `reference/`. See also [[feedback-action-litmus]].
