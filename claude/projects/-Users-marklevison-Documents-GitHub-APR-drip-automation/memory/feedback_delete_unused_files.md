---
name: Delete unused files
description: User prefers deleting unused files over keeping them as dead code or legacy reference.
type: feedback
originSessionId: c9bce4a3-0cfc-4cd8-a05e-0c6c052367c4
---
Delete unused files rather than leaving them with comments like "kept for reference" or "legacy".

**Why:** User explicitly said "if the files aren't used they should be deleted."

**How to apply:** When migrating away from a dependency or approach, delete the old files once the new code is working. Don't keep deprecated wrappers, unused templates, or dead code.
