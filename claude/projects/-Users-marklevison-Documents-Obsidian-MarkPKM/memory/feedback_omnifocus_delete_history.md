---
name: feedback-omnifocus-delete-history
description: "When cleaning up OmniFocus projects/tasks Claude created on Mark's behalf, delete them — don't drop. Mark only preserves history for items he manually created himself."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f12dfee9-17f1-4dbf-b51b-1293ca50de5c
---

When cleaning up OmniFocus projects, tasks, or folders that Claude (or any assistant) created on Mark's behalf — not items Mark created himself — use **delete** (`delete_projects`, `delete_tasks`), not drop.

**Why:** Mark doesn't care about the history of items he didn't manually create. Dropping preserves history that adds no value and clutters the dropped views over time. Keeping the system clean matters more than preserving assistant-generated history.

**How to apply:**
- Migration or cleanup of assistant-created OmniFocus artifacts → delete (default expectation)
- Items Mark manually created → drop unless he says otherwise
- Always confirm before deleting per the existing skill safety rail; the default *for assistant-created items* is delete, not drop
- This refines the general "Prefer drop over delete" line in [[omnifocus-workflow]] — the preference flips when the items in question were assistant-generated

Established 2026-05-31 during the Marketing Experiments restructure: 10 Claude-generated experiment projects were deleted (not dropped) en route to a single consolidated Marketing Experiments project.
