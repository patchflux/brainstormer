# Testing Patterns

**Analysis Date:** 2026-02-13

## Testing Model

**Framework:** Not detected

This codebase is a documentation/instruction system for Claude Code agents and workflows, not traditional software requiring unit testing. Quality assurance happens through:
1. Human review of agent outputs (research, clarification, specs)
2. Verification against quality gates built into each agent
3. File-based assertions (output files exist with required structure)

**Test Entry Points:**
- `.planning/codebase/TESTING.md` (this file)
- Quality gates embedded in agent instructions
- Success criteria in workflow definitions

## Quality Gates as Tests

**Concept:**
Each agent has embedded quality gates that act as post-execution verification. These are explicit checklists that must pass before the agent completes.

**Pattern location:** Every agent has a `<quality_gates>` section

### Brainstorm-Researcher Quality Gates

**File:** `agents/brainstorm-researcher.md` (lines 172-181)

```
Before returning, verify:

- [ ] At least 3 concrete sources cited (not just "various forums")
- [ ] Both risks AND opportunities identified (not one-sided)
- [ ] Confidence level justified by actual findings
- [ ] Bottom line is actionable (not wishy-washy)
- [ ] No cheerleading — honest assessment even if negative
```

**What it validates:**
- Source quality (3+ concrete sources, not vague references)
- Balanced analysis (both risks and opportunities)
- Justified confidence levels (confidence level tied to evidence)
- Actionability (verdict is clear and usable)
- Tone consistency (honest, not promotional)

**When checked:** After research file written, before returning from brainstorm-researcher agent

### Brainstorm-Specwriter Quality Gates

**File:** `agents/brainstorm-specwriter.md` (lines 430-449)

**Product Spec checks:**
- [ ] One-liner is actually one sentence
- [ ] Success criteria are observable/measurable
- [ ] MVP has 5 or fewer features
- [ ] Out-of-scope list exists and is reasoned
- [ ] Risks include the ones from clarification
- [ ] Business model is specific, not "freemium"

**Technical Spec checks:**
- [ ] Stack choices have rationale
- [ ] Data model covers all MVP features
- [ ] API design matches product features
- [ ] Phases are sequential and dependency-aware
- [ ] Security isn't "TBD"
- [ ] No gold-plating (features beyond MVP)

**What they validate:**
- Product Spec: conciseness, measurability, scope discipline, scope clarity, risk tracking, business specificity
- Technical Spec: decision rationale, coverage, alignment, sequencing, security completeness, scope boundaries

**When checked:** After both specs written, before `/brainstorm:specs` completion

## Success Criteria as Test Specifications

**Concept:**
Each workflow defines explicit success criteria that are verifiable checkpoints.

### New Session Workflow Success Criteria

**File:** `workflows/new.md` (lines 344-352)

```
- [ ] Idea captured verbatim
- [ ] 4 research agents spawned in parallel
- [ ] Research synthesized into SUMMARY.md
- [ ] User chose to proceed, pause, or read more
- [ ] Clarification entered (if proceeded)
- [ ] Every question logged to HISTORY.md
- [ ] Session ended with clear status (clarity/pivot/kill)
- [ ] User knows next steps
```

**What it validates:**
- Idea capture: Input integrity (captured exactly as stated, not interpreted)
- Agent orchestration: Parallelism (4 agents run in parallel)
- Synthesis: Output quality (SUMMARY exists and aggregates research)
- User interaction: Choice handling (all branches handled)
- State persistence: Logging (HISTORY.md maintained)
- Completion clarity: Session end state clear to user

**When checked:** At end of `/brainstorm:new` workflow execution

### Clarification Session Success Criteria

Embedded in `agents/brainstorm-clarifier.md` - ending conditions section (lines 271-320):

**Ready for Specs condition:**
- Idea can be filled into template with confidence:
  - One-liner (single sentence)
  - Target (specific person with specific problem)
  - Problem (pain point in their words)
  - Trigger (when they'd seek this out)
  - Solution (what you're building, simply stated)
  - Alternative (what they use today)
  - Differentiation (why this beats the alternative)
  - Business model (how you make money)

**What it validates:**
- Specificity (real person, not generic)
- Problem clarity (stated in user's language, not jargon)
- Solution grounding (not abstract)
- Market context (knows the alternative)
- Differentiation clarity (explicit)
- Business model existence (not "TBD")

## Verification Through File Structure

**Pattern:**
Test assertions happen by checking output files exist and contain required sections.

**Brainstorm-Clarifier verifications:**
- `HISTORY.md` exists and contains full Q&A log
- Every question is categorized (WHO/WHAT/WHY/HOW)
- Follow-up reasoning documented
- Session status clearly stated

See: `agents/brainstorm-clarifier.md` (lines 230-268 - history logging template)

**Brainstorm-Researcher verifications:**
- Research output file exists (e.g., `MARKET.md`)
- Contains Key Findings section (at least 3 findings)
- Contains Signal Quality table with actual rows
- Bottom line section answers the research question

See: `agents/brainstorm-researcher.md` (lines 121-169 - output format expectations)

**Brainstorm-Specwriter verifications:**
- `PRODUCT_SPEC.md` contains all required sections:
  - The Problem (Who/What/Why/Current)
  - The Solution (One-liner/Value/Why Us)
  - Success Criteria (What must be true / Key Metrics)
  - MVP Scope (5 or fewer features)
  - User Journey
  - Business Model
  - Risks & Mitigations
- `TECHNICAL_SPEC.md` contains all required sections:
  - Architecture Overview
  - Technology Stack with rationale
  - Data Model
  - API Design
  - Implementation Phases
  - Security Considerations

See: `agents/brainstorm-specwriter.md` (lines 76-426)

## Kill Signal Detection as Failure Test

**Pattern:**
Specific anti-patterns are detected and named. Detection counts as a test failure that prevents proceeding.

**Kill signals (from `agents/brainstorm-clarifier.md`, lines 181-202):**

1. **Circular reasoning** — answers keep coming back to the same weak point
   - Test: Multiple questions return to same unproven assumption
   - Action: Flag for user decision (pivot/kill/override)

2. **Solution-first** — user keeps describing features, not problems
   - Test: Answer focuses on features rather than pain point
   - Action: Challenge with "specifically, what problem does this solve?"

3. **Everyone problem** — can't narrow down who actually has this pain
   - Test: Target user is still generic after WHO questions
   - Action: Force binary choice until specific person emerges

4. **No switching cost** — nothing wrong with current solutions
   - Test: User can't identify inadequacy in alternative
   - Action: Challenge on specificity of current pain

5. **Timing vacuum** — no reason why now vs any other time
   - Test: No enabling event or forcing function articulated
   - Action: Stress test timing assumptions

**When these are checked:** During clarification questioning loop

## Clarity Signal Detection as Success Test

**Pattern:**
Specific signals indicate the idea has reached clarity (test passes).

**Clarity signals (from `agents/brainstorm-clarifier.md`, lines 204-226):**

1. **Specific person** — can describe the user in detail
   - Test: WHO questions answered with concrete person (role, context, demographics)
   - Pass condition: Could recognize this person if you met them

2. **Felt pain** — user has experienced or witnessed the problem firsthand
   - Test: Problem is validated through personal experience or direct observation
   - Pass condition: Story exists demonstrating the pain

3. **Clear villain** — knows exactly what they're replacing
   - Test: Can articulate specific current solution and its inadequacy
   - Pass condition: Alternative is named and criticism is specific

4. **Obvious trigger** — knows when someone would seek this out
   - Test: Trigger event or condition is articulated
   - Pass condition: "When X happens, they'd want this"

5. **Simple pitch** — can explain in one sentence
   - Test: One-liner can be spoken aloud in under 10 seconds
   - Pass condition: Non-expert understands who/what/why

**When these are checked:** Throughout clarification loop, officially at end

## Confidence Scoring as Continuous Testing

**Pattern:**
Confidence level (1-10) acts as a running test score that indicates how far through validation the idea has progressed.

**Checkpoint pattern (from `agents/brainstorm-clarifier.md`, lines 166-179):**

```
Every ~10 questions, pause:

AskUserQuestion:
- header: "Check-in"
- question: "How clear does the idea feel now?"
- options:
  - "Clearer than before" — keep going
  - "About the same" — we need to dig differently
  - "More confused" — something's wrong
  - "Crystal clear" — maybe we're done
```

**What it validates:**
- Progression (clarity increasing)
- Method effectiveness (if "about the same", change approach)
- Regression detection (if "more confused", issue found)
- Completion indication (if "crystal clear", approaching end)

## Return Format Verification

**Pattern:**
Each agent's return format is a test specification. The return must contain all required fields.

### Brainstorm-Researcher Return Format

**File:** `agents/brainstorm-researcher.md` (lines 184-199)

Required fields in return:
- Dimension (MARKET/COMPETITORS/WILLINGNESS/TIMING)
- Confidence (High/Medium/Low)
- Verdict (Promising/Concerning/Neutral)
- Key finding (one sentence, most important discovery)
- File path (proof of writing)

**What it validates:**
- Agent completed its research
- Confidence is explicit
- Verdict is clear
- File written to correct location

### Brainstorm-Clarifier Return Format

**File:** `agents/brainstorm-clarifier.md` (lines 346-374)

Required fields:
- Status (Ready for Specs / Recommend Pivot / Recommend Kill)
- Questions asked (count)
- Sessions (count)
- Final confidence (1-10)
- The Idea (one-liner, if ready)
- For (target)
- Problem (pain)
- Solution (what)
- Why Now (timing)
- Key Risks Acknowledged (list)
- Files (HISTORY.md path)

**What it validates:**
- Clarification session completed
- Clear exit status determined
- Question count tracked
- Confidence quantified
- Refined idea captured
- Risk awareness documented

## Decision Log as Audit Trail

**Pattern:**
All important decisions are logged in Decision Log table format. This provides traceability for testing how decisions affect outcomes.

**Format (from `agents/brainstorm-specwriter.md`, lines 226-231):**

```
| Decision | Options Considered | Choice | Rationale |
|----------|-------------------|--------|-----------|
| [What] | [A, B, C] | [Choice] | [Why] |
```

**What it enables:**
- Traceability (can understand how spec was derived)
- Reversibility (can revisit decision if assumptions change)
- Learning (can analyze which decisions led to success/failure)

See: `templates/PRODUCT_SPEC.md` (lines 143-147)

## Testing the Testing System

**Meta-pattern:**
Quality gates themselves have acceptance criteria (lines in quality_gates sections).

**Example from `agents/brainstorm-specwriter.md`:**

Quality gate "One-liner is actually one sentence" is testable:
- Can be counted (contains exactly 1 period + capital letter start)
- Can be timed (speaks in <10 seconds)
- Can be validated (naive reader understands it)

## No Formal Test Framework

**Why:**
- This is documentation + instruction system, not executable code
- Validation happens through:
  - Output file structure verification
  - Content completeness checks (all required sections present)
  - Quality gate checklists
  - Kill/clarity signal detection
  - Confidence tracking
  - Human review of outputs

**Where to test:**
- Run `/brainstorm:new` with a test idea
- Verify all output files created in `.brainstorm/` directory
- Verify HISTORY.md contains logged Q&A
- Verify quality gates from specwriter produce valid Product/Technical specs

---

*Testing analysis: 2026-02-13*
