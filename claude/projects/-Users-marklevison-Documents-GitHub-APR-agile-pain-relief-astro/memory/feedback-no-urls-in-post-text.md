---
name: feedback-no-urls-in-post-text
description: Social media post JSON files should not include URLs inline in linkedin/mastodon/bluesky text — the URL goes only in the dedicated url field
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f7b4a753-51a1-4544-9dd1-54b9abb4ce64
---

When generating social media post JSON files (e.g. for `social-media-content-evergreen/` or `social-media-content-temp/`), do NOT include URLs inline in the `linkedin`, `mastodon`, or `bluesky` text fields. The URL belongs only in the dedicated `url` field of the object.

**Why:** The posting pipeline handles URL placement: it extracts the URL to the first comment on LinkedIn, and presumably attaches it as a link card / appends per-platform on Mastodon and Bluesky. Including the URL inline in the post text creates duplication and noise. Mark corrected this on 2026-05-29 when I followed the format-spec comment literally ("Include URLs inline — the script extracts them to first comment").

**How to apply:** Write the body copy with no URL. End with hashtags or a clean closing sentence. Put the canonical URL in the `url` field only. The format-spec comment about "include URLs inline" is misleading; ignore it. Character-limit budgeting also benefits since you don't have to reserve ~50 chars for the URL on Bluesky.

Related: [[feedback-action-litmus]]
