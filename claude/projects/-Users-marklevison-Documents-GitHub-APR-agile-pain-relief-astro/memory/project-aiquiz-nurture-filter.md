---
name: aiquiz-nurture-filter
description: "AI audience consolidated onto Newsletter Subscribers + `aiquiz` tag (2026-06-02). Nurture triggers on the tag, not list membership. Cakemail forms CAN apply tags."
metadata: 
  node_type: memory
  type: project
  originSessionId: ba7b8537-9c3d-43e2-8acf-94656ab50902
---

**Current state (2026-06-02).** The AI audience (quiz takers + AI Failure Modes direct-download + the "Keep Me Posted" card) all subscribe to the general **Newsletter Subscribers** list (double opt-in) and are tagged **`aiquiz`** (quiz takers also get a result-tier tag `aiquiz-{level}`). The ai-welcome nurture triggers on the `aiquiz` tag, NOT on list membership. Cakemail lowercases tags — see [[reference-cakemail-lowercase-tags]].

The dedicated `AI Quiz Subscribers` list was retired. Tags are applied by the **client-side POST itself** (`tags[aiquiz]=true`; Cakemail wants tags as a dict), so no dedicated quiz form is needed — every AI entry point reuses the shared Newsletter Subscribers form (`07857823…`, constant `AI_SIGNUP_FORM_URL`; quiz frontmatter `cakemailFormUrl`).

**Cakemail forms CAN apply tags.** This contradicts the earlier repo-wide assumption ("forms can't apply tags directly"). Verified 2026-06-02: POSTing `tags[<name>]=true` (dict shape) to a `form_submission/<hash>` endpoint applies the tag (a bare `tags=string` 422s). This also unblocks the deferred newsletter source/topic attribution — gate it on [[feedback-action-litmus]].

**Why the merge (the old "consent separation" rationale was wrong).** The prior design kept a separate list on the stated grounds that quiz takers "only consented to see results, not the newsletter." That rationale was AI-generated and contradicted by the quiz's own capture copy, which tells users they are subscribing to the list. With consent identical across entry points, list-vs-tag is a mechanism choice, not a consent boundary — so one list + tag is simpler and correct. See [[feedback-no-redirects-ephemeral-pages]] for the related cleanup pattern (retired `/quiz-confirmed/` with no redirect; one shared `/newsletter-confirmed/` DOI page).

**How to apply.** AI nurture trigger = "Contact tagged `aiquiz`". The pre-DOI tag concern is moot: trigger on the tag and rely on Cakemail's DOI to gate activation. If adding a new AI entry point, POST to the shared Newsletter form and append `tags[aiquiz]=true`.
