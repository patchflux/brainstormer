---
created: 2026-02-13T21:32:00.000Z
title: Add quick wins philosophy and shortcut finder
area: agents
files:
  - agents/brainstorm-researcher.md
  - agents/brainstorm-clarifier.md
  - agents/brainstorm-specwriter.md
---

## Problem

Need a system that constantly looks for shortcuts and quick wins throughout the brainstorming process. This could be:
1. A dedicated "Quick Wins Agent"
2. A philosophy embedded across all agents at various stages

The goal is to always ask: "What's the fastest path to value? What can we skip? What existing solution can we leverage?"

## Solution

### Option A: Dedicated Quick Wins Agent

A parallel agent that runs alongside others and specifically hunts for:
- Existing solutions to fork/adapt (90% done, just customize)
- No-code/low-code shortcuts
- APIs that solve the hard parts
- Open source projects to build on
- Marketplace integrations instead of building
- MVP shortcuts (landing page before product, Wizard of Oz, etc.)

Output: "Quick Win Report" with shortcuts ranked by effort/impact.

### Option B: Quick Wins Philosophy in All Agents

Embed shortcut-finding mindset across existing agents:

**Researcher agents:**
- Always look for "prior art" — existing solutions, libraries, APIs
- Flag: "You could use X instead of building this"

**Clarifier:**
- Ask: "Could you validate this with [simpler approach] first?"
- Challenge: "Do you really need to build this, or can you buy/integrate?"

**Specwriter:**
- Include "Shortcuts & Alternatives" section in specs
- MVP should default to maximum leverage of existing tools

### Option C: Hybrid

Both — dedicated agent for deep shortcut research + philosophy embedded in all agents.

### Examples of Quick Wins to Find

| Category | Example |
|----------|---------|
| Fork & customize | "There's an open source X, just add Y" |
| API leverage | "Stripe does payments, don't build it" |
| No-code MVP | "Validate with Typeform + Zapier first" |
| Wizard of Oz | "Manually do the AI part until you have 100 users" |
| Existing marketplace | "Be a Shopify app, not a full e-commerce platform" |
| Pre-launch validation | "Landing page + waitlist before writing code" |

### Philosophy Statement

"The best code is no code. The best feature is one that already exists. Always ask: what can we NOT build?"
