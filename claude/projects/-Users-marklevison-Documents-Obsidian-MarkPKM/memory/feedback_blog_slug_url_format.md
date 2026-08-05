---
name: feedback_blog_slug_url_format
description: "Blog slugs/paths must always use the APR blog URL format, derived by convention, never left as TBD"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 92de31d8-b606-46b8-8fdd-9476ed207821
---

When recording a blog post's slug or path (in the content-work-plan, social calendar, or anywhere), always write it in the APR blog URL format `/blog/<slug>/` (or full `https://agilepainrelief.com/blog/<slug>/` in the social calendar). Do not hedge with "TBD" or "projected" even for unpublished drafts.

Slug convention, derived from the title: lowercase, spaces to hyphens, drop any trailing parenthetical, apostrophes become `-`, "ScrumMaster" becomes "scrum-master". Example: "Why AI Doesn't Replace Your ScrumMaster (and probably never will)" -> `why-ai-doesn-t-replace-your-scrum-master`. So "GenAI Won't Speed Up Your Scrum Events (and Shouldn't)" -> `genai-won-t-speed-up-your-scrum-events`.

**Why:** The slug is deterministic from the title, so there's no need to leave it unresolved; a real path is more useful in planning/calendar docs.

**How to apply:** Derive the slug from the title using the convention above and write the full `/blog/<slug>/` path. Cross-check against an existing post's folder name in `src/content/blog/` when unsure. Related: [[apr_analytics_architecture]], [[feedback_no_unsolicited_files]].
