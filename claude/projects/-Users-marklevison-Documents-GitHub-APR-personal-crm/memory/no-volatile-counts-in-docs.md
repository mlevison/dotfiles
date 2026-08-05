---
name: no-volatile-counts-in-docs
description: "Don't put file/record counts in CLAUDE.md or other docs — Mark considers them noise"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 62a0231f-db46-4a8f-9d39-974417b78e0e
  modified: 2026-07-30T14:21:10.826Z
---

When documenting a directory or dataset, describe *what* it holds, not *how many*
items it has. Mark's words when offered a fix for stale counts in CLAUDE.md:
"Drop file counts - they add nothing."

**Why:** Counts go stale the moment anything is added, so they generate churn and
false "outdated docs" signals without ever informing a decision. `client/ one
markdown file per client` tells a reader everything `~287 markdown files` did.

**How to apply:** In CLAUDE.md and similar docs, write `client/ one markdown file
per client` rather than a count. When auditing docs and finding a stale count,
propose deleting it rather than correcting it.
