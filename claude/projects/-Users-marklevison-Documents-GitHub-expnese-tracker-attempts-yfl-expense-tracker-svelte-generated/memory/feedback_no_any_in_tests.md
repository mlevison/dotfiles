---
name: no-any-even-in-tests
description: "Avoid `any` and `as any` everywhere — including test files. Reach for stronger types (typed mocks, `Partial<X>`, `MockedFunction`, narrow interface shapes) before falling back to `any`. The existing test files use `as any` heavily; that's debt, not the convention."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7aa8c301-f496-4e9b-8aa9-d969ea401fa5
---

Prefer stronger types over `any` in every file — production code AND tests. `any` and `as any` should be a last resort with a comment explaining why, not a default reflex when mocking.

**Why:** ESLint already flags `@typescript-eslint/no-explicit-any` in this project. Test files have accumulated a lot of `as any` casts (mocking Supabase chains, casting `globalThis.fetch`, typing helper locals) and that has become an unspoken convention — but it's debt, not a style choice. Strong types in tests catch refactor breakage early; `as any` silently rots when the real signatures change.

**How to apply:**

For mocked functions, use vitest's typed helpers:
```ts
// Avoid
const mockUpload: any = vi.fn().mockResolvedValue({ error: null });

// Prefer
import type { MockedFunction } from 'vitest';
const mockUpload = vi.fn<(path: string, file: File) => Promise<{ error: Error | null }>>()
    .mockResolvedValue({ error: null });
```

For partial mock objects, use `Partial<X>` (or a narrower local interface) instead of `as any`:
```ts
// Avoid
(supabase.from as any) = vi.fn().mockReturnValue({ insert: mockInsert });

// Prefer
const fromMock: Partial<typeof supabase.from> = vi.fn().mockReturnValue({ insert: mockInsert });
// or define a minimal shape:
type FromMock = (table: string) => { insert: typeof mockInsert };
```

For helper-function locals, declare proper types:
```ts
// Avoid
async function runWithRetries(file: File): Promise<{ value?: any; error?: any }> { ... }

// Prefer
async function runWithRetries<T>(file: File): Promise<{ value?: T; error?: Error }> { ... }
```

For destructured callback args (`(args: any[]) => ...`), declare the actual tuple shape:
```ts
// Avoid
.filter((args: any[]) => args[0] === 'orphan_storage_cleanup_failed')

// Prefer
.filter((args: unknown[]) => args[0] === 'orphan_storage_cleanup_failed')
// or with a tuple type if the shape is known
```

When `any` is genuinely the right call (e.g. exotic chained mocks where typing is more work than the test is worth), add a comment naming the reason:
```ts
// eslint-disable-next-line @typescript-eslint/no-explicit-any -- Supabase fluent chain is impractical to type for this mock
const mockFrom: any = vi.fn().mockReturnValue({ ... });
```

**Boy-scout rule:** don't refactor the entire ~50 existing `as any` instances in one go, but when you touch a test, tighten the types you can see. Don't add new `as any` unless you've explored typed alternatives first.

**For Supabase fluent chains specifically:** look at extracting a small typed helper that returns a mock client conforming to the parts of `SupabaseClient` actually used in the test, rather than re-typing the chain inline at every call site.

Related: [[feedback_no_console_reliance]], [[feedback_no_mistral_in_tests]] — same principle: tests should be load-bearing, not throwaway.
