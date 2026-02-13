---
created: 2026-02-13T21:35:00.000Z
title: Add landing page generator phase for early validation
area: workflows
files:
  - workflows/new.md
  - templates/LANDING_PAGE.md
---

## Problem

Before building anything, need to validate if people will actually pay for the idea. Currently brainstomer goes from idea → research → specs → GSD implementation. Missing a critical early phase: **market validation with a real landing page**.

Need to generate a monetizable landing page very early in the process to test the hypothesis before writing any code.

## Solution

### New Phase: Landing Page Generation

Add a phase after research/clarification that generates:

1. **Landing Page Content**
   - Headline (value proposition)
   - Subheadline (what it does)
   - Pain points addressed
   - Benefits/features (3-5 max)
   - Social proof placeholders
   - CTA (Call to Action)
   - Pricing tiers (if applicable)

2. **Payment Integration**
   - Stripe checkout link
   - Or "Join waitlist" with email capture
   - Pre-order option with refund guarantee

3. **Output Formats**
   - HTML template (ready to deploy)
   - Markdown for static site generators
   - Copy for Carrd/Webflow/Framer

### Workflow Integration

```
/brainstorm:new
  → Research (4 agents)
  → Clarification
  → /brainstorm:landing   <-- NEW
  → /brainstorm:specs
  → /gsd:new-project
```

### Landing Page Agent

Specialized agent that:
- Writes compelling sales copy (not technical)
- Uses research findings to address objections
- Creates urgency without being sleazy
- Includes pricing psychology
- Generates actual deployable HTML

### Validation Metrics

The landing page should help measure:
- Conversion rate (visitors → signups/payments)
- Price sensitivity (A/B test different prices)
- Feature interest (which benefits get clicks)
- Willingness to pay (actual pre-orders)

### Philosophy

"Don't build what people won't buy. Sell it first, then build it."

If the landing page doesn't convert → pivot or kill the idea before wasting time on implementation.
