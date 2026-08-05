---
name: reference_app_state_page_in_derived
description: "For URL-backed page state that must survive Back/refresh, read it in a +page.ts load, not a client-side $derived off the page store"
metadata: 
  node_type: memory
  type: reference
  originSessionId: c5bbfa7b-b74f-412a-8f4c-ac216182af79
---

For page state that is **backed by the URL** (query params) and must survive a
browser **Back**, a refresh, and same-route navigation, read it in a **`+page.ts`
`load`** and consume `data.x` — do NOT derive it client-side from the page store.

```ts
// +page.ts
export const load: PageLoad = ({ url }) => ({ year: parseYearParam(url.searchParams, new Date().getFullYear()) });
```
```svelte
let { data }: { data: PageData } = $props();
let year = $derived(data.year);
function changeYear(d) { goto(resolve(`/spending?year=${year + d}`), { replaceState: true, keepFocus: true, noScroll: true }); }
```

**Why:** `load` re-runs with the correct `url` on every navigation (arrows via
`goto`, Back, refresh), so `data.year` is always in lock-step with `?year=`.
Changing the URL for the arrows must use **`goto`** (re-runs `load`), NOT
`replaceState` (shallow routing — doesn't re-run `load`, so the arrows looked
inert).

**What failed in `/spending` (don't retry these):**
1. Read the URL once in `onMount` → raced the initial render.
2. `$derived(readDateFilter($page.url.searchParams))` off the **`$app/stores`
   `$page` store** → stale year after Back.
3. `$derived(... page.url ...)` off the **`$app/state` reactive `page`** PLUS
   `replaceState`-driven arrows → STILL stale on Back, and the arrows didn't
   navigate. So `$app/state` alone is not a reliable fix for the Back case here.

Only the `load` approach held up. See docs/plans/2026-07-09-spending-report-design.md.

**Latent risk:** `src/routes/expenses/+page.svelte` still derives its date filter
from `$app/stores` `$page` in `$derived` — same class of bug, may go stale on
Back. Logged in the product backlog; convert to a `load` if it surfaces.
