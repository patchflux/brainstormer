---
description: Show available Brainstomer commands
---

<command>
Display help for Brainstomer:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER — Devil's Advocate Cofounder
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

I help you clarify ideas until they're obvious — or kill them early.

## Commands

| Command | Description |
|---------|-------------|
| /brainstorm:new | Start new session (idea → research → clarify) |
| /brainstorm:clarify | Resume clarification |
| /brainstorm:specs | Generate specs (after clarification passes) |
| /brainstorm:help | This help |

## The Flow

1. **New** — Dump your idea, I research and challenge it
2. **Clarify** — Dichotomy questions until clarity or death
3. **Specs** — If idea survives, generate product + technical specs

## Output Files

All files in `.brainstorm/`:

| File | Description |
|------|-------------|
| IDEA.md | Raw idea capture |
| research/*.md | Market, competitors, willingness, timing |
| HISTORY.md | Full Q&A log from clarification |
| PRODUCT_SPEC.md | Product specification (after specs) |
| TECHNICAL_SPEC.md | Technical specification (after specs) |

## Integration with GSD

After specs are generated:
```
/gsd:new-project --auto @.brainstorm/PRODUCT_SPEC.md
```

This feeds your validated spec directly into GSD for implementation.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</command>
