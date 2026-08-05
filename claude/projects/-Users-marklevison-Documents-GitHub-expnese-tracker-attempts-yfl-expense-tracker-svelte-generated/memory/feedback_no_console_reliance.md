---
name: feedback-no-console-reliance
description: "Never rely on browser console output for user-facing information; it's only for developer debugging"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 3a5ef64f-3c41-4eaf-8237-bd97b6e51f83
---

Never rely on the browser console (console.log/warn/error) to surface information the user needs to act on. Console output is acceptable only as a developer debugging aid.

**Why:** Real users don't open DevTools. If a failure, file name, or actionable detail only appears in the console, it's effectively invisible. The user has flagged this as a recurring concern.

**How to apply:** Every error path, failed import, validation issue, or piece of information a user might need must be surfaced in the UI (error banner, toast, modal, inline message). `console.error` calls can stay for debugging, but the UI must independently contain everything the user needs — never write code that depends on the user reading the console.
