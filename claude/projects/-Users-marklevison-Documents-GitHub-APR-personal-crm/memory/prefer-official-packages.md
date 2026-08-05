---
name: prefer-official-packages
description: Always prefer official/first-party packages over third-party or hand-rolled alternatives
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c967acce-d065-4498-ad9c-e5dc0985b911
---

When a task needs a library and an official/first-party package exists (e.g. Google's `googleapis` for Gmail), choose it by default without asking.

**Why:** Mark stated this as a standing preference and explicitly does not want to be re-asked to confirm it each time.

**How to apply:** Pick the official package, pin it, install under the repo's `min-release-age=7` `.npmrc` guard. Only raise the choice if the official package is unmaintained/deprecated or genuinely can't do the job. This is a global preference (also written to `~/.claude/CLAUDE.md`), not scoped to this project.
