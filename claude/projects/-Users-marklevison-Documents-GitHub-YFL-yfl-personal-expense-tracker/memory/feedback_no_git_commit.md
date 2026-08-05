---
name: No git commits by LLM
description: The LLM must never run git commit — only the human commits code
type: feedback
---

Never run `git commit`. Only the human is allowed to create commits.

**Why:** User preference — they want full control over what gets committed.

**How to apply:** When finishing work, summarize changes and let the user commit. Do not offer to commit or run git commit even if asked by a slash command workflow.
