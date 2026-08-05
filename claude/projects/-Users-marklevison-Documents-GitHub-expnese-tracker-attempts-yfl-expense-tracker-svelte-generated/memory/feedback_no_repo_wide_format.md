---
name: feedback_no_repo_wide_format
description: "Never run `npm run format` (prettier --write .) — format only the files you touched"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: ac515644-56ce-416d-9c4c-279a040dae92
---

Do not run `npm run format` — it is `prettier --write .` and rewrites hundreds of
unrelated files (all of `llm_history/`, `specs/`, docs, etc.), which the user then
has to revert. `llm_history/` is access-disallowed and `specs/` is stale/slated for
deletion; churning them is noise.

**Why:** The user had to interrupt and ask for a mass revert after `npm run format`
reformatted ~100 files beyond the intended change.

**How to apply:** Format only the specific files you edited, e.g.
`npx prettier --write <file1> <file2>`. Verify with
`npx prettier --check <files>`. To undo an accidental repo-wide format, revert
everything except intended edits:
`git diff --name-only HEAD | grep -v <my-files> | xargs git checkout HEAD --`.
Relates to [[feedback_fix_warnings_in_touched_files]].
