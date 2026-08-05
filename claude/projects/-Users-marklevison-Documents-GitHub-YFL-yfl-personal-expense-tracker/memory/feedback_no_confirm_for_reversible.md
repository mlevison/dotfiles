---
name: no-confirm-for-reversible-actions
description: "Do not use confirm() prompts for reversible actions (exclude/include, match/unmatch, etc.). Keep confirms only for destructive ones (delete, bulk delete, irreversible overwrites)."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7aa8c301-f496-4e9b-8aa9-d969ea401fa5
---

Do not wrap reversible UI actions in a `confirm()` prompt. Reserve confirms for destructive or irreversible operations.

**Why:** Reversible actions like exclude/include a transaction or match/unmatch a receipt can be undone with a single click, so a modal confirmation just adds friction. The user explicitly contrasted the transactions page (no confirm on exclude — preferred) with the reconciliation page (had a confirm — removed).

**How to apply:**
- Skip `confirm()` for: toggling exclude/include, match/unmatch, archive/unarchive, soft-deletes that have a visible "include" or "restore" affordance, and any other one-click-reversible state change.
- Keep `confirm()` for: hard delete of a row, hard delete of a stored file (e.g. receipt image), bulk delete operations, and irreversible overwrites (e.g. batch image resize replacing originals).
- When adding a new action button, ask: "if the user clicks this by mistake, can they undo it with one click in the same UI?" If yes, no confirm.

Related: [[feedback_no_console_reliance]] — both reflect a preference for direct, frictionless UI behavior.
