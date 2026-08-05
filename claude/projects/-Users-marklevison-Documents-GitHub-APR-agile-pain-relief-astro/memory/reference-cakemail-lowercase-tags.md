---
name: Cakemail normalizes all tags to lowercase on storage
description: Tag values POSTed to Cakemail in CamelCase come back lowercased; any code that queries or compares tags must normalize both sides
type: reference
originSessionId: 4cae9dff-8cc3-4809-b516-5ad52009ea7a
---
**Cakemail stores and displays every tag in lowercase**, regardless of the case it was submitted in. A `POST /lists/{id}/contacts/{contactId}/tag` with body `{ "tags": ["SignupNewsletterForm"] }` results in a stored tag of `signupnewsletterform`. Queries, the Cakemail UI, and API responses all use the lowercased form.

**Implications for APR code:**

- **Writing is safe.** Our source code uses CamelCase (`SignupNewsletterForm`, `FromCSM`, `InterestAI`) for readability. Cakemail normalizes on storage so this costs nothing.
- **Comparisons must be case-insensitive.** Any code that reads tags back from Cakemail and compares them against a keep-list, mapping, or expected-tag set MUST lowercase both sides before the check. Direct `===` against the CamelCase source value will fail.
- **Segments and filter queries** defined in the Cakemail UI or API need the lowercased form (e.g., `has tag signupnewsletterform`, not `SignupNewsletterForm`).

**Where this will bite next:**

- Step 2 of the Drip migration (`email-automation/src/migrate-drip-to-cakemail.ts`) if it verifies tags on already-migrated contacts — lowercase both sides.
- Any future segmentation / reporting code that filters contacts by tag.
- The planned post-course alumni-tag application in `/api/newsletter-signup.ts` (Step 6b) when it reads `Course Students` tags to mirror them on `Newsletter Subscribers`.

**Where this does NOT bite:**

- Tag writes (`POST .../tag`) — case irrelevant, normalization handled server-side.
- Internal TypeScript type unions (`SubmissionType`, `TopicHint`) — these are app-internal identifiers, never compared to Cakemail-returned strings.
