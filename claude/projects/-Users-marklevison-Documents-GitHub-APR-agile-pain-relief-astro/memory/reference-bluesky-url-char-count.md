---
name: reference-bluesky-url-char-count
description: "On Bluesky, URLs count as 15 characters (not full length) toward the 300-char post limit. LinkedIn and Mastodon count URLs at full length."
metadata: 
  node_type: memory
  type: reference
  originSessionId: f7b4a753-51a1-4544-9dd1-54b9abb4ce64
---

When calculating Bluesky post lengths against the 300-character limit, **count any URL in the post body as 15 characters**, not its real length. Bluesky uses rich-text facets that compress the visible URL representation, so the wire-length cost of a URL is effectively fixed.

LinkedIn and Mastodon count URLs at their full character length (no rich-text compression in the count).

**Why this matters:** A 60-character Bluesky URL effectively costs 15 chars, freeing 45 chars of body copy. Treating Bluesky URLs as full-length is overly conservative and trims posts more than necessary. Mark told me to assume 15 chars on 2026-05-29 after we tightened a batch of posts.

**How to apply:**

- When validating Bluesky posts, replace any matched URL with a 15-char placeholder before measuring length:
  ```js
  const blueskyLen = s => s.replace(/https?:\/\/\S+/g, '_______________').length;  // 15 underscores
  ```
- This convention is wired into the validator in `.claude/skills/evergreen-posting/SKILL.md`.
- This only affects URLs **in the body text**. The current convention is to put URLs in the dedicated `url` field, not inline — see [[feedback-no-urls-in-post-text]]. The 15-char rule still matters if/when URLs ever appear in Bluesky body text (e.g. multi-link posts, references to external sources, the posting pipeline failing to attach a link card).
- Don't apply the 15-char rule to LinkedIn or Mastodon — they count URLs at full length.

Related: [[feedback-no-urls-in-post-text]]
