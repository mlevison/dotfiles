---
name: feedback-shutdown-git-ignore-repos
description: Shutdown git scan should ignore chronic-dirty repos redirect-checker and scrumquestions
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 87a98b31-efbb-43d3-84d7-0c43483e07c8
---

In the shutdown-routine git scan, treat the perpetually-dirty working trees of two APR repos as expected noise and do NOT report them as open loops:

- `~/Documents/GitHub/APR/redirect-checker/` (working files like `redirect-checker.js`, `resources/apr-urlstotest.csv`, and untracked `all_links.json` / `scrum_threads.json` are generated/scratch output)
- `~/Documents/GitHub/APR/scrumquestions/` (churned data files: deleted `.csv`, new `.txt`)

**Why:** These are data/scratch repos whose dirty state is normal; flagging them adds noise to every shutdown.

**How to apply:** During the shutdown git open-loops step, still report other repos' uncommitted/unpushed/stashed state, but silently skip these two. Unpushed commits or stashes in other repos are still worth surfacing.
