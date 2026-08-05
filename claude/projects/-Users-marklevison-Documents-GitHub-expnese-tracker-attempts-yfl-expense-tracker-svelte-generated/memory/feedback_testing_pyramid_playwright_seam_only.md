---
name: feedback_testing_pyramid_playwright_seam_only
description: Testing philosophy — unit tests own correctness; Playwright only proves the UI is wired to the tested logic
metadata: 
  node_type: memory
  type: feedback
  originSessionId: e3e16c2f-8dd9-4ed5-a60a-9208f5bc87c0
---

Mark's rule for GUIs: **all the real testing is at the unit level; Playwright/e2e
exists only to prove the UI is attached to the well-tested pieces** — a thin seam
check, not a place to re-test business logic or boundaries.

**Why:** Stated directly during RF-02. It sets the altitude for every UI test
decision: don't push logic coverage into slow, flaky browser tests.

**How to apply:**
- Put correctness (filtering, validation, date math, param building) in pure
  node-unit tests (see [[feedback_validate_characterization_tests_with_oracle]]).
- For each UI feature, add at most ONE thin Playwright flow proving the wiring:
  control → state → action → URL/DOM result (and reset). No boundary/edge matrices
  in Playwright — those live in unit tests.
- Treat "unit logic wearing a Playwright costume" as a smell. This repo's
  `e2e/date-filter-url-preservation.spec.ts` never opens a browser (pure
  URLSearchParams asserts) — that is fake e2e and should be replaced by a real
  seam test, not kept.
- Harness reality (as of RF-02): there is NO working authenticated browser e2e —
  no globalSetup/storageState/auth fixture/seeding; the only real e2e is
  `demo.test.ts` (unauth home h1); the `tests/*.spec.ts` Playwright files are
  orphaned (outside `testDir: 'e2e'`, no auth) and never run. Adding a real seam
  test needs an auth+data harness first; prefer `page.route()` mocking of the
  Supabase REST/auth calls (we don't test the backend) over a live test project.
