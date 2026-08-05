---
name: feedback-social-draft-location
description: "Draft social posts go in the Obsidian vault at APR/Efforts/Social Media/ with a filename ending in -drafts, never in the APR repo"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 82b810dc-71f7-4ce9-ba13-18de411cbf3f
---

When creating a draft batch of social posts for Mark, write the working draft to the Obsidian vault at `APR/Efforts/Social Media/` and end the filename with `-drafts` (e.g. `next-few-days-drafts.md`).

**Why:** Mark keeps post drafts in his vault PKM, not scattered in the APR astro repo. (2026-06-14 he had me move `next-few-days-draft.md` out of `agile-pain-relief-astro/social-media-planning/` into the vault.)

**How to apply:** The human-edited *draft* (markdown) lives in the vault folder above. The machine-consumed *batch JSON* still goes to the APR repo at `analytics/social-media-content-evergreen/next-few-days.json` (the pipeline's drain file) when the draft is finalized. So: drafts in the vault, pipeline JSON in the repo. Reinforces [[feedback_no_unsolicited_files]] (don't drop scratch files into the APR repos).
