---
created: 2026-02-13T21:42:00.000Z
title: Add fundraising strategy agent with multiple scenarios
area: agents
files:
  - agents/brainstorm-specwriter.md
---

## Problem

Not every startup needs or should raise VC money. Need an agent that explores multiple funding strategies realistically, including bootstrapping. Currently brainstomer focuses on product/market but ignores the financial strategy.

## Solution

### Fundraising Strategy Agent

Generates multiple funding scenarios based on the idea characteristics:

**Scenario 1: Bootstrap (No Funding)**
- Revenue-first approach
- How to reach profitability with minimal burn
- Lifestyle business potential
- When this makes sense (niche markets, services, etc.)

**Scenario 2: Friends & Family / Angels**
- Realistic raise amount (25K-250K)
- What milestones to hit first
- How to structure (SAFE, convertible notes)
- Who to approach

**Scenario 3: Pre-Seed / Seed VC**
- What VCs look for at this stage
- Required traction metrics
- Typical valuations and dilution
- Timeline and process

**Scenario 4: Alternative Funding**
- Grants (government, nonprofit)
- Crowdfunding (Kickstarter, Republic)
- Revenue-based financing
- Strategic partnerships

**Scenario 5: Hybrid Paths**
- Bootstrap → Angel when traction
- Grants + Bootstrap
- Crowdfunding → VC

### Output: Funding Strategy Report

```markdown
## Funding Analysis for [Product]

### Recommended Path: [Primary recommendation]

### Scenario Comparison

| Scenario | Raise | Timeline | Dilution | Fit Score |
|----------|-------|----------|----------|-----------|
| Bootstrap | $0 | Now | 0% | 8/10 |
| Angels | $150K | 3-6 mo | 10-15% | 7/10 |
| Seed VC | $1-2M | 6-12 mo | 15-25% | 5/10 |

### Why [Recommended] Fits Best
[Reasoning based on idea characteristics]

### If You Choose Bootstrap
- First revenue target: $X/mo
- Path to profitability: [timeline]
- Key actions: [list]

### If You Choose to Raise
- Ideal raise amount: $X
- Pre-money target: $X
- Milestones needed: [list]
- Investor profile: [type]
```

### Integration

Could be:
- `/brainstorm:funding` command
- Section in PRODUCT_SPEC.md under "Business Model"
- Parallel agent in research phase

### Key Principles

1. **Raising is not success** — Many great businesses never raise
2. **Realistic scenarios** — Not everyone can/should raise $10M seed
3. **Path flexibility** — Show how to pivot between strategies
4. **Honest about trade-offs** — Dilution, control, pressure
