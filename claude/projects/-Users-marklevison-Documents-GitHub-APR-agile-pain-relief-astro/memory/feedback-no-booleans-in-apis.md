---
name: feedback-no-booleans-in-apis
description: "Prefer string enums over booleans in public APIs (schemas, function signatures, frontmatter) — booleans are unreadable at the call site"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 3f819dd0-7b75-4f99-b8f9-f1b4870c27a6
---

When designing options for schemas, frontmatter fields, function signatures, or any other caller-facing API, prefer string enums (e.g. `'none' | 'within-sections'`) over booleans (e.g. `randomize: true`).

**Why:** Booleans are difficult to read at the call site. `randomize: true` forces the reader to remember what `true` means; `randomize: 'within-sections'` is self-documenting. This also leaves room to add a third option later without a breaking rename.

**How to apply:** When proposing or designing an option that could be expressed as a flag, default to a string-enum union. Reach for booleans only when there is genuinely no third state ever (and even then, name the variants explicitly when possible).
