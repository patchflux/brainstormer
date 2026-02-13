---
created: 2026-02-13T21:38:00.000Z
title: Add strategic hiring and team composition agent
area: agents
files:
  - agents/brainstorm-researcher.md
---

## Problem

Building a product requires the right team. Need an agent that identifies:
1. What skills are missing from the founder
2. Who to hire/partner with strategically
3. How to build a team quickly (freelance, virtual, AI agents)

Currently brainstomer focuses on the product idea but ignores the human capital needed to execute.

## Solution

### Strategic Hiring Agent

Analyzes the idea + founder profile and recommends:

**1. Co-founder Profiles**
- Complementary skills needed (technical, business, domain)
- What gaps in the founding team need filling
- Red flags if going solo on certain ideas

**2. Strategic Hires**
- First 3-5 critical hires
- Roles that unlock growth
- "10x impact" positions vs commodity roles

**3. Freelance/Contract Options**
- What can be outsourced immediately
- Platforms to find talent (Upwork, Toptal, specific marketplaces)
- Tasks that don't need full-time commitment
- Quick wins: "Hire X on Fiverr for Y"

**4. AI/Virtual Team**
- What AI agents can replace human roles
- Automation opportunities
- "Virtual employees" (Claude, GPT, specialized tools)
- Where AI is good enough vs where humans are critical

### Output: Team Composition Report

```markdown
## Recommended Team Composition

### Phase 1: Validation (0-3 months)
- Founder (you): [role]
- Freelance: [roles] via [platforms]
- AI agents: [tasks]

### Phase 2: MVP (3-6 months)
- Co-founder needed: [profile]
- First hire: [role + why]
- Continue outsourcing: [what]

### Phase 3: Growth (6-12 months)
- Key hires: [roles]
- Build vs buy decisions: [areas]
```

### Integration

Could be:
- Dedicated `/brainstorm:team` command
- Section in TECHNICAL_SPEC.md
- Parallel agent in research phase

### Philosophy

"The right team beats the right idea. But the wrong team kills any idea."
