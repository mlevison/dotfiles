# Global instructions

## Response style

- Prefer bullet points over long paragraphs wherever the content allows.
- Fewer words is better than more; cut filler.

## Supply-chain hardening (npm)

Every Node/npm project must enforce a minimum release age on dependencies to
reduce exposure to freshly-published malicious package versions.

- Add `min-release-age=7` to the project's checked-in `.npmrc` (units are days).
  npm will then only install package versions that have been public for ≥ 7 days.
- This is the real npm config key (npm ≥ 11.5). Do **not** use `minimumReleaseAge`
  — that is pnpm's spelling and npm ignores it.
- It constrains version *resolution* (`npm install` / `update` / `outdated`), not
  `npm ci`, which installs exactly what `package-lock.json` already pins.
- There is no per-package exclusion yet. For an urgent security patch within the
  window, override that one command with `--min-release-age=0`.

When setting up or auditing a Node repo, verify `.npmrc` contains this line and
add it if missing.

## Quality gates

A warning that nothing fails on is a warning that ships. When setting up or
auditing any repo, work through these — they are the ways a defect reaches
production with every check green.

- **Make every check fail on warnings.** Type checkers and linters exit 0 on
  warnings by default, so an a11y hint, an unused-CSS selector, or a
  `@deprecated` notice prints and the build sails on. Turn that off explicitly:
  `svelte-check --fail-on-warnings`, `tsc` with no `--noEmitOnError` escape,
  `eslint --max-warnings 0`, `astro check` read as pass/fail. Do this while the
  count is still zero — it costs nothing then and is a cleanup project later.
- **Put the check where release is actually blocked.** Find the one command that
  gates deployment (`vercel.json` `buildCommand`, `netlify.toml`, the Dockerfile,
  the release job) and add it there. A check added to an advisory CI workflow
  that nothing waits on is decoration. Confirm which is which before adding.
- **Every check has a scope, and it is smaller than the repo.** A linter covers
  the files its config globs reach; a type checker covers its `tsconfig`
  `include`. Directories outside those — edge/serverless functions in another
  runtime, `scripts/`, `e2e/`, generated dirs — are checked by *nothing* and
  quietly accumulate errors. Enumerate what the gate does not reach, then either
  bring it in or give it its own command in the gate.
- **Type checkers cannot see inside strings.** Anything string-encoded is
  invisible to them: CSS/Tailwind class lists, query strings, route paths, env
  var names, i18n keys. If a typo there fails silently at runtime rather than
  loudly at build time, it needs a checker of its own.
- **Editor diagnostics are invisible to CI and to coding agents.** If a red
  squiggle in the IDE has no command-line equivalent in the gate, it does not
  exist for anyone but the person with that file open. Convert it into a
  runnable command.
- **Drive the repo to zero before you turn the gate on.** A check with a nonzero
  baseline trains everyone to ignore it. Fix the backlog (autofix where the tool
  offers one), then gate at zero, so any later finding is unambiguously one just
  introduced.
- **Never widen a threshold or add an ignore directive to make a check pass**
  when a correct fix exists. When an ignore genuinely is right (a hand-written
  class the tool can't know about, a third-party signature), anchor the pattern
  exactly (`^my-class$`, not `my-class`) so a real typo can't slip through, and
  say in a comment why it's there.
- **Autofix output still needs reading.** `--fix` is mechanical and occasionally
  wrong in ways that still lint clean. Skim the diff, and re-run the tests that
  cover the touched files.

## Prefer official packages

When a task needs a library and an official/first-party package exists (e.g.
Google's `googleapis`), choose it by default — don't ask, don't hand-roll an
equivalent. Only raise the choice if the official package is unmaintained,
deprecated, or genuinely can't do the job.
