---
name: feedback-social-thread-link
description: "When a Bluesky/Mastodon social post would overflow because of the link, thread it - message in post 1, link in post 2 (or 3) - instead of shortening the message."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 45df3cd4-be94-454f-842c-8c772652df53
  modified: 2026-07-27T18:17:50.671Z
---

For the APR social pipeline (`next-few-days.json` built via `linkedin-style` draft mode), when a Bluesky (or Mastodon, if needed) post won't fit content + link under the limit, **thread it** rather than compressing the message: post #1 is the start of the thread with the full message and no link, and the link goes in post #2 (or #3). Only thread when needed; a post that fits stays single.

**Why:** Bluesky counts the entire UTM'd URL against its 290 limit, and long slugs (e.g. the backlog-refinement post) eat ~150 chars, which forces the message far shorter than the LinkedIn version. Mastodon counts any URL as a fixed 23. Moving the link to a reply frees post #1 for the full message. Mark's own instruction, 2026-07-27.

**How to apply:** Wired end-to-end as of 2026-07-27. In the batch JSON, set `mastodon`/`bluesky` to an **array of strings** instead of one string: `[0]` is the root post, the rest become thread replies. `batchPost.ts` `prepareContent` appends the `url` (with per-platform UTM) to the **last** part only, so the root keeps its full 290-char budget for the message and the short reply pays for the link. Every part is validated against the full per-platform limit independently. `linkedin` stays a single string. Keep the link part short ("Full post:") and put the hashtags on the root. See [[feedback_social_draft_location]].
