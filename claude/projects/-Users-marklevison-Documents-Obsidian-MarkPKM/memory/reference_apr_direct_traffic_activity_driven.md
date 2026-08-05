---
name: reference-apr-direct-traffic-activity-driven
description: "APR PostHog \"direct\"/None traffic is activity-driven; an offline-period drop is not a tracking break"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 815fd98d-c622-48d9-9e49-3f4cff0465d7
---

In APR's PostHog data, the "None" (direct/organic) bucket lumps together true-direct, organic search, bookmarks, dark social, and un-UTM'd newsletter/social clicks. Google Search Console organic clicks (~105/week) are only a small slice of it. So a large drop in "direct" pageviews while GSC organic stays flat does NOT imply a tracking break.

**Why:** In June 2026 I wrongly flagged a ~68% direct-traffic drop (starting week of 2026-04-20) as a likely broken PostHog snippet. The real cause: Mark was mostly offline late April through May (no newsletters April 23 → June 3, quiet on social), so the email + dark-social + returning-visitor portion of "direct" evaporated. Organic search held steady (matching flat GSC).

**How to apply:** Before concluding "tracking break" on a direct-traffic dip, (1) check whether it correlates with Mark's posting/sending activity, and (2) run the page-level test — a real activity drop is page-selective (GSC organic winners hold up, promotion-dependent pages like course pages and the /blog/ index crater), whereas a tracking break hits all pages roughly uniformly. Also recommend UTM-tagging outbound newsletter/social links so activity-driven swings attribute to email/linkedin instead of hiding in "direct." Relates to [[apr_analytics_architecture]].
