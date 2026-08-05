---
name: project-zed-mdx-tsdk-workaround
description: ".zed/settings.json pins mdx-analyzer's tsdk to this repo's TypeScript 5.8 as a workaround for srazzak/zed-mdx#21; delete it when that issue is fixed"
metadata: 
  node_type: memory
  type: project
  originSessionId: 2d4bf5d6-0ff9-4e15-b3c8-4e9274a7bff3
  modified: 2026-07-28T00:54:58.881Z
---

`.zed/settings.json` sets `lsp.mdx-analyzer.initialization_options.typescript.tsdk` to an absolute path into this repo's `node_modules/typescript/lib`. It is a workaround, not a preference, added 2026-07-27.

**Why:** The zed-mdx extension pins `typescript@7.0.2` in its own work dir (`~/Library/Application Support/Zed/extensions/work/mdx/package.json`). TypeScript 7 is the native Go port and ships no JS API, so its `lib/` contains only `getExePath.js` / `tsc.js`. mdx-analyzer is Volar-based and loads TypeScript **in-process as a JS library**, before it reads `typescript.enabled`, so it fails at initialize with "Can't find typescript.js or tsserverlibrary.js". Tracked upstream as https://github.com/srazzak/zed-mdx/issues/21 (open, no fix, extension last released 0.4.0 on 2026-05-10).

The Zed **tsgo** extension (`zed-extensions/tsgo`) does NOT fix this, though the similar-looking https://github.com/zed-industries/zed/issues/60618 recommends it. That issue is `typescript-language-server` failing on a workspace that is itself on TS 7; tsgo serves TypeScript/TSX/JS/JSX over LSP and cannot be loaded in-process by Volar. This repo is on `typescript ^5.8.2`, so 60618 does not apply here at all.

**How to apply:** Two removal triggers, either one is enough.
1. zed-mdx#21 closes / the MDX extension ships past 0.4.0 with a fix — then delete `.zed/settings.json` (or just the `lsp` block) and confirm the MDX server still starts.
2. This repo upgrades to TypeScript 7 — the pinned path stops resolving to a usable tsdk and the workaround silently breaks, so it must change at the same time.

If Mark reports the MDX language server failing again, check the version of the zed-mdx extension and this file first, before re-diagnosing from scratch.
