# Brainstomer

**Devil's advocate cofounder bot for Claude Code.**

## Vision

A tool that challenges ideas through dichotomy questioning until they become crystal clear — or get killed early. Not a yes-person. A skeptical cofounder who saves you months of wasted effort.

## Core Value

**Force clarity through constraint.** Vague ideas stay vague because founders avoid hard choices. Binary questions reveal priorities and kill vagueness.

## Problem

Most ideas fail because they're never forced to be specific:
- "It's for everyone" = no one cares deeply
- "We'll figure out monetization later" = no business model
- "It's like X but better" = no differentiation

Current brainstorming tools either validate everything (useless) or ask open-ended questions (keeps things vague).

## Solution

A 4-phase workflow that transforms fuzzy ideas into actionable specs:

1. **Research** (Autonomous) — 4 parallel agents investigate market, competitors, willingness to pay, timing
2. **Clarification** (Dichotomy) — ONE question at a time, binary/multiple choice, logged Q&A
3. **Product Spec** (Synthesis) — Goal-backward spec: what must be TRUE for success
4. **Technical Spec** (Synthesis) — Architecture derived from product truths

Ends with: clarity achieved, pivot recommended, or kill recommended.

## Target User

Solo developers and indie hackers using Claude Code who:
- Have ideas but need to validate them before building
- Want honest feedback, not cheerleading
- Use GSD or similar spec-driven workflows

## Key Differentiators

1. **Adversarial, not supportive** — Challenges assumptions, names kill signals
2. **Dichotomy method** — Every question is a choice, never open-ended
3. **Kill signals** — Explicitly watches for circular reasoning, solution-first thinking, etc.
4. **GSD integration** — Output feeds directly into `/gsd:new-project --auto`

## Architecture

```
/brainstorm:new
     │
     ├── Capture idea → IDEA.md
     │
     ├── Spawn 4 parallel researchers
     │   ├── brainstorm-researcher (MARKET)
     │   ├── brainstorm-researcher (COMPETITORS)
     │   ├── brainstorm-researcher (WILLINGNESS)
     │   └── brainstorm-researcher (TIMING)
     │
     ├── Synthesize → research/SUMMARY.md
     │
     └── Enter clarification loop
         └── brainstorm-clarifier
             ├── Dichotomy questions
             ├── Log to HISTORY.md
             ├── Watch for kill/clarity signals
             └── End: Ready / Pivot / Kill

/brainstorm:specs (after clarity)
     │
     └── brainstorm-specwriter
         ├── PRODUCT_SPEC.md
         └── TECHNICAL_SPEC.md
```

## File Structure

```
brainstomer/
├── agents/
│   ├── brainstorm-researcher.md    # 4 parallel research instances
│   ├── brainstorm-clarifier.md     # Devil's advocate questioning
│   └── brainstorm-specwriter.md    # Spec generation
├── commands/brainstorm/
│   ├── new.md                      # Start session
│   ├── clarify.md                  # Resume clarification
│   ├── specs.md                    # Generate specs
│   └── help.md                     # Usage help
├── workflows/
│   ├── new.md                      # Full flow orchestration
│   ├── clarify.md                  # Resume flow
│   └── specs.md                    # Spec generation flow
├── references/
│   └── questioning.md              # Dichotomy method guide
├── templates/
│   ├── IDEA.md
│   ├── HISTORY.md
│   ├── PRODUCT_SPEC.md
│   ├── TECHNICAL_SPEC.md
│   └── research/
│       ├── MARKET.md
│       ├── COMPETITORS.md
│       ├── WILLINGNESS.md
│       ├── TIMING.md
│       └── SUMMARY.md
├── PROJECT.md                      # This file
└── README.md                       # User documentation
```

## Output Files (per session)

Generated in `.brainstorm/`:

| File | Phase | Purpose |
|------|-------|---------|
| `IDEA.md` | Capture | Raw idea dump |
| `research/MARKET.md` | Research | Who has this problem |
| `research/COMPETITORS.md` | Research | What exists today |
| `research/WILLINGNESS.md` | Research | Will they pay |
| `research/TIMING.md` | Research | Why now |
| `research/SUMMARY.md` | Research | Synthesis |
| `HISTORY.md` | Clarification | Full Q&A log |
| `PRODUCT_SPEC.md` | Specs | Product specification |
| `TECHNICAL_SPEC.md` | Specs | Technical specification |

## Design Principles (from GSD)

1. **Thin orchestrators** — Commands delegate to workflows, workflows spawn agents
2. **Specialized agents** — Each agent does ONE thing well
3. **State files over context** — Persist to disk, not memory
4. **Goal-backward thinking** — Start from "what must be TRUE"
5. **Atomic outputs** — Each agent writes its own file

## Design Principles (unique to Brainstomer)

1. **Adversarial collaboration** — Challenge, don't validate
2. **Kill early** — Better to stop a bad idea than watch it fail
3. **Dichotomy method** — Choices, not open prompts
4. **Signal detection** — Explicitly name kill/clarity signals
5. **Confidence tracking** — Know when clarity is emerging

## Kill Signals

Patterns that suggest the idea isn't ready:

| Signal | Meaning |
|--------|---------|
| Circular reasoning | Answers keep returning to unproven assumptions |
| Solution-first | Describing features, not problems |
| Everyone problem | Can't narrow down who has the pain |
| No switching cost | Current solutions work fine |
| Timing vacuum | No reason why now vs any other time |

## Clarity Signals

Patterns that suggest the idea is sharpening:

| Signal | Meaning |
|--------|---------|
| Specific person | Can describe target user in detail |
| Felt pain | First-hand experience with problem |
| Clear villain | Knows what they're replacing |
| Obvious trigger | Knows when someone would seek this |
| Simple pitch | One sentence explains everything |

## Commands

| Command | Description |
|---------|-------------|
| `/brainstorm:new` | Start new session |
| `/brainstorm:clarify` | Resume clarification |
| `/brainstorm:specs` | Generate specs (after clarity) |
| `/brainstorm:help` | Show usage |

## Integration

After specs generated:
```
/gsd:new-project --auto @.brainstorm/PRODUCT_SPEC.md
```

This feeds the validated spec into GSD for implementation planning.

## Status

- [x] Agent prompts designed
- [x] Workflows created
- [x] Commands created
- [x] Reference guides written
- [x] Templates created
- [x] README documentation
- [ ] Installer script
- [ ] Real-world testing
- [ ] Iteration based on usage

## Inspiration

- [GSD (Get Shit Done)](https://github.com/gsd-build/get-shit-done) — Thin orchestrators, parallel agents, goal-backward specs
- Y Combinator application questions — Forcing specificity
- The Mom Test — Challenging assumptions about customer problems
