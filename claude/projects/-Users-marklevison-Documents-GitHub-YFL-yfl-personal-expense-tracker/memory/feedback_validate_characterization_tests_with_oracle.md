---
name: feedback_validate_characterization_tests_with_oracle
description: "For extract-refactors, validate hand-authored test expectations by running the original code as an oracle before trusting them"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: e3e16c2f-8dd9-4ed5-a60a-9208f5bc87c0
---

When writing characterization tests for code that isn't yet callable in isolation
(e.g. an extract-refactor where the logic is still inline in a Svelte page), do NOT
trust hand-authored expected values derived from *reading* the source. Reading is
fallible — a mis-transcribed `<`/`<=` or null guard produces tests that go green
against your own mistake.

**Why:** Mark challenged this on RF-02 ("how do we know the tests are correct if we
can't run them against the existing code?"). A characterization test is only
trustworthy if its expected values come from *observing* the real system.

**How to apply:** Build a throwaway oracle harness: lift the current logic VERBATIM
(cite file:line) into local functions, reuse any already-callable real helpers
(e.g. `getValidDate`), feed the exact inputs your spec uses, and assert the oracle
reproduces your spec's expected values. Run it across relevant conditions (e.g.
`TZ=UTC`, `TZ=Pacific/Kiritimati`, `TZ=Etc/GMT+12` for date math). Green = your
expectations faithfully characterize current behavior. A divergence either fixes
your test OR reveals the current code is itself buggy (on RF-02 the transactions
`new Date(to+'T12:00:00').toISOString()` boundary drifts a day at UTC±12+ — the spec
then pins the *correct* value and the extraction must be TZ-safe). Delete the oracle
once it has done its job. Relates to [[feedback_fix_warnings_in_touched_files]].
