---
created: 2026-02-13T22:05:00.000Z
title: Add feedback command for external input processing
area: workflows
files:
  - workflows/feedback.md
  - templates/FAQ.md
  - skills/brainstorm.md
---

## Problem

When you pitch an idea or discuss it with others, you receive feedback. This feedback is valuable but often lost. Need a command to:
1. Capture external feedback systematically
2. Analyze it deeply (recurring questions = important signals)
3. Challenge the project based on real-world reactions
4. Build a FAQ from common questions
5. Improve storytelling and communication

**Key insight:** Feedback always has impact — either on the product itself OR on how you communicate about it.

## Solution

### `/brainstorm:feedback`

Command to process external feedback with deep analysis.

**Input:** User shares feedback they received
```
/brainstorm:feedback "Someone asked me why they wouldn't just use Excel for this"
```

**Analysis Pipeline:**

1. **Categorize the feedback**
   - Question (needs answer)
   - Objection (needs addressing)
   - Suggestion (needs evaluation)
   - Confusion (needs clarity)
   - Enthusiasm (validate what resonates)

2. **Assess recurrence likelihood**
   - Is this a common question?
   - Would others ask the same?
   - Is this a pattern from multiple sources?

3. **Determine impact type**
   - Product impact: Should we change what we build?
   - Communication impact: Should we change how we explain?
   - Both: Fundamental challenge to address

4. **Generate response**
   - If product change needed: Suggest pivots/additions
   - If communication change: Improve pitch/storytelling
   - Add to FAQ if recurring

### Output: FEEDBACK_LOG.md + FAQ.md

**FEEDBACK_LOG.md:**
```markdown
## Feedback Log

### 2026-02-13: "Why not just use Excel?"
**Source:** Casual pitch conversation
**Category:** Objection
**Recurrence:** HIGH (common spreadsheet comparison)

**Analysis:**
This reveals we're not communicating the core differentiator clearly.
Excel handles data, but we handle [specific value prop].

**Impact:**
- [ ] Product: No change needed
- [x] Communication: Add "Why not Excel?" to pitch

**Action taken:**
- Added to FAQ
- Updated value proposition in pitch deck
```

**FAQ.md:**
```markdown
## Frequently Asked Questions

### "Why wouldn't I just use Excel/Notion/[existing tool]?"
**Short answer:** [One-liner]
**Full answer:** [Detailed response]
**When to use this:** [Context for using this response]

### "Who is this for exactly?"
...
```

### Feedback Categories

| Type | Product Impact | Communication Impact |
|------|---------------|---------------------|
| "I don't get it" | Maybe | Definitely |
| "Why not X?" | Check | Definitely |
| "I would pay for Y" | Definitely | Maybe |
| "This is too complex" | Definitely | Definitely |
| "I love the Z part" | Validate | Highlight more |

### Storytelling Improvement Loop

Feedback → Analysis → FAQ → Better Pitch → Less Feedback

The goal is to preemptively answer common questions in your pitch, reducing friction and objections.

### Integration

- Store feedback in `.brainstorm/feedback/` directory
- Aggregate into FAQ.md
- Suggest pitch improvements
- Track which objections keep recurring (signals unresolved issues)

### Philosophy

"Every piece of feedback is a gift. It either makes your product better or your pitch clearer. Ignore neither."

Questions that keep coming up = you haven't solved them yet (either in product or in communication).
