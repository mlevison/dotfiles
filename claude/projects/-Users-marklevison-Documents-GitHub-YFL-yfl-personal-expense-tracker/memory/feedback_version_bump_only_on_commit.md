---
name: feedback_version_bump_only_on_commit
description: Only bump src/lib/version.ts when the change is actually committed & pushed live
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c5bbfa7b-b74f-412a-8f4c-ac216182af79
---

Do **not** increment `APP_VERSION` in `src/lib/version.ts` for uncommitted work.
Only bump the version when the app has been committed and pushed to live. While
building/iterating (which may span several turns before a commit), leave the
version at its current committed value.

**Why:** the LLM never commits (see [[feedback_no_git_commit]]); the human commits
and pushes. Bumping the version on every uncommitted edit desyncs the displayed
version from what's actually live and burns version numbers on work that may still
change.

**How to apply:** when finishing a feature/fix, leave `version.ts` alone. In docs
(design docs, product-backlog) don't assert a specific version tag (e.g. "v0.70")
for unreleased work — write "(pending release)" / "version assigned on commit"
instead. The human assigns and bumps the version at commit time.
