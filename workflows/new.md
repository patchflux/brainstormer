<purpose>
Start a new brainstorming session. Captures the initial idea, runs research, then enters clarification mode. The goal is to transform a fuzzy idea into crystal clarity — or kill it early.
</purpose>

<process>

## 1. Capture the Idea

**Display welcome:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► NEW SESSION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

I'm your devil's advocate cofounder.

My job: Challenge your idea until it's crystal clear or we kill it.
Not to validate. Not to be nice. To find truth.

Let's see what you've got.
```

**Ask for the idea (inline, not AskUserQuestion):**

```
What's the idea? Don't overthink it — just dump what's in your head.
```

Wait for response.

**Create directory and capture:**

```bash
mkdir -p .brainstorm/research
```

Write `.brainstorm/IDEA.md`:

```markdown
# Idea Capture

**Captured:** [timestamp]
**Status:** Raw — needs research and clarification

## The Dump

[User's raw idea exactly as stated]

## Initial Observations

[Your quick read on what this might be about — categories, assumptions, questions that come to mind]

---

*This is the raw input. Research and clarification will refine it.*
```

**Confirm capture:**

```
Got it. I've captured the raw idea.

Before I start poking holes, let me see what's out there.
```

## 2. Research Phase

**Display stage:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► RESEARCHING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Spawning 4 researchers in parallel...
  → Market research (who has this problem)
  → Competitor research (what exists)
  → Willingness research (will they pay)
  → Timing research (why now)

This takes a minute. I'm actually searching, not making things up.
```

**Spawn 4 parallel brainstorm-researcher agents:**

```
Task(prompt="
Read your instructions: @agents/brainstorm-researcher.md

<dimension>MARKET</dimension>

<idea>
[Paste from IDEA.md]
</idea>

<output>
Write to: .brainstorm/research/MARKET.md
</output>
", subagent_type="brainstorm-researcher", description="Market research")

Task(prompt="
Read your instructions: @agents/brainstorm-researcher.md

<dimension>COMPETITORS</dimension>

<idea>
[Paste from IDEA.md]
</idea>

<output>
Write to: .brainstorm/research/COMPETITORS.md
</output>
", subagent_type="brainstorm-researcher", description="Competitor research")

Task(prompt="
Read your instructions: @agents/brainstorm-researcher.md

<dimension>WILLINGNESS</dimension>

<idea>
[Paste from IDEA.md]
</idea>

<output>
Write to: .brainstorm/research/WILLINGNESS.md
</output>
", subagent_type="brainstorm-researcher", description="Willingness research")

Task(prompt="
Read your instructions: @agents/brainstorm-researcher.md

<dimension>TIMING</dimension>

<idea>
[Paste from IDEA.md]
</idea>

<output>
Write to: .brainstorm/research/TIMING.md
</output>
", subagent_type="brainstorm-researcher", description="Timing research")
```

**Synthesize research:**

After all 4 complete, read each file and write `.brainstorm/research/SUMMARY.md`:

```markdown
# Research Summary

**Idea:** [one-liner from IDEA.md]
**Researched:** [timestamp]

## Overall Assessment

| Dimension | Verdict | Confidence | Key Finding |
|-----------|---------|------------|-------------|
| Market | [Promising/Concerning/Neutral] | [H/M/L] | [1 sentence] |
| Competitors | [Promising/Concerning/Neutral] | [H/M/L] | [1 sentence] |
| Willingness | [Promising/Concerning/Neutral] | [H/M/L] | [1 sentence] |
| Timing | [Promising/Concerning/Neutral] | [H/M/L] | [1 sentence] |

## Signal Strength: [Strong/Moderate/Weak/Mixed]

[2-3 sentences on overall research quality and what it suggests]

## Top Concerns

1. [Concern from research + which dimension]
2. [Concern from research + which dimension]
3. [Concern from research + which dimension]

## Top Opportunities

1. [Opportunity from research + which dimension]
2. [Opportunity from research + which dimension]

## Clarification Focus

Based on research, the clarification session should probe:

1. [Question/area that emerged from research]
2. [Question/area that emerged from research]
3. [Question/area that emerged from research]

---

*Full research in individual files: MARKET.md, COMPETITORS.md, WILLINGNESS.md, TIMING.md*
```

**Present research summary:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► RESEARCH COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Display SUMMARY.md table and key findings]

---

The research gives us context. Now let's stress-test the idea.
```

## 3. Clarification Decision

Use AskUserQuestion:

```
- header: "Next"
- question: "Ready to enter clarification? This is where I challenge your assumptions."
- options:
  - "Let's go" — Start the dichotomy questioning
  - "Show full research" — I want to read all the details first
  - "Pause here" — I need to think about this research
```

**If "Show full research":** Display each research file, then re-ask.

**If "Pause here":**
```
Understood. Your research is saved in `.brainstorm/research/`.

When ready: `/brainstorm:clarify` to continue.
```
Exit workflow.

**If "Let's go":** Continue to step 4.

## 4. Enter Clarification

**Display stage:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► CLARIFICATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Ground rules:
- I ask, you choose (no open-ended questions)
- Every answer gets logged
- I'll push back on weak reasoning
- We stop when clarity emerges or the idea dies

Based on the research, I'm starting with [biggest question from research].
```

**Initialize HISTORY.md:**

```markdown
# Clarification History

**Idea:** [one-liner]
**Started:** [timestamp]
**Status:** In Progress

---

## Session 1

[Questions will be logged here]
```

**Begin clarification loop:**

Spawn brainstorm-clarifier (or execute inline if simpler):

The clarifier will:
1. Ask dichotomy questions based on research concerns
2. Log each Q&A to HISTORY.md
3. Track kill signals and clarity signals
4. End when clarity emerges, pivot recommended, or kill recommended

**Handle clarifier return:**

**If "Ready for Specs":**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► CLARITY ACHIEVED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Display the refined idea summary from clarifier]

The idea survived scrutiny. Ready for specs.

Next: /brainstorm:specs
```

**If "Recommend Pivot":**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► PIVOT RECOMMENDED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

The original angle isn't working, but something else emerged:

[Pivot description from clarifier]

Options:
- /brainstorm:new — Start fresh with the pivot
- /brainstorm:clarify — Continue exploring current direction
- Review .brainstorm/HISTORY.md — See how we got here
```

**If "Recommend Kill":**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► KILL RECOMMENDED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

I don't think this idea is ready to build.

[Kill reasoning from clarifier]

This session is valuable even if we don't proceed — you learned:
[Key learnings from clarification]

Options:
- /brainstorm:new — Start with a different idea
- /brainstorm:clarify — Override my recommendation and continue
- Archive this in .brainstorm/archive/
```

</process>

<output>

**Always created:**
- `.brainstorm/IDEA.md` — Raw idea capture
- `.brainstorm/research/MARKET.md`
- `.brainstorm/research/COMPETITORS.md`
- `.brainstorm/research/WILLINGNESS.md`
- `.brainstorm/research/TIMING.md`
- `.brainstorm/research/SUMMARY.md`
- `.brainstorm/HISTORY.md` — Q&A log (started)

**If clarification completes to "Ready for Specs":**
- HISTORY.md updated with "Status: Ready for Specs"
- Summary of refined idea logged

</output>

<success_criteria>
- [ ] Idea captured verbatim
- [ ] 4 research agents spawned in parallel
- [ ] Research synthesized into SUMMARY.md
- [ ] User chose to proceed, pause, or read more
- [ ] Clarification entered (if proceeded)
- [ ] Every question logged to HISTORY.md
- [ ] Session ended with clear status (clarity/pivot/kill)
- [ ] User knows next steps
</success_criteria>
