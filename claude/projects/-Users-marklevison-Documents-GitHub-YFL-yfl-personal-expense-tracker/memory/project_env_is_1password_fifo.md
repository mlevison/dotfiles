---
name: project-env-is-1password-fifo
description: .env is a live 1Password FIFO; tooling injects fake public env so it runs without 1Password
metadata: 
  node_type: memory
  type: project
  originSessionId: 2ecceeb9-efef-42f4-b3c3-ea76419b4a71
---

The project root `.env` is a **1Password named pipe (FIFO)**, not a regular file
— it only yields values when the process is launched through 1Password's secret
injection. A bare `vite build` / `svelte-kit sync` (run without 1Password) sees
an empty `.env`, so `$env/static/public` (`PUBLIC_SUPABASE_URL`,
`PUBLIC_SUPABASE_ANON_KEY`) and `$env/static/private` (`MISTRAL_API_KEY`) are
absent → build fails and `svelte-check` reports "has no exported member".

**Do NOT `rm`/overwrite `.env`** (it's real, 1Password-managed) and don't treat
the FIFO as corruption.

Tooling is made self-sufficient by faking **public** values (never real secrets):

- `package.json` `check` / `check:watch` / `prepare` prefix `svelte-kit sync` with
  `PUBLIC_SUPABASE_URL=http://localhost:54321 PUBLIC_SUPABASE_ANON_KEY=test-anon-key MISTRAL_API_KEY=test`.
- `playwright.config.ts` `webServer.env` sets the two PUBLIC_ vars for the e2e build.

Don't strip those prefixes — they're what let `npm run check` / `npm run test:e2e`
run without 1Password. Real dev/build/deploy still use the real injected values.
Values are faked only for type-gen/seam builds; e2e is seam-only ([[feedback_testing_pyramid_playwright_seam_only]]).
