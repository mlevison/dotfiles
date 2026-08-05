---
name: feedback-criticmarkup-terse-corrections
description: "In CriticMarkup, deliver corrections as bare substitutions with no explanatory comment; comment only for genuine judgement calls"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 82b810dc-71f7-4ce9-ba13-18de411cbf3f
---

When marking up Mark's Markdown with CriticMarkup, a correction gets the bare `{~~old~>new~~}` substitution and nothing else. No `{>>Claude: ...<<}` comment explaining why.

**Why:** Mark reads each suggestion and decides whether it makes sense himself, so the explanation is wasted. He said this explicitly (2026-06-14) for house-rule fixes (GenAI vs bare "AI", "Scrum Master" vs ScrumMaster) and added "in fact this is the case for most of the edits." Confirmed in practice: he accepted every bare correction in a social-posts pass without needing the rationale, and the comments I attached were just clutter.

**How to apply:** Default to no comment. Bare substitutions/additions/deletions for corrections (terminology, banned buzzwords, typos, obvious tightens). Reserve a `{>>Claude: ...<<}` comment for a genuine judgement call or a structural observation Mark can't infer from the change itself. Now encoded in `Skills/criticmarkup-editing.md` (protocol point 3). Pairs with [[feedback_no_ai_edits_to_copy]].
