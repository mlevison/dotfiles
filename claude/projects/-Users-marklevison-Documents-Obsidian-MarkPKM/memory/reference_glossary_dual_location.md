---
name: reference-glossary-dual-location
description: APR glossary entries exist in two places that Mark keeps in sync - the Astro source and a vault mirror; edit both
metadata: 
  node_type: memory
  type: reference
  originSessionId: a3eceb37-0a69-4b0d-8e2e-61774a014c96
---

APR glossary entries live in **two** places and Mark keeps them in sync:

- **Canonical / published:** Astro repo `src/content/glossary/<slug>/index.mdx` (uses MDX components like `<Figure>`, `<LinkList>`, `<HighlightBox>`; `\***\*bold\*\***` for mini-headings; absolute or `/glossary/...` links). This is the live website source.
- **Vault mirror:** `APR/Efforts/Glossary/<Title>.md` in the Obsidian vault (plain Markdown; `****bold****` mini-headings; `![img](file.jpg)`; `[[wikilinks]]`).

When editing a glossary term, update **both** copies to match (content, not exact syntax). CLAUDE.md only mentions the Astro source, so the vault mirror is easy to miss.

Delivery: for glossary edits Mark wants **direct edits reviewed via git diff** (both repos are git-backed), not CriticMarkup. Do not commit or deploy the Astro change; that's his call. Bump the Astro `lastUpdated` frontmatter when content changes (ask first). This differs from his vault *writing* (workbook/blog/newsletter), where the default is CriticMarkup - see [[feedback_no_ai_edits_to_copy]].
