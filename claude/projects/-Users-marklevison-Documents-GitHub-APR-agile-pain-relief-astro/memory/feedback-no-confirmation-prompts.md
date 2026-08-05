---
name: feedback-no-confirmation-prompts
description: "Don't add type-\"yes\" confirmation prompts to CLI scripts; running the command IS the intent"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: b8f34569-a821-4aba-a1a5-86a7c9c90fe7
---

Don't build interactive "type yes to confirm" prompts into CLI scripts. If Mark runs the command, he means it to happen.

**Why:** he runs the business solo and the prompts are friction, not safety. The act of running the script (and any explicit flag like `--send`) is already the deliberate intent signal.

**How to apply:** gate destructive/outward actions behind an explicit flag (e.g. `--send` vs a default dry run), not behind a runtime prompt. Keep a default-safe mode (dry run / preview) so an accidental bare invocation does nothing, but once the flag is passed, execute without asking. Removed the `confirm()` gate from `send-refresher.ts` for this reason. Distinct from [[feedback-no-git-checkin.md]] (that's about not committing on his behalf at all).
