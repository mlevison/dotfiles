---
name: feedback_code_style_returns
description: "User's TypeScript style preferences — guard clauses good, union return types bad, forced null checks tolerated"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 420324bb-e1eb-4c7e-8df3-2030169362dd
---

User's TypeScript/code-style preferences (stated during a refactoring-catalog grilling session):

- **Guard clauses / early returns are favoured.** Multiple `return` statements per method are fine and preferred when they flatten nesting. Do NOT impose a single-exit-point rule.
- **Heterogeneous union return types are a smell to avoid** — e.g. `method(): string | number | object`. These force the caller to type-discriminate. Treat as high-priority violations; suggest discriminated unions, Result types, or value objects. Discriminated-union returns done *well* are good (e.g. `validateFile(): { ok: true } | { ok: false; message: string }`).
- **`any` is a smell wherever a more precise type is possible.** Prefer `catch (e: unknown)` + narrowing over `catch (e: any)`; typed row interfaces over `(row: any)`; typed DTOs over `data: any`. Only leave `any` when the upstream library genuinely provides no usable type — and say so explicitly at that site.
- **Forced-upstream null checks (`T | null`) are tolerated but disliked.** Flag them at lower priority — sometimes Supabase/Mistral/storage providers force nullable returns on us, so not every one is worth changing.

**Why:** User initially phrased this as "avoids multiple returns per method," which literally reads as single-exit; on grilling they clarified they meant union *return types*, and separately that they *favour* guard clauses. Easy to get backwards.

**How to apply:** When proposing refactors, prefer guard clauses; never flag early returns as a problem; do flag `any`/heterogeneous union returns; flag `T | null` returns only as secondary. Relates to [[feedback_no_any_in_tests]].