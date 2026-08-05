---
name: code-is-reality
description: "Mark's rule for resolving any disagreement between documentation and code"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 3db4ce36-9021-4bcd-9ef2-73f3e85ebe32
  modified: 2026-07-27T21:17:54.224Z
---

**"Code is reality. The documentation should reflect code."** Stated by Mark on 2026-07-27, as a standing rule, not a one-off.

**How to apply:**
- When a doc and the code disagree, the doc is wrong. Fix the doc. Never "correct" the code to match a document, and never present it as a choice between the two.
- Don't ask which one should move. Asking implies the doc might be authoritative; it isn't.
- Verify doc claims by *running the code*, not by reading it and trusting the reading. When a doc lists what a validator enforces, exercise each rule and confirm. (Doing this caught a claimed rule list that omitted a real blocking check.)
- Applies to observed behaviour too, not just source. A documented convention that practice has diverged from is stale documentation: hashtag counts were written as LinkedIn 2-4 / Mastodon 2-3 / Bluesky 2, while the last 80 posts averaged 0.4 / 1.3 / 0.9. The doc was rewritten to describe reality.

**Why:** duplicated rules drift silently. In this project the same posting-cadence figure was wrong in three separate documents while the code was right the whole time, and would have over-scheduled a batch by 50%.

**Corollary Mark added:** anything handled in code should not be duplicated in prose at all. A doc may describe *what* a command does and *why*, but the numbers, thresholds and syntax live in exactly one place, with tests.

See [[social-media-repo-ownership]] and [[social-media-ai-vs-code-split]].
