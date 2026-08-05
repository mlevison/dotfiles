---
name: feedback_no_mistral_in_tests
description: Unit tests must never call the Mistral OCR API; keep extraction logic pure/mocked
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d2368727-8674-4045-90a8-69535638ca2f
---

Unit tests must not run against Mistral (the pixtral-12b OCR API). Tests must never trigger a real model call.

**Why:** Mistral calls are slow, costly, non-deterministic, and require an API key — unsuitable for unit tests.

**How to apply:**
- Test OCR-prompt changes by asserting on the exported prompt **string constant** (e.g. `receiptPrompt` in `OcrService.ts`), never by calling `extractFromUrl()`.
- Keep date/format logic in pure functions (`src/lib/utils/receiptDateCorrection.ts`) so it is testable without the model.
- In `ReceiptService` integration tests, mock `fetch` (the `/api/ocr/extract` call) and mock the OCR extract result.
- The Mistral client is created lazily inside `OcrService.initClient()`; importing the module is safe, but never invoke extraction paths in tests.

Related: [[feedback_no_console_reliance]]
