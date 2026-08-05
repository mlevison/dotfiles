---
name: project_weak_unit_tests_source_introspection
description: "Many .spec.ts files in this repo are source-introspection or inline-reimplementation, not behavioral tests — don't over-trust green checks"
metadata: 
  node_type: memory
  type: project
  originSessionId: cf0f4f30-6f45-40d9-a753-44e02e3df1aa
---

Discovered during the 2026-07-08 full spec-audit (40 `specs/specifications/*.md`
files, 6 parallel agents, before deleting `specs/`): a large share of this repo's
`.spec.ts`/`.test.ts` files that *look* like unit tests are one of two weaker
patterns instead of real behavioral tests:

1. **Source-introspection** — `readFileSync('+page.svelte')` + `toContain`/`toMatch`
   against the raw source text (e.g. asserting a string like `uploading = true`
   appears somewhere in the file). These prove a string is present, not that the
   behavior works. They also make refactors look like regressions even when
   behavior is preserved — see [[project_a11y_label_and_prettier_shorthand]] for
   the Prettier-shorthand case, and this session's `receipts-page.spec.ts` upr2a
   block, which broke on the `batchUpload.ts` extraction and had to be rewritten
   to assert the delegation instead of the old inline loop.
2. **Inline re-implementation** — the test hand-rewrites the logic under test
   inline (e.g. `let zoom = 100; zoom += 50; expect(zoom).toBe(150)`) rather than
   importing and exercising the real function/component state. Notable example:
   `src/lib/components/ReceiptImageViewer.spec.ts` (~120 tests) re-implements the
   zoom/pan arithmetic inline instead of driving the component — near-zero
   regression protection despite the large test count.

**Why this matters:** a high test count or a green run in these files is not
evidence the underlying behavior is correct or would catch a regression. Page-level
`*-page.spec.ts` files under `src/lib/tests/` are frequently source-introspection;
component specs can be either pattern.

**How to apply:**
- Before trusting "it's covered" for a page/component behavior, open the test and
  check whether it imports/exercises real code vs. grepping source text or
  re-deriving the arithmetic locally.
- When extracting logic out of a `.svelte` file into a util (as with
  `batchUpload.ts`, `profileEmails.ts`), expect co-located source-introspection
  tests to break on the extraction even though behavior is unchanged — that's a
  known false-positive category, not a sign the refactor broke something. Rewrite
  those assertions to check delegation/wiring, not the old inline pattern.
- Not treated as a fillable "missing unit test" gap by itself — the fix is a test
  refactor (import real code) or component-state extraction, not new coverage.
  `ReceiptImageViewer.spec.ts` was flagged but left as-is; only worth revisiting if
  that component is refactored to extract a pure state module.
- Relates to [[feedback_testing_pyramid_playwright_seam_only]] (Playwright is
  deliberately thin) — this is the mirror problem at the *unit* level: tests that
  look thorough but aren't actually behavioral.
