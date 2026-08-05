---
name: feedback-no-ai-edits-to-copy
description: "For Mark's writing, the AI suggests via inline CriticMarkup (reviewed in Track Changes), never silently rewrites prose outside a markup wrapper"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 3ce68f39-4e07-4069-a03e-03450fc1b089
---

The AI suggests; Mark decides. The AI never rewrites Mark's prose outside a markup wrapper.

For writing that lives in a Markdown file (blog, newsletter, email, ebook, social, sales/marketing copy), deliver edits as inline CriticMarkup annotations written into the file, reviewed in Obsidian's Track Changes panel where Mark accepts or rejects each. See the skill `criticmarkup-editing`. For content pasted into chat (no file), fall back to suggestions in chat.

**Why:** Mark is the writer; the AI's role is suggestion only. He originally stated "never touch the file, suggest in chat" after I offered to apply edits to a sales page. On 2026-06-09 he refined this: CriticMarkup keeps the same intent (the AI proposes, Mark disposes) while putting proposals inline where he can review and accept or reject them, so it is allowed and is now the default for Markdown files.

**How to apply:** This supersedes the earlier chat-only rule. The hard line that survives: never rewrite Mark's prose outside a CriticMarkup wrapper, never silently change the file, never invent citations (flag with `[?]`). The copy-editing, storybrand-messaging, apr-blog-critique, apr-newsletter-reviewer, and apr-linkedin-style skills now deliver via CriticMarkup on Markdown files; their Ground Rule / Delivery sections carry the detail. Author notes still off-limits to markup: see [[feedback-italics-are-author-notes]].
