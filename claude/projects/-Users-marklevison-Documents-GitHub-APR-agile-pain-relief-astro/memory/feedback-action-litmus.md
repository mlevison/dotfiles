---
name: "What action would we take?" litmus test
description: Mark's decision heuristic for whether marketing tags, data, or tracking is worth keeping — if no concrete action would be taken on a segment, drop it
type: feedback
originSessionId: 4cae9dff-8cc3-4809-b516-5ad52009ea7a
---
When proposing to keep tags, metadata, or tracked segments in marketing systems (Drip, Cakemail, analytics), Mark evaluates them with the question **"What action would we take on any of these?"** If the answer is "none" or "we'd never actually send a campaign to this slice," the tag/segment is dead weight and drops.

**Why:** Mark runs the business alone ("Too much work for one person"). Every piece of data that survives a migration or lives in an active system imposes ongoing maintenance cost. He prefers a ruthless cull over hoarding data "just in case" — the ongoing cost of a tag exceeds its speculative future value unless there's a concrete campaign or segment already in mind.

**How to apply:**
- Before suggesting to keep a tag, segment, custom attribute, or tracking signal, ask: what specific send / automation / segment would use this? If you can't name one, propose to drop.
- Signals that survive the test: tags gated by explicit opt-in/opt-out (e.g., `InterestLeanCoffee`, `SuppressRefresherCSM`), alumni markers that feed post-course offerings, signup-source tags that distinguish lead-magnet cohorts we might re-engage.
- Signals that fail: feedback/review markers (`Submitted - Google Review`, `Submitted - Feedback - CSM`) that are manually maintained; historical import cohorts duplicative of a cohort flag already in place; email-series enrolments for nurture automations that aren't being ported; workflow-goal automation internals.
- A related pattern: Mark prefers one unified tag to many granular variants unless each variant drives a distinct action (e.g., one `InterestLeanCoffee` that unions four Drip tags, because there's only ever one Lean Coffee send).
