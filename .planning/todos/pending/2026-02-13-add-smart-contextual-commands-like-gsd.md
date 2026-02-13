---
created: 2026-02-13T22:00:00.000Z
title: Add smart contextual commands (like GSD)
area: workflows
files:
  - skills/brainstorm.md
  - workflows/progress.md
---

## Problem

Currently brainstomer has explicit commands (`/brainstorm:new`, `/brainstorm:clarify`, `/brainstorm:specs`). But like GSD, it should have smart commands that:
- Auto-detect current state
- Suggest next steps
- Route to the right action automatically

## Solution

### Smart Commands to Add

**`/brainstorm:progress`** (like `/gsd:progress`)
- Detect: What brainstorm session exists? What phase are we in?
- Show: Current state summary
- Suggest: What to do next
- Route: Auto-launch the right command

```
/brainstorm:progress

📊 Brainstorm Session: "AI-powered pet sitter"

Phase: Research complete, Clarification in progress
Progress: [====------] 40%

Clarification: 3/7 dichotomies answered
- ✓ B2C vs B2B → B2C
- ✓ Mobile vs Web → Mobile-first
- ✓ Premium vs Freemium → Freemium
- ◯ Solo dev vs Team (pending)
- ◯ Bootstrap vs Raise (pending)
- ◯ Niche vs Mass market (pending)
- ◯ MVP scope (pending)

Suggested next: Continue clarification
→ Run /brainstorm:clarify or press [c]
```

**`/brainstorm:resume`** (smart session continuation)
- Find existing session
- Restore context
- Continue where left off
- No need to remember which command to use

**`/brainstorm:status`** (quick state check)
- One-liner showing current phase
- Quick overview without full progress report

**`/brainstorm:next`** (auto-advance)
- Automatically runs the next logical command
- Skip the decision of "what command do I run now?"

**`/brainstorm:help`** (contextual help)
- Show available commands
- Highlight which ones make sense NOW based on state
- Like GSD's help but for brainstorming

### State Detection Logic

```
if no .brainstorm/ exists:
  → suggest /brainstorm:new

if .brainstorm/IDEA.md exists but no research:
  → suggest /brainstorm:new (continue research)

if research done but CLARIFICATION.md incomplete:
  → suggest /brainstorm:clarify

if clarification complete but no specs:
  → suggest /brainstorm:specs

if specs complete:
  → suggest /gsd:new-project --auto
```

### Context Preservation

Like GSD's STATE.md, brainstomer should maintain:
- `.brainstorm/STATE.md` — Current session state
- Last activity timestamp
- Phase progress
- Decisions made
- Resume point

### Smart Routing Philosophy

"The user shouldn't need to remember commands. The system should know where they are and what comes next."

Examples from GSD to mirror:
- `/gsd:progress` → `/brainstorm:progress`
- `/gsd:resume-work` → `/brainstorm:resume`
- `/gsd:help` → `/brainstorm:help`
- Contextual suggestions after each step

### Integration

The smart commands should:
1. Read `.brainstorm/` directory state
2. Parse existing files to understand progress
3. Suggest appropriate next actions
4. Allow one-key shortcuts for common flows
