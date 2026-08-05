---
name: feedback-linkedin-ai-caveat
description: "LinkedIn AI-skeptical posts need a one-line caveat clarifying Mark isn't anti-AI; the goal is using the tools safely by understanding failure modes"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f7b4a753-51a1-4544-9dd1-54b9abb4ce64
---

LinkedIn AI-critical posts (Mark posting data about AI failure rates, quality issues, security defects, hallucinations, deskilling) read to that audience as "Mark is anti-AI". He isn't. Every such LinkedIn post needs a short caveat positioning the critique as a prerequisite to using AI well, not a rejection of it.

**Why:** Mark reported on 2026-05-30 that LinkedIn posts on failure modes were generating reactions framing him as anti-AI. The studying-the-failure-modes framing is essential to his actual position — "without that, we're blind" — and needs to be on the post body, not assumed.

**How to apply:**

- Only on LinkedIn (by default). Mastodon and Bluesky audiences read the same content as obviously pro-skeptical and don't need the disclaimer; Bluesky also lacks the character budget.
- Only on posts that critique AI. Neutral or non-AI posts (Spotify Model, generic Scrum content) shouldn't carry the caveat — it would read as defensive.
- One sentence, two at most. It's a frame, not an argument.
- Place it between the last analysis paragraph and the CTA. Don't open with it — the data hook still leads.
- Vary the wording across posts in the same batch. Stock-phrase repetition reads as a disclaimer the reader tunes out.

Working variants (use a different one per post in a batch):

- "Not anti-AI. We study the failure modes so we can use the tools safely. Without that, we're flying blind."
- "Studying where AI breaks isn't anti-AI. It's the precondition for using it well."
- "I use these tools too. Knowing the failure modes is how we use them well."
- "I'm not against AI. Studying the failure modes is how we use it safely."
- "Not anti-AI. The fastest path to using these tools well is knowing where they break."
- "I'm not anti-tool. Understanding the failure modes is the prerequisite for using them safely."
- "I'm not anti-AI. The point is knowing the trade-offs before they bite."
- "Studying failure modes is how we get to using AI well. The alternative is shipping blind."
- "Not anti-AI. Knowing the failure modes is what makes safe use possible."

This pattern is wired into `.claude/skills/evergreen-posting/SKILL.md` under "LinkedIn caveat on AI-skeptical posts".

Related: [[feedback-ai-failure-quiz-framing]]
