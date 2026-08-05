---
name: project_single_maintainer_no_owner_field
description: "Solo project — don't add an Owner field to PRDs or assign owners"
metadata: 
  node_type: memory
  type: project
  originSessionId: d0175704-9a47-407c-8be5-1b3da9a6f23d
---

Mark is the only person working on this repo. Don't include an **Owner** field in
new PRDs (or assign owners / "unassigned" anywhere). Just omit it.

**How to apply:** New PRDs use Status/Created/Surface/Related headers, no Owner
line. Existing PRDs still carry stale `Owner: _unassigned_` lines — leave them
unless asked to clean up. Reinforces [[feedback_single_working_backlog]] (one
maintainer, one working list).
