---
name: feedback-no-redirects-ephemeral-pages
description: Skip redirects when retiring noIndex pages or pages that only lived a week or two
metadata: 
  node_type: memory
  type: feedback
  originSessionId: ba7b8537-9c3d-43e2-8acf-94656ab50902
---

Do not add a redirect when retiring or renaming a `noIndex` page, or a page that only lived for a short time (a week or so). Decided 2026-06-02 when retiring `/quiz-confirmed/` (which was being superseded by `/newsletter-confirmed/`).

**Why:** Redirects exist to preserve inbound links and accumulated search equity. A `noIndex` page was never in the search index, and a page alive only days/weeks has accumulated neither external links nor rankings. A redirect for it is pure maintenance overhead with nothing to preserve. Consistent with [[feedback-action-litmus]].

**How to apply:** When retiring/renaming a page, ask first: was it indexable, and was it alive long enough to accrue links/rankings? If no to either, just delete it, no redirect. This is now also documented in the CLAUDE.md Redirects section.
