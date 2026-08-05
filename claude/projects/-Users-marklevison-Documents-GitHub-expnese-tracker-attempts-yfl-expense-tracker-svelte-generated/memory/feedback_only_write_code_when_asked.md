---
name: feedback_only_write_code_when_asked
description: "Don't write/implement code unless the user explicitly asks; default to summary/design"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d0175704-9a47-407c-8be5-1b3da9a6f23d
---

Only write or edit code (source, migrations, config, new files) when the user
**explicitly** asks for implementation. A request to assess, review, summarize,
verify, or design is NOT authorization to build it.

**Why:** The user asked "are any PRDs fixed?" and later for a security-item
"summary" and "how do I implement invitations?" — each an analysis/design ask.
I jumped to writing a full SQL migration unprompted; the user pushed back
("I didn't ask for an implementation. Just a summary."). (They later chose to keep
that particular migration, but the default was still wrong.)

**How to apply:** When implementation looks like the natural next step, stop and
*offer* it — let them say yes. Keep updating docs/backlog/PRDs freely; this rule is
about code. Now codified in the repo's CLAUDE.md "Workflow Rules". Related:
[[feedback_no_git_commit]], [[feedback_version_bump_only_on_commit]].
