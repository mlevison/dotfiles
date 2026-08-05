---
name: reference-component-test-harness
description: How to write Svelte component render tests in this repo (browser vitest project + naming gotcha)
metadata: 
  node_type: memory
  type: reference
  originSessionId: 989a31a1-4b2a-4f7d-a78c-cc7cb03f9ea4
---

Svelte component **render** tests run in the `client` vitest project
(`environment: 'browser'`, `provider: 'playwright'`, chromium) configured in
`vite.config.ts` under `test.projects`. Use `render` from `vitest-browser-svelte`,
locators from the returned queries (`getByRole`/`getByText`), and retriable
`await expect.element(...).toBeVisible()`.

**Naming gotcha (load-bearing):** the browser project only includes
`src/**/*.svelte.{test,spec}.{js,ts}`. A render test MUST be named
`Foo.svelte.spec.ts` — a plain `Foo.spec.ts` runs in the Node `server` project
instead, where `render`/DOM aren't available. Most existing `*.spec.ts` files
next to components (e.g. `CategoryDropdown.spec.ts`) are node-side
**source-introspection** tests (`readFileSync` + `content.includes`), not render
tests — don't confuse the two.

First real render test / working example: `src/lib/components/FilteredEmptyState.svelte.spec.ts`.
More involved example (sort/selection wiring via a `*Fixture.svelte` that supplies
snippet props): `DataTable.svelte.spec.ts` + `DataTableFixture.svelte`.
Run a single one with `npx vitest run --project client <path>`. Relates to
[[feedback-testing-pyramid-playwright-seam-only]] — these component tests are the
unit-level net for extracted UI (RF-03), distinct from the Playwright seam layer.

**Two Svelte-5 gotchas that cost real time (both cases where the test lied, not the code):**
1. `getByRole('button', { name })` matches the name as a **substring**, and a
   `<tr role="button">` exposes an accessible name aggregated from its cells
   (e.g. "Beta 20 Act"). So `getByRole('button', { name: 'Act' })` also matches the
   row, and `.first()` clicked the row, not the button. Use `{ exact: true }` or
   scope the query.
2. Row-click-to-open should be wired as **cell-level `onclick`** on each
   non-interactive `<td>`, NOT `<tr onclick>` + `stopPropagation`/`event.target`
   guard. Under Svelte 5 event delegation, `stopPropagation` in a cell doesn't
   reliably stop the row handler and `event.target.closest(...)` guards misfire.
   The pure JS `element.click()` fires handlers even when the vitest-browser locator
   is targeting the wrong element — handy for isolating "is the handler wired?" from
   "is the locator right?".
3. Controlled `<input type="checkbox" checked={state}>` + `event.preventDefault()` in
   its click handler DESYNCS the box: the browser's canceled-activation reverts
   `checked` after Svelte set it, so state updates but the box looks unchecked. Fix:
   don't preventDefault — let it toggle, then force `event.currentTarget.checked` to
   match state (state wins; a Shift-range can leave the clicked row's own value
   unchanged, which Svelte's one-way `checked` won't re-assert on its own). Assert the
   real thing with `toBeChecked()` — asserting only the derived state text hides this.
