---
name: feedback_claude_md_defers_to_skills
description: "When CLAUDE.md and a skill overlap and disagree, the skill is authoritative; slim CLAUDE.md to point at the skill"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 9c53295b-4a0e-4d5f-b63b-4d89273bcf8b
---

When a CLAUDE.md and a skill (or shared reference doc) describe the same thing and they disagree, the skill is correct and CLAUDE.md is the stale copy. Mark wants CLAUDE.md to hold *less* detail and defer to the skills rather than duplicate their rules.

**Why:** Duplicated rules across CLAUDE.md and skills drift apart silently (e.g. character limits, posting cadence, file paths all diverged across four docs before this was fixed).

**How to apply:** When consolidating, move the canonical detail into the skill (or a shared `_*-conventions.md` reference next to the skills) and replace the CLAUDE.md copy with a short pointer. Example: `agile-pain-relief-astro/.claude/skills/_social-posting-conventions.md` is the single source of truth for the social-posting skills; the repo CLAUDE.md just points to it. Related: [[feedback_no_unsolicited_files]].
