---
name: feedback_fix_warnings_in_touched_files
description: "When editing a file, also fix pre-existing lint/type warnings in that same file"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: e3e16c2f-8dd9-4ed5-a60a-9208f5bc87c0
---

When working on code, always fix warnings/errors that live in the same file you're
editing — even if they pre-date your change and are unrelated to the task. Don't
just note "pre-existing, not mine" and leave them.

**Why:** The user treats a touched file as one you now own; leaving known
warnings/errors behind is incomplete work.

**How to apply:** After editing a file, run the relevant linter/type-checker on it
(e.g. `npx eslint <file>`, `npm run check`) and clear every warning/error in that
file. Keep fixes behavior-preserving (e.g. `[\s\-]` → `[\s-]` for
`no-useless-escape`) and re-run tests to confirm. Scope stays the file(s) you
touched — not the whole repo. Relates to [[feedback_code_style_returns]].
