---
name: social-media-ai-vs-code-split
description: What Mark wants handled by code vs left to the AI in the social posting pipeline
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 3db4ce36-9021-4bcd-9ef2-73f3e85ebe32
  modified: 2026-07-27T20:20:46.717Z
---

Mark's standing concern (2026-07-27): the social pipeline was leaning on the AI for work that code should do, which made the whole system more complex, not less.

**Code's job** (all now implemented): batch validation (`npm run validate`), marking the calendar and quiz seeds after scheduling (automatic in `npm run batch`), and the reshare performance table (`npm run reshare-report`).

**The AI's job:** drafting in Mark's voice, condensing to 290 chars, choosing items and angles, the anti-AI caveat wording, and tier-move judgement.

**Why:** mechanical work done by an LLM is re-derived (and re-risked) every run. Concretely, the quarterly queue tune told the assistant to "write a node one-liner inline" — when that was turned into tested code, it exposed a bug an ad-hoc script had been making: PostHog emits `snapshot_date=unknown` rows, and `"unknown" > "2026-07-26"` as a string, so the stale row won the "latest snapshot" comparison and put a bogus 288-session item at rank 1.

**How to apply:** if a task is deterministic, write it as a tested command in `social-media-posting` and have the skill call it. Reserve the model for judgement and voice.

See [[social-media-repo-ownership]].
