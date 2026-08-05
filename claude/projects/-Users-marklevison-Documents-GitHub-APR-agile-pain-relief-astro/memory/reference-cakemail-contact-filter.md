---
name: Cakemail contact lookup filter syntax
description: Cakemail's /lists/{id}/contacts endpoint silently ignores ?email= and requires ?filter=email==<value> for email lookup
type: reference
originSessionId: fcda1bb9-b716-4133-bf72-563dbed5294f
---
Cakemail's `GET /lists/{list_id}/contacts` endpoint silently ignores a bare
`?email=<value>` query parameter and returns the whole list (paginated).
Empirically confirmed 2026-04-23 on list 9402690 — `?email=bogus@nowhere.invalid`
returned 2 items (the full list contents), not 0.

**Correct syntax:** `?filter=email==<value>` (URL-encode the whole filter value).

Shared across any code that looks up a contact by email on a list:
- `src/cakemail-client.ts` `getContact`, `getContactOnList`
- `src/cakemail-client.ts` `enrollInPostCourseCSM` fallback lookup

If a lookup is reporting "already exists" for contacts that clearly aren't on
the list, suspect this first. A wrongly-empty filter silently breaks dedup
and idempotent importers — it fails *invisibly* (every lookup succeeds with
the wrong contact) rather than loudly.
