<purpose>
Continue or resume a clarification session. Use this when:
- `/brainstorm:new` was paused mid-clarification
- You want to continue pushing on the idea
- Clarification was interrupted
</purpose>

<process>

## 1. Check State

Verify brainstorm exists:

```bash
ls .brainstorm/HISTORY.md 2>/dev/null
```

**If no HISTORY.md:**
```
No brainstorm session found.

Start one: /brainstorm:new
```
Exit workflow.

**If exists:** Read current status from HISTORY.md.

## 2. Load Context

Read:
- `.brainstorm/IDEA.md` — Original idea
- `.brainstorm/research/SUMMARY.md` — Research findings
- `.brainstorm/HISTORY.md` — Previous Q&A

Identify:
- How many questions asked
- Last question/answer
- Any kill signals noted
- Any clarity signals noted
- Recommended focus areas from research

## 3. Resume Clarification

**Display state:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► RESUMING CLARIFICATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Idea:** [one-liner from IDEA.md]
**Questions so far:** [count]
**Last discussed:** [summary of last Q&A]

Picking up where we left off...
```

**Enter clarification loop:**

Continue with brainstorm-clarifier methodology:
- Dichotomy questions
- Log to HISTORY.md
- Watch for kill/clarity signals
- End when clarity emerges or idea should die

## 4. Handle Outcome

Same as `/brainstorm:new` step 4:

**If "Ready for Specs":**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► CLARITY ACHIEVED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Display refined idea summary]

Next: /brainstorm:specs
```

**If "Recommend Pivot" or "Recommend Kill":**
[Same handling as new.md]

</process>

<success_criteria>
- [ ] Previous state loaded correctly
- [ ] Context restored (user doesn't need to repeat)
- [ ] Clarification continues from last point
- [ ] All new Q&A logged to HISTORY.md
- [ ] Session ends with clear status
</success_criteria>
