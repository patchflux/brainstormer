<purpose>
Generate product and technical specs from validated clarification. Only runs after clarification reaches "Ready for Specs" status.
</purpose>

<prerequisites>
- `.brainstorm/HISTORY.md` exists with "Status: Ready for Specs"
- Clarification complete with clarity achieved
</prerequisites>

<process>

## 1. Validate Prerequisites

Check that clarification is complete:

```bash
grep -q "Ready for Specs\|Ready for specs\|READY FOR SPECS" .brainstorm/HISTORY.md 2>/dev/null
```

**If not ready:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► NOT READY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Clarification hasn't reached "Ready for Specs" status yet.

Current status: [read from HISTORY.md]

Next: /brainstorm:clarify — continue the clarification session
```
Exit workflow.

## 2. Load Context

Read all relevant files:
- `.brainstorm/IDEA.md`
- `.brainstorm/research/SUMMARY.md`
- `.brainstorm/HISTORY.md`

Extract the refined idea from clarification:
- One-liner
- Target user
- Problem
- Solution approach
- Business model
- Key decisions made
- Risks acknowledged

## 3. Generate Specs

**Display stage:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► GENERATING SPECS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Synthesizing research and clarification into specs...
```

**Spawn specwriter agent:**

```
Task(prompt="
Read your instructions: @agents/brainstorm-specwriter.md

<context>
**Idea:** @.brainstorm/IDEA.md
**Research:** @.brainstorm/research/SUMMARY.md
**Clarification:** @.brainstorm/HISTORY.md
</context>

<output>
Write both:
- .brainstorm/PRODUCT_SPEC.md
- .brainstorm/TECHNICAL_SPEC.md
</output>
", subagent_type="brainstorm-specwriter", description="Generate specs")
```

## 4. Present Results

**Display completion:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 BRAINSTOMER ► SPECS COMPLETE ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Product Spec

[Display key sections from PRODUCT_SPEC.md]
- One-liner
- Target user
- MVP features (list)
- Success criteria

## Technical Spec

[Display key sections from TECHNICAL_SPEC.md]
- Stack overview
- Phase count
- Key architecture decisions

---

**Files:**
- .brainstorm/PRODUCT_SPEC.md
- .brainstorm/TECHNICAL_SPEC.md

---
```

## 5. Offer Next Steps

Use AskUserQuestion:

```
- header: "Next"
- question: "What do you want to do with these specs?"
- options:
  - "Review in detail" — Show me the full specs
  - "Revise" — I want to change something
  - "Build with GSD" — Start implementation
  - "Done for now" — I'll review later
```

**If "Review in detail":**
Display full PRODUCT_SPEC.md, then TECHNICAL_SPEC.md.

**If "Revise":**
```
What do you want to change?

Options:
- Edit PRODUCT_SPEC.md directly
- Edit TECHNICAL_SPEC.md directly
- Run /brainstorm:clarify to adjust decisions
- Tell me what to change and I'll update
```

**If "Build with GSD":**
```
To start building with GSD:

/gsd:new-project --auto @.brainstorm/PRODUCT_SPEC.md

This will:
1. Use your product spec as the idea document
2. Skip deep questioning (already done)
3. Create requirements from your spec
4. Generate a buildable roadmap

Ready? Run the command above in a fresh context (/clear first).
```

**If "Done for now":**
```
Your specs are saved:
- .brainstorm/PRODUCT_SPEC.md
- .brainstorm/TECHNICAL_SPEC.md

When ready to build: /gsd:new-project --auto @.brainstorm/PRODUCT_SPEC.md

When ready to revise: /brainstorm:revise
```

</process>

<output>
- `.brainstorm/PRODUCT_SPEC.md`
- `.brainstorm/TECHNICAL_SPEC.md`
</output>

<success_criteria>
- [ ] Clarification status verified as "Ready for Specs"
- [ ] All context files read
- [ ] Specwriter agent spawned with full context
- [ ] PRODUCT_SPEC.md created with all sections
- [ ] TECHNICAL_SPEC.md created with all sections
- [ ] User knows how to proceed to building
</success_criteria>
