---
name: ocr-and-upload-resilience
description: The upload pipeline must survive Mistral (or other external OCR/AI service) outages and partial failures without losing user data. Failed uploads must be retryable and must not produce orphan storage files.
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7aa8c301-f496-4e9b-8aa9-d969ea401fa5
---

The receipt-upload pipeline must remain robust when Mistral OCR (or any other external dependency — exchange-rate API, Resend, etc.) is unavailable, rate-limited, or returns garbage. Specifically:

- A failed OCR call must NOT block the upload — save the receipt with `null` OCR fields, surface a retry path in the UI, and let the user re-trigger OCR later.
- An OCR failure during a batch upload must NOT abort the batch — each file's pipeline runs independently and surfaces its own success/failure.
- Storage uploads and DB inserts must be coupled: if the DB insert fails (for any reason — RLS, schema, validation, downstream service crash), the just-uploaded storage object must be cleaned up automatically, or a background reconciler must catch and either re-link or delete it. Today there is no such reconciler — orphans accumulate silently.
- Transient errors (rate limits, 5xx, timeouts) must be retried with exponential backoff before being treated as fatal.
- The UI must report per-file outcomes for batch uploads ("3 of 8 succeeded, here are the 5 that failed and why"), not a single failed/succeeded summary.

**Why:** Confirmed by a 2026-06-07 incident — a malformed currency value from OCR crashed `Intl.NumberFormat` at render time, which killed the page mid-batch. Four files reached storage with no DB row, requiring a one-off CLI reconciliation script and manual matching to identify which originals to re-upload. The user's data was not at risk but recovery was painful.

**How to apply:**
- For any new upload/import path, ask: "what happens if Mistral times out on file 5 of 20?" and "what cleans up storage if the insert fails?"
- For any new render-time formatter (currency, date, etc.), validate input or fail soft to a fallback — never let it throw and break the page.
- Treat orphan storage files as a first-class concern: either prevent them (transactional upload+insert) or detect them (background sweep, audit query).
- The `scripts/upload-audit.mjs` helper exists as a tactical fallback — it's not a substitute for prevention.

Related: [[feedback_no_confirm_for_reversible]], [[feedback_no_console_reliance]]
