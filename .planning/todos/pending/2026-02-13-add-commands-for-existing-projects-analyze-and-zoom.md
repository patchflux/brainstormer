---
created: 2026-02-13T21:50:00.000Z
title: Add commands for existing projects (analyze and zoom)
area: workflows
files:
  - workflows/analyze.md
  - workflows/zoom.md
  - skills/brainstorm.md
---

## Problem

Currently brainstomer only has `/brainstorm:new` for starting fresh projects. Missing commands for:
1. **Existing projects** — Analyze what's already built, extract essence, guide continuation/improvement
2. **Feature zoom** — Deep dive into a single feature with independence while maintaining global context

## Solution

### Command 1: `/brainstorm:analyze`

Analyze an existing project to:

**Extract Essence:**
- What problem does this actually solve?
- Who is the current target user?
- What's the core value proposition?
- What's working vs what's not?

**Reflect and Guide:**
- How to continue the project?
- What improvements make sense?
- What features to add/remove?
- What pivot opportunities exist?
- Is the project worth continuing?

**Output: PROJECT_ANALYSIS.md**
```markdown
## Project Essence

### Core Problem Solved
[What this project actually does]

### Current State
- Features: [list]
- Users: [target]
- Traction: [metrics if available]

### Strengths
- [what's working]

### Weaknesses
- [what's not working]

### Improvement Opportunities
1. [ranked list]

### Strategic Questions
- Should you continue this direction?
- Alternative pivots worth considering
- Kill criteria (when to stop)
```

### Command 2: `/brainstorm:zoom` or `/brainstorm:feature`

Deep dive into a single feature with:

**Independent Focus:**
- Dedicated research just for this feature
- Parallel agents specialized on this scope
- Own mini-spec and validation

**Global Context Awareness:**
- Knows the overall project
- Ensures feature fits the whole
- Maintains consistency with existing architecture

**Output: FEATURE_SPEC.md**
```markdown
## Feature: [Name]

### Context (from global)
- How this fits the overall product
- Dependencies on existing features
- Integration points

### Deep Research
- Prior art for this specific feature
- Best practices
- Technical options

### Specification
- User stories
- Technical approach
- MVP scope
- Success metrics

### Implementation Notes
- Files to modify
- New files needed
- Testing strategy
```

### Workflow Integration

```
/brainstorm:new      → Fresh project from scratch
/brainstorm:analyze  → Analyze existing project, guide continuation
/brainstorm:zoom     → Deep dive into single feature
/brainstorm:clarify  → (existing) Clarify ideas through dichotomy
/brainstorm:specs    → (existing) Generate final specifications
```

### Use Cases

**Analyze:**
- "I built this side project 6 months ago, should I continue?"
- "This project is stalled, help me figure out next steps"
- "Review my existing product and suggest improvements"

**Zoom:**
- "I need to add authentication to my app, deep dive on this"
- "Help me design just the payment flow for this project"
- "Focus on the AI integration feature specifically"

### Philosophy

"Not every project starts from zero. Help with the messy reality of existing codebases and half-finished ideas."
