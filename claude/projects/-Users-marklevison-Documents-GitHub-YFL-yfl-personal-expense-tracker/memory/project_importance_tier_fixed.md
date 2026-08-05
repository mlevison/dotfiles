---
name: project-importance-tier-fixed
description: Spending hierarchy — the 3 Importance areas are permanently fixed; no CRUD for that tier
metadata: 
  node_type: memory
  type: project
  originSessionId: 849ce0a2-df96-4fb0-9fb0-ff522796c580
---

The spending report's top tier — the 3 Areas of Importance (Essential /
Priorities / Other) — is **permanently fixed**. No add / rename / reorder /
delete UI for Importance areas, and none is planned. Confirmed by the maintainer
on 2026-07-09 as "fixed — will not change," a settled product decision, not a
deferral. Treat Importance-area CRUD as a non-goal.

Groupings (the middle tier) ARE editable: assign categories, re-parent groups,
and **add/rename Groupings** shipped in v0.67. Still open (possible later, low
value): Grouping delete (empty groups are inert — report suppresses zero-activity
rows) and Grouping reorder (`sort_order`; renders alphabetically for now).

Design: docs/plans/2026-07-09-spending-report-design.md (Editable hierarchy +
Deferred sections).
