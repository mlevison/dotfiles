---
name: feedback_weekly_analytics_run_scripts
description: "In the weekly analytics loop, don't ask before running the npm pull scripts when Mark asked for all three"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 42d4174d-45e8-4374-b5be-54833371166c
---

When running `apr-weekly-analytics`, if Mark has asked to run all three pull scripts (`npm run scrape`, `npm run posthog-export`, `npm run scrape-engagement`), just run them. Don't re-ask for confirmation.

**Why:** Mark said "Don't ask again. If I ask for all three then run them." The skill's "Confirm before running npm scripts" safety rail is overridden by this standing instruction.

**How to apply:** Still do the read-only freshness checks and report them, but skip the confirm-before-running step when the intent to run all three is clear. Note: `npm run scrape-engagement` can fail on an expired Cakemail token, which requires Mark to run `npm run refresh-cakemail` interactively (email + password) and update `CAKEMAIL_REFRESH_TOKEN` in the repo-root `.env`.
