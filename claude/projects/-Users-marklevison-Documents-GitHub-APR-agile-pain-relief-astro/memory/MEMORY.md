# Project Memory

## MDX Formatting Rules
- **Imports must use straight quotes** — never curly quotes in import statements (e.g., `import X from '@/path'` not `import X from '@/path'`)
- **Use actual Unicode characters, not escape sequences** — write `'` `"` `"` `–` directly, never `\u2019`, `\u201c`, `\u201d`, `\u2013`
- **YAML frontmatter** — use HTML entities for special characters (e.g., `&quot;` for quotes, `&apos;` for apostrophes, `&ndash;` for en-dash) since raw curly quotes can cause YAML parsing issues
- See [formatting-patterns.md](formatting-patterns.md) for detailed glossary entry structure
- [Glossary external links go in the reference section](feedback-glossary-external-links-in-references.md) — name the source in body prose, put the `https://` link in the Resource Links / Related Books box; inline only internal links

## Marketing Experiments
- [Experiment result conventions](feedback-experiment-results.md) — "Not run" is not "Failed"; classify by whether the experiment actually executed

## Working style
- [The repo is the only source of truth](feedback-repo-is-source-of-truth.md) — never cite Obsidian vault docs as authoritative; copy what matters into CLAUDE.md/HISTORY.md and drop the pointer
- [Comments are a smell](feedback-comments-are-a-smell.md) — Mark almost never writes them; every comment in the repo is AI-generated, so never cite one as his intent
- ["What action would we take?" litmus test](feedback-action-litmus.md) — default to dropping tags/data unless a concrete campaign or segment will use them; Mark runs the business alone and any kept data imposes maintenance cost
- [Never commit/push/PR on Mark's behalf](feedback-no-git-checkin.md) — stop at "diff is ready"; Mark handles all check-in steps himself
- [No URLs inline in social-media post text](feedback-no-urls-in-post-text.md) — URL belongs only in the dedicated `url` field; the posting pipeline handles placement
- [AI Failure Modes quiz: frame as knowledge test](feedback-ai-failure-quiz-framing.md) — "test your knowledge of how AI fails", not "twelve questions on how AI fails"; challenge framing converts better than learning-resource framing
- [LinkedIn AI-skeptical posts need a caveat](feedback-linkedin-ai-caveat.md) — short, varied one-liner reframing failure-mode critique as prerequisite to using AI well, not rejection. LinkedIn only; skip on non-AI posts.
- [No redirects for noIndex or short-lived pages](feedback-no-redirects-ephemeral-pages.md) — nothing to preserve; just delete them
- [No confirmation prompts in CLI scripts](feedback-no-confirmation-prompts.md) — gate actions behind an explicit flag + default-safe dry run, not a type-"yes" prompt; running the command is the intent

## API design
- [No booleans in caller-facing APIs](feedback-no-booleans-in-apis.md) — prefer string enums (`'none' | 'within-sections'`) over `true/false`; booleans are unreadable at the call site

## External service quirks
- [Cakemail lowercases all tags](reference-cakemail-lowercase-tags.md) — writing CamelCase is fine (readability), but reads / comparisons / UI-segment queries must use the lowercased form
- [Cakemail contact lookup filter syntax](reference-cakemail-contact-filter.md) — `?email=` is silently ignored; use `?filter=email==<value>` or dedup/idempotency breaks invisibly
- [Cakemail form submission replaces tags](reference-cakemail-form-replaces-tags.md) — hosted-form POST overwrites the whole tag set (not merge); risk of wiping `aiquiz`. Tags auto-create, applied even to existing contacts
- [Bluesky counts URLs as 15 chars](reference-bluesky-url-char-count.md) — toward the 300-char limit, URLs cost 15 chars (not full length). LinkedIn and Mastodon still count full length.
- [Cakemail token auto-rotates](reference-cakemail-token-auto-rotate.md) — refresh token rotates automatically every run (client writes new value to root .env); `refresh-cakemail` is recovery-only for full expiry, no `--purpose` flag
- [Cakemail merge-tag empty fallback breaks](reference-cakemail-merge-tag-empty-fallback.md) — `[firstname,]` renders literally; use `[firstname]` (no comma) for no fallback. Caused a whole-list bad send 2026-06-26. Now code-owned: newsletter greeting auto-injected by send-newsletter.ts; authors don't write one

## Deferred work
- [Formspree eviction](project-formspree-eviction.md) — only the contact form still uses Formspree; ~1hr swap, deferred as of 2026-05-26
- [Zed MDX tsdk workaround](project-zed-mdx-tsdk-workaround.md) — `.zed/settings.json` pins mdx-analyzer's tsdk to this repo's TS 5.8; delete when srazzak/zed-mdx#21 is fixed. The Zed tsgo extension does NOT fix it

## Active projects
- [AI audience: one list + aiquiz tag](project-aiquiz-nurture-filter.md) — Quiz + AI direct-download all go to Newsletter Subscribers tagged `aiquiz`; nurture triggers on the tag. Cakemail forms CAN apply tags (`tags[name]=true` dict).
- [ScoreApp eviction](project-scoreapp-eviction.md) — replacing ScoreApp with self-hosted MDX quiz engine; remove `scoreapp-webhook.ts` + `SCOREAPP_WEBHOOK_SECRET` on cutover
- [Refresher offer policy](project-refresher-offer-policy.md) — alumni free-seat offers: include `Interested - Refresher - {course}`, exclude DO-NOT-NOTIFY + prior refresher attendees; deliver via direct transactional send, no new list
- [Newsletter double-send guard](project-newsletter-double-send-guard.md) — send-newsletter has no idempotency; aborts (no --force) on a committed same-name campaign, and --test-send is preview-only. Born from a 2026-06-11 double-send to the whole list
