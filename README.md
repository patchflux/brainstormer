# Brainstomer

**Devil's advocate cofounder bot for Claude Code.**

Challenges your ideas through dichotomy questioning until they're crystal clear — or kills them early.

Not a yes-person. Not an interviewer. A skeptical cofounder who'd rather save you months of wasted effort.

## Why

Most ideas fail because they're vague. "It's for everyone" means no one cares deeply. "We'll figure out monetization later" means you don't have a business.

Brainstomer forces hard choices through binary questions until:
1. The idea becomes obvious (ready to build)
2. Fatal flaws emerge (pivot or kill)
3. The real idea surfaces (often different from the original)

Inspired by [GSD](https://github.com/gsd-build/get-shit-done) — same philosophy of thin orchestrators, parallel agents, and goal-backward thinking.

## Installation

**Quick install (recommended):**
```bash
curl -fsSL https://raw.githubusercontent.com/patchflux/brainstomer/main/install.sh | sh
```

**Manual install:**
```bash
git clone https://github.com/patchflux/brainstomer.git
cd brainstomer
./install.sh
```

Files are installed to `~/.claude/brainstomer/`.

## Commands

| Command | Description |
|---------|-------------|
| `/brainstorm:new` | Start new session (idea → research → clarify) |
| `/brainstorm:clarify` | Resume clarification session |
| `/brainstorm:specs` | Generate specs (after clarification passes) |
| `/brainstorm:help` | Show usage |

## The Flow

```
/brainstorm:new
     │
     ▼
┌─────────────┐
│  Capture    │  "What's the idea?"
│  Raw Idea   │
└─────────────┘
     │
     ▼
┌─────────────┐
│  Research   │  4 parallel agents investigate:
│  (parallel) │  Market, Competitors, Willingness, Timing
└─────────────┘
     │
     ▼
┌─────────────┐
│  Clarify    │  Dichotomy questions until clarity
│  (loop)     │  or kill signal
└─────────────┘
     │
     ├── Clarity achieved → /brainstorm:specs
     ├── Pivot recommended → /brainstorm:new with new angle
     └── Kill recommended → Stop (you saved months)
```

## The Dichotomy Method

Every question is a choice, not an open prompt.

**Bad:** "Who is your target user?"
**Good:** "Is this for developers or non-technical users?"

**Bad:** "What's the main value?"
**Good:** "Does this save time or save money? Pick one."

Forces precision. Reveals priorities. Kills vagueness.

## Kill Signals

Brainstomer watches for these and names them:

| Signal | What It Means |
|--------|---------------|
| Circular reasoning | Answers keep coming back to unproven assumptions |
| Solution-first | Describing features, not problems |
| Everyone problem | Can't narrow down who has the pain |
| No switching cost | Current solutions work fine |
| Timing vacuum | No reason why now vs any other time |

When a kill signal appears, Brainstomer recommends: pivot, kill, or override.

## Clarity Signals

These mean the idea is sharpening:

| Signal | What It Means |
|--------|---------------|
| Specific person | Can describe target user in detail |
| Felt pain | First-hand experience with the problem |
| Clear villain | Knows exactly what they're replacing |
| Obvious trigger | Knows when someone would seek this out |
| Simple pitch | One sentence explains everything |

## Output Files

All files in `.brainstorm/`:

```
.brainstorm/
├── IDEA.md              # Raw idea capture
├── research/
│   ├── MARKET.md        # Who has this problem
│   ├── COMPETITORS.md   # What exists today
│   ├── WILLINGNESS.md   # Will they pay
│   ├── TIMING.md        # Why now
│   └── SUMMARY.md       # Synthesis
├── HISTORY.md           # Full Q&A log
├── PRODUCT_SPEC.md      # Product spec (after clarity)
└── TECHNICAL_SPEC.md    # Technical spec (after clarity)
```

## Integration with GSD

After specs are generated, feed directly into GSD:

```bash
/gsd:new-project --auto @.brainstorm/PRODUCT_SPEC.md
```

This skips GSD's questioning phase (already done) and goes straight to roadmap creation.

## Agents

| Agent | Role |
|-------|------|
| `brainstorm-researcher` | 4 parallel instances investigate market viability |
| `brainstorm-clarifier` | Devil's advocate questioning loop |
| `brainstorm-specwriter` | Synthesizes specs from validated clarity |

## Philosophy

**From GSD:**
- Thin orchestrators, specialized agents
- State files over context bloat
- Goal-backward thinking (what must be TRUE)
- Atomic outputs (each agent writes its file)

**Unique to Brainstomer:**
- Adversarial collaboration (challenge, don't validate)
- Kill early (better than fail slow)
- Dichotomy method (choices, not open prompts)
- Confidence scoring (track clarity progress)

## Example Session

```
/brainstorm:new

> What's the idea?

"A tool that helps developers write better commit messages"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► RESEARCHING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[4 parallel researchers run...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► CLARIFICATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Research found 12 existing tools. Let's see if yours is different.

Q: Is this for individual developers or teams?
  ○ Individual — personal workflow improvement
  ○ Teams — enforcing standards across a team
  ○ Both equally

> Individual

Q: Does this fix bad commits or prevent them?
  ○ Fix — rewrite after the fact
  ○ Prevent — guide during writing
  ○ Both

> Prevent

Q: CLI tool or IDE integration?
  ○ CLI — git hook or standalone
  ○ IDE — VS Code, JetBrains, etc.
  ○ Both

> CLI

[...continues until clarity or kill...]
```

## License

MIT
