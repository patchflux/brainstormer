---
created: 2026-02-13T21:28:00.000Z
title: Add simplifier and market positioning agents
area: agents
files:
  - agents/brainstorm-researcher.md
---

## Problem

Current agents don't explore different strategic positioning options for the idea. Need agents that push the idea in opposite directions to reveal optimal market positioning:

1. **Simplification** — Strip away complexity, find the core
2. **Niche specialization** — High-value narrow market with premium pricing
3. **Mass market** — Broadest possible appeal, generic solution

Sometimes one approach wins, sometimes you need both (mass + premium tiers).

## Solution

### Add 3 new positioning agents:

**1. Simplifier Agent**
- Always asks: "What can we remove?"
- Seeks the minimal viable concept
- Identifies unnecessary complexity
- Goal: Find the essence that solves 80% with 20% effort

**2. Niche Specialist Agent**
- Identifies high-potential narrow markets
- Focuses on premium positioning
- Asks: "Who would pay 10x for a perfect solution?"
- Finds underserved segments with high willingness to pay
- Goal: "Best in world for X specific problem"

**3. Mass Market Agent**
- Seeks broadest possible appeal
- Asks: "How can everyone use this?"
- Identifies lowest common denominator features
- Focuses on accessibility and ease of adoption
- Goal: Volume over margin

### Output
Each agent produces a variant positioning strategy. The orchestrator then:
- Compares the three approaches
- Identifies if hybrid strategy makes sense (mass + premium tiers)
- Recommends which positioning fits the founder's goals
- Shows trade-offs: margin vs volume, focus vs reach

### Example
Idea: "CLI commit message helper"
- **Simplifier**: "Just suggest one message, no config, no options"
- **Niche**: "Enterprise commit compliance for regulated industries (SOC2, HIPAA)"
- **Mass**: "Works with any git client, any language, free forever"

Recommendation might be: Start niche (enterprise compliance), then simplify for mass market later.
