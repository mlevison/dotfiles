---
name: feedback-comments-are-a-smell
description: "Mark almost never writes code/content comments; a needed comment signals the work is badly framed, and every comment already in the repo was AI-generated"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 80876150-bb6c-4f9f-9936-1c07745c4b72
  modified: 2026-08-04T18:50:33.334Z
---

Mark almost never writes comments. **Every comment currently in this repo was
AI-generated, not authored by him.** His rule: "if we write a comment it often
suggests the work is poorly written or framed."

**Why:** a comment that explains what code or copy *means* is a patch over
writing that failed to say it. Fixing the naming, the structure or the sentence
removes the need for the note. Comments also rot silently while the thing they
describe moves on.

**How to apply:**

- Default to writing none. Fix the framing instead of annotating it.
- Never cite an existing comment as Mark's intent or preserve one because it
  looks authored. It isn't.
- The one kind that can earn its place: recording which of several *legal*
  configurations was chosen and why, where the file genuinely cannot show it
  (e.g. `capturePosition: 'end'` when `'start'` is equally valid). Even these are
  provisional; he has said "leave other comments for now", not that they're
  wanted.
- Durable "why" belongs in `HISTORY.md`, `CLAUDE.md`, or an ADR, not inline. See
  [[feedback-repo-is-source-of-truth]].
- When cleaning up, remove the comments *you* added rather than asking which to
  keep.
- **This is a cross-project preference, not an APR one.** He restated it on
  2026-08-04 about APR, citing having said the same in `personal-expense-tracker`
  the day before. Apply it everywhere, from the first draft, not as a cleanup
  pass after he objects.
- The specific failure mode he names is the **long essay**: a multi-paragraph
  docblock narrating what the code replaced, why the old way was wrong, and what
  trade-off was weighed. That is `HISTORY.md` material. Inline, keep to a short
  line, and prefer a trailing `// ...` on the field over a block above it.
- Don't annotate incidental detail. He called out a note explaining why a
  calendar window was `08:59-17:01` rather than `09:00-17:00`: "the distinction
  isn't worth noting." If a reader would shrug, cut it.
