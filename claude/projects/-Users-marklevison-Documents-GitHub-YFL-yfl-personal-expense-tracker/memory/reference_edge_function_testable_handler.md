---
name: reference_edge_function_testable_handler
description: How the Resend edge function is unit-tested under vitest (functional-core/imperative-shell + esm.sh type-import trick)
metadata: 
  node_type: memory
  type: reference
  originSessionId: cfd5c2fa-9ba0-4594-bdc8-910a97bc0bb6
---

The Resend webhook edge function uses **functional core, imperative shell** so it
runs under vitest despite being Deno code:

- `supabase/functions/resend/handler.ts` — the testable core. Exports
  `handleResendWebhook(req, deps)` + `WebhookDeps`/`OcrPort`. All collaborators
  are injected via `deps`: `supabase`, `fetchFn`, `env`, `now`, `ocr`,
  `exchangeRate`, `verifySignature`. No svix, no `Deno.serve`, no global fetch/env.
- `supabase/functions/resend/index.ts` — the untested shell: builds real deps
  (createClient, svix `verifyWebhookSignature`, real Mistral OCR port, BoC rate)
  and passes them into `handleResendWebhook` inside `Deno.serve`.
- `handler.test.ts` — 20 vitest cases (branch matrix) with in-memory fakes.

Key trick: **`import type { SupabaseClient } from 'https://esm.sh/...'` is safe in
vitest** — esbuild strips type-only imports before resolution, so the URL is never
fetched at runtime, while `deno check` still resolves it. Value imports of esm.sh
URLs (svix, createClient) must stay in the shell only.

`notify.ts` / `mistral.ts` / `exchangeRate.ts` take optional `fetchFn`/`env` (and
notify a `now`) as trailing params, defaulting to the Deno runtime — backward
compatible so existing positional tests still pass.

Run: `npx vitest run --project server supabase/functions/` and, for Deno-type
drift, `cd supabase/functions/resend && deno check index.ts handler.ts`. The
`.test.ts` files fail `deno check` (vitest patterns) but are never in the deployed
graph — check the entry files, not `*.ts` wildcard.

Related: [[feedback_no_mistral_in_tests]], [[feedback_testing_pyramid_playwright_seam_only]]
