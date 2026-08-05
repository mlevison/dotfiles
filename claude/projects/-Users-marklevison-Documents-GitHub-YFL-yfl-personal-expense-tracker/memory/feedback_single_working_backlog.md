---
name: feedback-single-working-backlog
description: "One human on this project — keep one working backlog, not parallel to-do lists"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 2ecceeb9-efef-42f4-b3c3-ea76419b4a71
---

There is a single maintainer on this project, so all work lives in **one working
list**: `docs/product-backlog.md` (features, UX bugs, engineering, open questions,
and open refactoring items). `docs/refactoring-backlog.md` stays as a **detailed
RF-NN reference**, not a second to-do list — surface its open items in the backlog
as one-line `RF-0X` entries that link into the detail.

**Why:** with one person doing everything, parallel lists fragment attention and
go stale. One list is the thing to work from.

**How to apply:** don't create new parallel backlogs/TODO files. New actionable
work → a bullet in `docs/product-backlog.md`. Refactoring detail → an RF-NN entry
in the refactoring doc, plus a one-liner in the backlog. Mark RF items done/deferred
rather than listing completed work as open. Related: [[project_spec_system_dead]].
