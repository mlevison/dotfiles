---
name: minimal-code-comments
description: "Mark strongly prefers minimal code comments; write few, and only where the code cannot say it"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d6a0162a-1487-4371-bd5b-6e8785b46749
  modified: 2026-08-03T20:20:19.705Z
---

Mark strongly prefers **minimal comments in code**. Explanatory prose that
restates what the code does, or narrates rationale at paragraph length, is
unwanted — even when the surrounding file already has it.

**Why:** comments drift out of touch with reality. The code changes, the comment
does not, and the stale comment is then worse than no comment.

**How to apply:** default to no comment. Write one only for something the code
genuinely cannot express — a non-obvious constraint, a "this order is
load-bearing", an external API's quirk — and keep it to a line or two. Put the
long-form reasoning in `docs/` (design docs, ADRs, `CLAUDE.md`), which is
maintained deliberately, not in the source. This applies to new files as well as
edits.

Note: this is about *code*. Design docs and ADRs in this repo are deliberately
detailed — see [[yfl-design-docs-are-detailed]].
