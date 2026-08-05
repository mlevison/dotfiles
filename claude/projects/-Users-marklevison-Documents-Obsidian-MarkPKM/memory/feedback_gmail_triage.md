---
name: feedback-gmail-triage
description: "Mark's rules for the gmail-triage skill — batch size, notification holdback, newsletter routing, and what actually qualifies as an OmniFocus task."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: eec50739-9a7d-40ae-8312-f5092d9c6d43
  modified: 2026-07-26T21:43:23.147Z
---

Rules Mark established during the first real run of [[gmail-triage]] on 2026-05-25. Apply these every future run; update the skill itself to match when next editing it.

**1. Recommendations are presented 10 at a time, max.**
**Why:** A 30-row table was overwhelming and made it harder to cherry-pick.
**How to apply:** Even the initial triage report (before batch confirms) caps each bucket at 10. If a bucket is larger, show first 10 + "N more queued for next batch." Never dump 20+ rows in one section.

**2. Notifications stay in the inbox until Mark has replied OR they're more than 10 days old.**
**Why:** They're the de facto reminder that something needs Mark's attention. Trashing them too early loses the prompt.
**How to apply:** Circle.so reply pings, LinkedIn message digests, mention notifications, transactional pickup-ready emails, etc. — keep in inbox if dated within the last 10 days. Only trash when both conditions are met (replied or aged out).

**3. Newsletter routing — most kept newsletters land under "Courses and Memberships" (the parent), not the GrowthMaterial sub-label.**
**Why:** Mark uses Courses and Memberships as the general kept-but-out-of-inbox newsletter library. GrowthMaterial is a narrower sub-bucket whose exact criteria are TBD — when unsure, prefer the parent.
**Recent-newsletter rule:** Newsletters less than 10 days old, Mark might still read. Don't trash recent ones reflexively. Also: don't push to auto-FILE them either — Mark often prefers to read/dismiss them in inbox first. Present the filing as a recommendation, expect "skip / leave in inbox" as a common response on recent items, and only file when he explicitly says go. The label routing rules below still apply when he does want to file.
**Known mappings (as of 2026-05-25):**
- → **Courses and Memberships** (parent): David Sparks / MacSparky / Mike Schmitz / Memberful Lab Report / MPU / Asteroid City / Casey Newton Platformer / Sahil Bloom / Nick Wignall / Jefferson Fisher / Dense Discovery / MacStories (weekly@macstories.net) / Age of Product (stefan@age-of-product.com) / Chris Bailey (chris@chrisbailey.com) / Linking Your Thinking (hello@linkingyourthinking.com) / InfoQ (infoq-events@mail.infoq.com) / Fearless Organization (inquiries@fearlessorganizationscan.com) / Ed Zitron / Where's Your Ed At (noreply@wheresyoured.at) / ClearerThinking (clearerthinking@*) [last 8 added 2026-06-07]
- → **Courses and Memberships/GrowthMaterial** (sub-label): Jay Clouse (Creator Science) — always GrowthMaterial. The distinction between parent vs GrowthMaterial isn't fully nailed down; default to parent when unsure and let Mark correct sender-by-sender.
- → **DorisBusiness**: doris@yourfinanciallaunchpad.com (Friday Financial Wins)
- → **Keep in inbox, then archive once older than 3 weeks** (specific sender preference): Joseph Pelrine / PsychNuggets [aging rule added 2026-07-26]
- → **Keep in inbox for at least a month** (then revisit): Readwise themed connection digests (hello@readwise.io, "🧑‍🤝‍🧑 ... Your Themed Connection" type)
- → **Keep in inbox (near-future event reminder)**: David Sparks Robot Assistant Field Guide Webinar reminders — kept even though similar-shape Robot Builder's Club reminders are always trashed. The two are distinct sender behaviours.
- → **Archive when older than 10 days** (remove INBOX, no other label): Timing weekly summary (help@timingapp.com)
- → **Trash** (always): AI Valley (delete on sight; always delete once >2 days old) / Brevilabs Copilot product updates / Tandem Coach / Inspect and Adapt / Globe & Mail / MSF / OpenMedia / Mark's own Readwise summaries (hello@readwise.io "Mark's Summaries" type) / expired event reminders / resolved unsubscribe threads / Parallel Web Systems / David Sparks Robot Builder's Club meeting reminders (david@macsparky.com "Reminder: The next meeting of the Robot Builder's Club...") — Mark doesn't find these useful / LinkedIn connection invites (invitations@linkedin.com "I want to connect") — distinct from LinkedIn message digests, which still follow the notification holdback rule / Jeff Burningham (info@jeffburningham.com) — newsletter Mark doesn't read; trash on sight, unsubscribe candidate [added 2026-06-07] / Wealthsimple statement-ready notifications (notifications@o.wealthsimple.com, "Your latest credit card statement is ready"): always trash [added 2026-06-28]
- → **Never surface in Reply queue** (Mark's words: "he just doesn't matter"): Joseph Little (joseph.h.little@gmail.com). Don't trash automatically — apply normal triage rules to his messages. Just don't flag them for reply, ever, even in working-group threads where Mark has participated.
- → **Conditional read-then-decide**: Ahrefs Digest — only keep if there's something genuinely interesting to learn (read body before classifying)
- → **Archive without a label** (remove INBOX only — leaves it in All Mail for records, no filing): resolved correspondence threads worth keeping for records (e.g., the Codemanship/Jason Gorman unsubscribe exchange); newsletters with one-off useful content that doesn't fit any label (e.g., This Week in Security when it covers AI tool promises and failures). This is a distinct action from both filing and trashing — surface "Archive" as a fourth action in future triage reports when neither label nor trash fits.
- When unsure between trash and Courses and Memberships, lean Courses and Memberships.

**4. Only emails that are *purely* an out-of-email action get captured to OmniFocus.**
**Why:** Events go to calendar, course follow-throughs are tracked in vault/effort files, and most "reminders" naturally re-surface via the email itself. The only Task-worthy items are commitments waiting on an external trigger Mark might miss.
**How to apply:** Capture as Task only when (a) the action has no other system tracking it AND (b) the email won't naturally re-prompt. Example that qualifies: "Sign WagePoint PAD agreement when email arrives." Examples that do NOT: calendar events, library pickup notifications, "incorporate feedback into course X" (tracked in vault), webinar reminders.

Related: [[gmail-triage]] (the skill itself), [[omnifocus-capture]] (where tasks land).
