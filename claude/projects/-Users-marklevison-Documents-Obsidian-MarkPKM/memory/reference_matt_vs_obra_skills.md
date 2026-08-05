---
name: reference-matt-vs-obra-skills
description: "How Matt Pocock's skills, obra/superpowers, and PaulDuvall/claude-code compare on the lightweight-vs-heavyweight axis"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 4ee4961c-94b4-459f-95a0-248fb2739762
---

Claude Code skill libraries Mark compared (June 2026), placed lightweight/empirical to heavyweight/process:

- **[mattpocock/skills](https://github.com/mattpocock/skills)** — light, composable, liftable. Tests read as specs; alignment via `grill`/`grill-with-docs`; rationale captured as ADRs; shared language in a `CONTEXT.md`. Closest to Mark's pragmatic-Agile style.
- **[obra/superpowers](https://github.com/obra/superpowers)** (Jesse Vincent) — medium, disciplined XP. Iron-law TDD (deletes code written before tests), `brainstorming` hard-gate writes a per-feature design doc committed to git (frozen, not synced), verify-before-done. Heavier machinery (git worktrees, subagent-per-task, parallel dispatch).
- **[PaulDuvall/claude-code](https://github.com/PaulDuvall/claude-code)** — heaviest, spec-driven (the `x*` skills). Specs as source of truth with IDs, traceability, coverage gates.
- **BMAD-METHOD** and **levnikolaevich/claude-code-skills** wear the "Agile" label but are heavyweight (roles, ceremonies, PRDs). Cargo-cult Agile, not Mark's style.

Key insight for Mark: the *value* of a spec (acceptance criteria + rationale + a test guarantee) survives in both Matt and obra; the *ceremony* (IDs, matrices, coverage tables, authority levels, sync rules) is the cost that drifts. Both keep value by making tests the living truth and design docs write-once.

Applied to the YFL tracker migration: see [[project-yfl-tracker-spec-migration]].
