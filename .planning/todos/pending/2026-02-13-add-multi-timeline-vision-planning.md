---
created: 2026-02-13T21:55:00.000Z
title: Add multi-timeline vision planning
area: agents
files:
  - agents/brainstorm-specwriter.md
  - templates/PRODUCT_SPEC.md
---

## Problem

Currently brainstomer focuses on immediate MVP but lacks structured thinking across different time horizons. Need to force thinking about:
- Ultra short-term: Concept validation
- Short-term: MVP
- Medium-term: Market launch and traction
- Long-term: 10+ year vision

The long-term vision is arguably the most important — it reveals the true ambition and helps make better short-term decisions.

## Solution

### Multi-Timeline Vision Section

Add structured timeline planning to specs:

**Timeline 1: Validation (1-4 weeks)**
- How to test the core hypothesis?
- What's the smallest experiment?
- Success/failure criteria
- Kill decision point

**Timeline 2: MVP (1-3 months)**
- Minimum features to launch
- First paying customers target
- Core loop that must work
- What to explicitly NOT build

**Timeline 3: Market Launch (6-12 months)**
- Full product vision
- Go-to-market strategy
- Traction targets
- Team needed
- Funding requirements (if any)

**Timeline 4: Long-term Vision (5-10+ years)**
- What could this become at scale?
- Market size at full potential
- Ecosystem/platform possibilities
- Moonshot scenarios
- How does this change the world?

### Output: VISION_TIMELINE.md

```markdown
## Vision Timeline for [Product]

### T1: Validation (Weeks 1-4)
**Goal:** Prove [core hypothesis]
**Experiment:** [minimal test]
**Success:** [metrics]
**Kill if:** [failure criteria]

### T2: MVP (Months 1-3)
**Goal:** First paying customers
**Features:** [minimal set]
**NOT building:** [explicit exclusions]
**Success:** [revenue/user targets]

### T3: Market (Months 6-12)
**Goal:** Product-market fit
**Full feature set:** [list]
**GTM strategy:** [approach]
**Team:** [roles needed]
**Funding:** [if applicable]

### T4: Long-term (5-10+ years)
**Vision:** [what this becomes]
**Scale:** [market size]
**Impact:** [how it changes things]
**Moonshot:** [ambitious scenario]

### Timeline Alignment Check
- Does T1 validate what's needed for T2?
- Does T2 set up success for T3?
- Does T4 justify the effort of T1-T3?
- Are we building toward the right future?
```

### Why Long-term Matters Most

"If your 10-year vision is to build a small SaaS tool, that's fine — but be honest about it. If your 10-year vision is to transform an industry, your short-term decisions should reflect that ambition."

Questions to force:
- Is this a feature, a product, or a company?
- Is this a lifestyle business or a venture-scale opportunity?
- What's the ceiling vs the floor?

### Integration

Could be:
- Section in PRODUCT_SPEC.md
- Separate `/brainstorm:vision` command
- Part of the clarification phase questioning
- Parallel agent dedicated to timeline analysis

### Philosophy

"Think in decades, plan in months, execute in weeks."
