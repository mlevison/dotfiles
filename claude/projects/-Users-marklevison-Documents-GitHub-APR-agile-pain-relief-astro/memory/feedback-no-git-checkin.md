---
name: feedback-no-git-checkin
description: "Never commit, push, or otherwise alter git history on Mark's behalf — he runs all check-in steps himself"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c81ec479-f739-4152-86c9-4293f4137844
---

Never run `git commit`, `git push`, `git merge`, `git rebase`, `git reset`, `git revert`, `git cherry-pick`, `gh pr create`, or `gh pr merge`. Mark does all check-in steps himself.

**Why:** Mark wants to review every diff before it lands in history, and to control commit messages and PR descriptions himself. He flagged this explicitly on 2026-05-27 when I asked if I should commit + push the Cakemail token-rotator changes. The deny list in `.claude/settings.local.json` enforces it at the harness level (the `deny` block under `permissions`), so any attempt should also be blocked at runtime — but don't rely on that; treat it as a hard rule and don't even ask.

**How to apply:** After making code changes, stop at "the diff is ready." Tell Mark what changed and what he needs to do next (e.g. "run tests then commit when ready"), and let him drive from there. Don't offer to commit "for convenience." Don't propose `git commit && git push` as a chained command even if he asked you to do prior steps. Reading git state (`git status`, `git diff`, `git log`) is fine — only mutations are off-limits.
