---
name: project-spec-system-dead
description: "The specs/specifications traceability system and spec:validate are abandoned, despite CLAUDE.md"
metadata: 
  node_type: memory
  type: project
  originSessionId: 54ba03d0-cc70-4cd7-86bf-938cd3f3fe92
---

The machine-readable spec system is **dead**: `specs/specifications/`, the
`#{#id}` traceability tags scattered through the code (e.g. `#{#dtv2a}`), and
`npm run spec:validate` are all leftovers from an abandoned approach. Do **not**
create new spec entries or `#{#id}` tags, and don't treat spec:validate as a
gate.

**Why:** CLAUDE.md still documents this system as live (Architecture → Specs,
and the `spec:validate` command), so a fresh session will wrongly assume it's
current. The user confirmed on 2026-07-02 that the remaining items are
leftovers.

**How to apply:** When asked to "turn X into a PRD" or spec, write a plain
human-readable doc (the user prefers `.notes/`), not a traceable spec entry.
