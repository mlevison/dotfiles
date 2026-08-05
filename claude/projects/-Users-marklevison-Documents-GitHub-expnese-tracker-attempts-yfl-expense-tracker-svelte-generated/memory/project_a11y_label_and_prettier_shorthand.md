---
name: project_a11y_label_and_prettier_shorthand
description: "How to fix a11y label warnings in this repo, and the Prettier-shorthand-vs-tests gotcha"
metadata: 
  node_type: memory
  type: project
  originSessionId: 72603bfa-78ce-4033-8b8e-ae532758c04a
---

Fixing `a11y_label_has_associated_control` in this SvelteKit app — apply by case:

- **Native input/select/textarea** → explicit `for`/`id` (static descriptive ids,
  forms render once per page so no `$props.id()` needed).
- **flowbite `<Datepicker>` and custom components (e.g. `CategoryDropdown`)** → **wrap**
  the control inside the `<label>`. `for`/`id` can't reach the control because
  flowbite's `Datepicker` does NOT forward `id`/rest props to its inner `<input>`.
  svelte-check accepts a `<label>` wrapping a component.
- **Display-only captions** that label no editable control (profile Primary Email /
  User ID / Account Created; ReceiptEditModal "Receipt Image") → convert `<label>` to
  `<span>`. They were false-positive labels.

`state_referenced_locally` for an intentional "seed local `$state` from a prop/derived
once" pattern: wrap the read in `untrack(() => ...)` (import from `svelte`), or seed
from the underlying source (e.g. URL params) instead of the `$derived`.

**`$state` typing gotcha:** `let x: T | null = $state(null)` can make svelte-check
resolve the annotated type to `never` (property access then errors as "does not exist
on type 'never'"). Use the idiomatic `let x = $state<T | null>(null)` instead. Seen in
profile/reconciliation. Also: flowbite `<Datepicker>` `onselect` passes a `DateOrRange`
(`Date | { from?; to? }`) — narrow it with `dateOrRangeToDate()` from
`$lib/utils/dateConversion` before `toISODateString()`. Async `onMount` callbacks can't
return a cleanup; subscribe synchronously + run async load in a `void (async () => …)()`
IIFE + return a sync teardown.

**Prettier gotcha:** this repo's Prettier enforces Svelte attribute **shorthand**
(`categories={categories}` → `{categories}`; no `svelteAllowShorthand:false`). Running
`npm run format` can rewrite props and **break source-regex unit tests** that assert
`/prop\s*=\s*\{/`. Fix the test regex to accept both forms, not the formatting. Note
the committed tree is already Prettier- and ESLint-dirty in places, and `npm run check`
has ~146 pre-existing TS errors — see `.scratch/check-cleanup/` for the cleanup plan.
