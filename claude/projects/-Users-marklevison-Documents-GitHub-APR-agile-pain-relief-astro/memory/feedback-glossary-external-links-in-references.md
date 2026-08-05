---
name: feedback-glossary-external-links-in-references
description: "Glossary entries keep external links in the reference section, not inline in the body"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: e86b4f1c-f45c-4478-8ae8-c1b98bd4825f
---

In almost all cases, glossary entries should keep all external (`https://`) links in the Resource Links / Related Books sections at the bottom, NOT inline in the body prose. Name the source in the text (e.g. "Rebecca Wirfs-Brock argues...") and put the actual link in the `resourceLinks` HighlightBox.

**Why:** Keeps body prose clean and puts sources in one predictable place; matches how the glossary is authored.

**How to apply:** Internal links (`/blog/...`, `/glossary/...`) may still appear inline. Only inline an external link when the prose would be incomprehensible without it (rare). Documented in project `CLAUDE.md` (Links section) and the `glossary-entry` skill.
