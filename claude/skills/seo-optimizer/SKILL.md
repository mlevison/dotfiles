---
name: seo-content-optimizer
description: Optimize content for search engines with keyword analysis, readability scoring, meta descriptions, and competitor comparison. Use this when users want to improve SEO, optimize blog posts, or analyze content for search performance.
---

# SEO Content Optimizer

Comprehensive SEO analysis and optimization for content creators and marketers.

When a user asks you to optimize content for SEO, provide a detailed analysis covering keywords, readability, technical SEO, and actionable recommendations.

## Site-Specific Context: agilepainrelief.com

When analyzing content for agilepainrelief.com, these rules OVERRIDE the generic defaults below:

### CoursesCTA Component
Every page already includes a global CoursesCTA component (tabbed "Get Certified" section showing all certification courses) via `base.astro`. Do NOT flag missing course links as a critical issue. In-content course links are beneficial only where there is a natural, contextual connection to a specific course (~30-50 high-alignment posts, not every post). Focus on whether the in-content link feels authentic rather than whether it exists.

### No New SEO-Only Pages
Never recommend creating root-level SEO keyword-capture pages. All new informational content goes under `/blog/` written in Mark's authentic voice. The existing 48 SEO pages are being consolidated into 4-6 comprehensive blog posts with 301 redirects (they collectively generate only ~84 clicks per 3 months, less than a single strong blog post).

### Consolidation Over Proliferation
Before recommending new content, check whether existing content already covers the subtopic. Recommend updating and consolidating existing content rather than creating new thin articles. Google's Helpful Content updates (2024-2025, now part of core algorithm) penalize sites with many thin, keyword-targeted pages. The strategy is fewer, stronger pieces.

### Orphaned Content Is the Top Priority
73 blog posts (42%) have zero inbound internal links. Fixing internal linking to orphaned content is a higher priority than keyword optimization or content additions.

### Topic Cluster Architecture
Content is organized into pillar/cluster topics with bidirectional linking. When analyzing a post, identify which cluster it belongs to and check for: (1) link to parent pillar page, (2) links to 2-3 sibling cluster posts, (3) link to relevant course page (only if natural), (4) that the pillar links back to this post.

### Typography Rules
- Use curly (typographer's) quotes and apostrophes (' ' " ") in all suggested text, NOT straight quotes
- Never use em dashes (—). Use a colon, comma, or restructure the sentence instead
- These rules apply to all suggested meta titles, meta descriptions, and example rewrites

### Excerpts and Meta Descriptions
NEVER generate meta descriptions or excerpts. Flag missing or weak descriptions for Mark to write himself. Mark insists that all excerpts and descriptions be human-authored, never AI-generated.

### External Links in MDX Components
When recommending external links within MDX component props, use the `external:` prefix convention: `external:https://example.com`

### Mark's Voice
Mark's authentic voice is warm, direct, experience-based, and mildly skeptical of hype. Do NOT suggest rewrites that sound like generic SEO copywriting. His expertise and authenticity ARE the SEO strategy. Generic, keyword-stuffed content undermines both authority and trust.

---

## Instructions

### 1. Analyze Target Keywords

Examine keyword usage and placement:
- Identify primary keyword(s) from user input or content
- Check keyword placement (title, H1, first 100 words, subheadings)
- Check that the primary keyword appears naturally in the title, H1, first 100 words, and at least one subheading. Do NOT target a specific keyword density percentage; natural, authentic writing is the goal
- Identify LSI keywords and semantic variations present
- Flag keyword stuffing issues

### 2. Evaluate Content Structure

Assess the organization and hierarchy:
- Check heading hierarchy (single H1 → multiple H2 → H3)
- Verify keyword usage in headings
- Evaluate heading descriptiveness
- Check paragraph length (aim for <150 words)
- Assess overall scanability

### 3. Readability Analysis

Calculate readability metrics:
- Flesch Reading Ease score (aim for 60-70)
- Grade level estimation
- Average sentence length (aim for <20 words)
- Passive voice percentage (minimize)
- Transition word usage
- Paragraph structure

### 4. Technical SEO Elements

Generate optimized meta elements:
- **Meta Title**: 50-60 characters with primary keyword
- **Meta Description**: Assess current description (150-160 chars target). Flag issues for Mark to rewrite; do NOT generate replacement descriptions
- **URL Slug**: Short, keyword-rich, hyphen-separated
- **Image Alt Text**: Descriptive with keywords where natural
- **Internal Linking**: Opportunities to link to related content. Note: Glossary terms (`/glossary/term-slug/`) are automatically linked in blog post and page content during the build process via a custom plugin — do not recommend manually adding links to glossary terms. Only recommend manual internal links for blog-to-blog or page-to-page links.
- **External Links**: Quality of outbound links

### 5. Content Quality Assessment

Evaluate comprehensiveness:
- Word count (competitive topics need 1500+ words)
- Content depth and detail level
- Topic coverage completeness
- Unique value proposition
- E-A-T signals (expertise, authority, trust)
- Content freshness (dates, current examples)

### 6. Provide Actionable Recommendations

Prioritize improvements by impact:

**Critical (Fix Immediately)**:
- Orphaned page (0 inbound internal links from other blog posts): add 2-3 contextual links from related posts
- Missing or poor meta description (flag for Mark to write; do NOT generate a replacement)
- No keyword in title or H1
- Broken internal links

**High Priority**:
- Missing pillar page link (post belongs to a cluster but does not link to its pillar)
- Missing bidirectional cluster links (pillar does not link back to this post)
- Poor readability score
- Weak heading structure
- Missing alt text on images
- Content too thin

**Medium Priority**:
- Could add related keywords
- Opportunity for featured snippet
- Could add cross-cluster links to related posts in other clusters

Provide specific, actionable fixes with examples.

## Output Format

```markdown
# SEO Analysis Report

## Overall Score: X/100

### Target Keywords
- Primary: [keyword] (density: X.X%)
- Secondary: [keyword 1], [keyword 2]
- LSI Keywords Found: [variations]

## Quick Wins (Implement First) 🚀
1. [Specific action with exact change needed]
2. [Specific action with exact change needed]

## Keyword Analysis

✅ Keyword in title
❌ Keyword missing in first 100 words ← Add to opening paragraph
✅ Keyword in 2/5 H2 headings
⚠️ Density: 0.8% (low - aim for 1-2%)

## Readability Metrics

- **Flesch Reading Ease**: XX/100 (Grade level: XX)
- **Average Sentence Length**: XX words
- **Passive Voice**: X%
- **Transition Words**: X%
- **Assessment**: [Good/Needs improvement]

## Meta Information

**Current Meta Title** (X chars): [current title]
**Suggested Meta Title** (XX chars):
`[Optimized title with keyword - 50-60 chars]`

**Current Meta Description**: [current or none]
**Meta Description Assessment**:
Issues: [too short/too long/missing keyword/missing value proposition/MISSING]
Action: Mark should write a 150-160 character description that [specific guidance on what to include].
Note: Do not use AI-generated descriptions per project policy.

**URL Slug**:
Current: `/current-url-slug`
Suggested: `/keyword-rich-slug`

## Content Structure

- **Word Count**: XXXX words ([sufficient/too short] for this topic)
- **Heading Hierarchy**: [assessment]
- **Paragraph Length**: Average XX words [good/too long]
- **Sections**: [list main sections]

## Critical Issues 🚨

### 1. [Issue Name]
**Problem**: [Description]
**Impact**: [SEO impact]
**Fix**: [Specific instruction]

**Example**:
```
Current: [show current problematic text]
Improved: [show corrected version]
```

## High Priority Recommendations ⚠️

### 1. [Recommendation]
[Specific actionable instruction]

## Topic Cluster Alignment

**Identified Cluster**: [cluster name]
**Pillar Page**: [URL or "not yet created"]
**Pillar Link Present**: ✅/❌
**Sibling Cluster Links**: X found (recommend 2-3)
**Course Page Link**: [present/not needed/recommended: specific course]
**Bidirectional Check**: Does the pillar link back to this post? ✅/❌
**Orphan Status**: [X inbound internal links / ORPHANED - needs links from related posts]

## Content Gaps & Consolidation Opportunities

**Before recommending new content, check:**
- Does an existing blog post already cover this subtopic? → Update it instead
- Does an SEO page exist for this keyword? → It will be absorbed into a consolidated blog post with 301 redirect
- Would a new article cannibalize an existing one? → Consolidate

Missing coverage (confirm no existing content first):
- **[Subtopic]**: [Why it matters] — recommend adding to [existing post URL] OR creating new cluster post under /blog/

## Internal Linking Opportunities

- Link to: [page URL] using anchor text: "[keyword phrase]"
- Link from: [this content] to [related page]
- Note: Glossary terms are auto-linked during build. Only recommend manual links for blog-to-blog or page-to-page connections.

## Featured Snippet Opportunity

[If applicable, show how to format content for featured snippet]

Example:
```markdown
## What is [topic]?

[Clear, concise 40-60 word answer]

- Key point 1
- Key point 2
- Key point 3
```

## Competitor Insights

[If analysis was done]
- Top ranking content averages XXXX words
- Common topics covered: [list]
- Your advantage: [unique angle]

## Implementation Checklist

- [ ] Fix orphan status: get 2-3 related posts to link to this page (if orphaned)
- [ ] Add pillar page link (if missing and cluster exists)
- [ ] Add 2-3 sibling cluster links
- [ ] Update meta title (if needed)
- [ ] Flag meta description for Mark to write (if missing/weak; do NOT AI-generate)
- [ ] Add keyword to first paragraph (if missing)
- [ ] Fix heading structure (if needed)
- [ ] Add missing alt text (X images)
- [ ] Add in-content course link (only if natural alignment exists)
- [ ] Expand [thin section] with XXX words (if content is too thin)

## Estimated Impact

**Expected Improvement**: [Moderate/Significant] ranking boost
**Priority**: [High/Medium/Low]
```

## Best Practices

- **Prioritize user experience** over keyword stuffing
- **Write for humans first**, optimize for search engines second
- **Provide specific examples**, not vague advice
- **Consider search intent** behind keywords (informational, commercial, transactional)
- **Recommend consolidation before creation**: check if existing content covers the topic before suggesting new articles. Fewer strong pieces beat many thin ones.
- **Check for E-A-T signals** (author bio, credentials, sources). Note: agilepainrelief.com already includes an author bio block on all blog posts via the layout.
- **Suggest schema markup** where relevant (FAQ, How-To, Review)
- **Look for featured snippet opportunities** (definition boxes, lists, tables)
- **Always use curly quotes** (' ' " ") and never em dashes (—) in any suggested text
- **Never generate meta descriptions or excerpts**: flag issues for Mark to write himself

## Example Workflow

**User**: "Optimize this blog post for 'best project management tools'"

**Your analysis**:
1. Check keyword placement → Found in title but not H1 (fix needed)
2. Calculate density → 0.5% (too low, needs 8-10 more mentions)
3. Analyze readability → Flesch score 55 (good), but sentences too long
4. Generate meta tags → Create compelling meta description
5. Identify gaps → Missing "pricing comparison" and "team size recommendations"
6. Find internal links → Link to "project management tips" article
7. Suggest featured snippet → Format comparison table
8. Provide prioritized action list

---

**Remember**: SEO is about creating valuable, well-optimized content that serves user intent better than competitors.
