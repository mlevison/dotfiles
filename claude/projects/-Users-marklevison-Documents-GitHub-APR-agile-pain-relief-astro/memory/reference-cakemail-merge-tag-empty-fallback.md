---
name: reference-cakemail-merge-tag-empty-fallback
description: "Cakemail merge tags — empty fallback [firstname,] breaks and renders literally; use [firstname] for no fallback"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 5568eb35-460e-4143-ae38-6f40c3c6875b
---

Cakemail merge-tag syntax: `[field,fallback]` (e.g. `[firstname,there]`). The
fallback after the comma must be a **non-empty word**.

- `[firstname,]` (comma + empty fallback) is INVALID — Cakemail fails to parse
  it and emits the tag **literally** in the sent email. This caused a whole-list
  send on 2026-06-26 where everyone saw `Hi [firstname,],`.
- For **no fallback**, use `[firstname]` with NO comma. A valid tag with no
  value renders blank.
- Caveat: `Hi [firstname],` with no value → `Hi ,` (dangling comma). `Hi [firstname]`
  → `Hi` (clean, no comma). Pick per cosmetics; both are valid.

**Now code-enforced for newsletters.** As of 2026-06-27, authors must NOT write
a greeting in `email-automation/newsletters/*.md`. `send-newsletter.ts` owns it:
`GREETING = "Hi [firstname],"` is prepended by `withGreeting()`, which also
strips any author-typed leading line containing `firstname` (so a mistyped tag
can't ship). Unsubscribe + postal footer are likewise code-owned via
`default_unsubscribe_link: true` in `createCampaign` — never add either by hand.

Related: [[reference-cakemail-lowercase-tags]],
[[project-newsletter-double-send-guard]].
