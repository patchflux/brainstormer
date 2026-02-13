# Architecture

**Analysis Date:** 2026-02-13

## Pattern Overview

**Overall:** Multi-agent orchestration with specialized workflows.

**Key Characteristics:**
- Thin orchestration layer that spawns parallel specialized agents
- State-driven using persistent markdown files in `.brainstorm/`
- Goal-backward thinking from core problem to implementation
- Clear handoff between phases with explicit status gates

## Layers

**Orchestration Layer:**
- Purpose: Route commands to appropriate workflows, manage state transitions
- Location: `commands/brainstorm/`
- Contains: Command definitions that trigger workflows
- Depends on: Workflows and agents
- Used by: Claude Code user interface via `/brainstorm:` commands

**Workflow Layer:**
- Purpose: Coordinate multi-step processes with explicit control flow
- Location: `workflows/`
- Contains: Process definitions for new sessions, resuming clarification, spec generation
- Depends on: Agents to execute individual tasks
- Used by: Commands trigger workflows; workflows spawn agents

**Agent Layer:**
- Purpose: Specialized Claude instances performing focused work
- Location: `agents/`
- Contains: Three agent types: researcher, clarifier, specwriter
- Depends on: Input files and context from previous phases
- Used by: Workflows spawn agents with task context

**State/Persistence Layer:**
- Purpose: Store session state and artifacts between interactions
- Location: `.brainstorm/` directory (output location, not part of codebase)
- Contains: IDEA.md, research/, HISTORY.md, PRODUCT_SPEC.md, TECHNICAL_SPEC.md

**Reference/Configuration Layer:**
- Purpose: Operational guides and shared knowledge
- Location: `references/`, `templates/`
- Contains: Dichotomy questioning methodology, output templates
- Used by: Agents reference these during execution

## Data Flow

**New Session Flow:**

1. **Capture** (`/brainstorm:new` command → `workflows/new.md` step 1)
   - User describes raw idea via inline prompt
   - `workflows/new.md` writes `.brainstorm/IDEA.md` with verbatim capture

2. **Research** (`workflows/new.md` step 2)
   - Four parallel `brainstorm-researcher` agents spawned from `agents/brainstorm-researcher.md`
   - Each researches one dimension: MARKET, COMPETITORS, WILLINGNESS, TIMING
   - Each writes to `.brainstorm/research/[DIMENSION].md`
   - Orchestrator waits for all four to complete, then synthesizes to `.brainstorm/research/SUMMARY.md`

3. **User Decision** (`workflows/new.md` step 3)
   - Summarized research presented via AskUserQuestion
   - User chooses: proceed to clarification, review full research, or pause

4. **Clarification** (`workflows/new.md` step 4 → runs `brainstorm-clarifier` from `agents/brainstorm-clarifier.md`)
   - Dichotomy questions asked one at a time
   - Each Q&A logged to `.brainstorm/HISTORY.md`
   - Loop continues until: clarity emerges, pivot recommended, or kill recommended
   - Outputs: Updated `.brainstorm/HISTORY.md` with final status

**Resume Clarification Flow:**

1. **State Check** (`workflows/clarify.md` step 1)
   - Verify `.brainstorm/HISTORY.md` exists

2. **Load Context** (`workflows/clarify.md` step 2)
   - Read: IDEA.md, research/SUMMARY.md, HISTORY.md
   - Extract current question count, last Q&A, signals observed

3. **Resume** (`workflows/clarify.md` step 3-4)
   - Same clarification agent continues from last logged point
   - HISTORY.md updated with new Q&A

**Spec Generation Flow:**

1. **Prerequisite Check** (`workflows/specs.md` step 1)
   - Verify HISTORY.md contains "Ready for Specs" status

2. **Load Context** (`workflows/specs.md` step 2)
   - Read: IDEA.md, research/SUMMARY.md, HISTORY.md (full clarification history)
   - Extract: refined one-liner, target user, problem, solution, business model, decisions

3. **Generate** (`workflows/specs.md` step 3)
   - Spawn `brainstorm-specwriter` with all context
   - Specwriter reads template structures from `templates/PRODUCT_SPEC.md` and `templates/TECHNICAL_SPEC.md`
   - Outputs: `.brainstorm/PRODUCT_SPEC.md` and `.brainstorm/TECHNICAL_SPEC.md`

4. **Present & Offer Next** (`workflows/specs.md` step 4-5)
   - Summary displayed, user offered options: review, revise, build with GSD, or done

## State Management

**Session State Container:**
- Root: `.brainstorm/` directory (creates on first run)
- Persists: All ideas, research, Q&A, decisions across sessions
- Per-session: One IDEA drives all downstream files

**State Transitions:**

```
Initial Idea
    ↓
[IDEA.md written]
    ↓
Research Phase (4 parallel)
    ↓
[MARKET.md, COMPETITORS.md, WILLINGNESS.md, TIMING.md, SUMMARY.md written]
    ↓
User Decision (pause/continue/view)
    ↓
Clarification Loop (repeatable)
    ↓
[HISTORY.md written/appended]
    ↓
Kill / Pivot / Ready for Specs
    ↓
[If Ready] Spec Generation
    ↓
[PRODUCT_SPEC.md, TECHNICAL_SPEC.md written]
```

**Status Markers in HISTORY.md:**
- `Status: In Progress` — Session ongoing
- `Status: Ready for Specs` — Clarification complete, specs can be generated
- `Status: Recommend Pivot` — Original angle unviable, alternative emerged
- `Status: Recommend Kill` — Insufficient evidence to proceed

## Key Abstractions

**Agent Abstraction:**
- Purpose: Encapsulate specialized Claude capabilities
- Examples: `agents/brainstorm-researcher.md`, `agents/brainstorm-clarifier.md`, `agents/brainstorm-specwriter.md`
- Pattern: YAML header (name, description, tools) + `<role>` section defining persona + operational guidelines
- Workflow spawns agent with Task() call, providing dimension/context as parameters

**Workflow Abstraction:**
- Purpose: Multi-step orchestration with decision points
- Examples: `workflows/new.md` (4-step process), `workflows/clarify.md` (resume logic), `workflows/specs.md` (prerequisites check)
- Pattern: XML-structured steps (purpose → process → output → success_criteria)
- Handles: State verification, agent spawning, result synthesis, user interactions

**Command Abstraction:**
- Purpose: User-facing entry points
- Examples: `/brainstorm:new`, `/brainstorm:clarify`, `/brainstorm:specs`
- Pattern: Minimal wrapper in `commands/brainstorm/*.md` that references workflow to execute
- Delegation: Actual work delegated to workflow layer

**Dichotomy Question Pattern:**
- Purpose: Force specificity and reveal priorities
- Defined in: `references/questioning.md`
- Used by: `brainstorm-clarifier` agent
- Pattern: Binary/ternary choices with descriptions, never open-ended
- Examples from `references/questioning.md`: "Individual or team?", "Painkiller or vitamin?", "Why now vs 2 years ago?"

**Research Template Pattern:**
- Purpose: Structured output across four parallel researchers
- Defined in: `agents/brainstorm-researcher.md` (output_format section)
- Pattern: Markdown with Key Findings, Signal Quality table, Risk/Opportunity lists, Bottom Line summary
- Enables: Synthesis into SUMMARY.md

**Spec Template Pattern:**
- Purpose: Transform clarity into two complementary specs
- Defined in: `agents/brainstorm-specwriter.md` (product_spec_format and technical_spec_format sections)
- Pattern: Product-first (who/what/why/success/MVP), then Technical (architecture/stack/data/phases)
- Enables: Handoff to GSD for implementation planning

## Entry Points

**User Interaction Entry:**
- Interface: Claude Code `/brainstorm:` commands
- Commands: `new`, `clarify`, `specs`, `help`
- Located: `commands/brainstorm/*.md`

**System Entry (Idea to Specs):**

1. `/brainstorm:new`
   - Triggers: `workflows/new.md`
   - Responsibilities: Complete new session from raw idea to clarity or kill
   - Spawns: Researcher agents (4x), Clarifier agent
   - Outputs: `.brainstorm/` directory with full session state

2. `/brainstorm:clarify`
   - Triggers: `workflows/clarify.md`
   - Responsibilities: Resume existing clarification session
   - Prerequisites: `.brainstorm/HISTORY.md` exists
   - Spawns: Clarifier agent (continuation)
   - Outputs: Updated HISTORY.md

3. `/brainstorm:specs`
   - Triggers: `workflows/specs.md`
   - Responsibilities: Generate product and technical specs
   - Prerequisites: HISTORY.md status = "Ready for Specs"
   - Spawns: Specwriter agent (1x)
   - Outputs: PRODUCT_SPEC.md, TECHNICAL_SPEC.md

## Error Handling

**Strategy:** Explicit state verification at decision gates.

**Patterns:**

1. **Missing State Files** (`workflows/clarify.md` step 1, `workflows/specs.md` step 1)
   - Check: File existence (e.g., `ls .brainstorm/HISTORY.md`)
   - Action: Display helpful message directing user to appropriate command
   - Example: "No brainstorm session found. Start one: /brainstorm:new"

2. **Invalid Session State** (`workflows/specs.md` step 1)
   - Check: HISTORY.md contains "Ready for Specs" marker
   - Action: Show current status, suggest next command
   - Example: "Current status: In Progress. Next: /brainstorm:clarify"

3. **Research Quality Gates** (`agents/brainstorm-researcher.md` quality_gates section)
   - Check: At least 3 sources cited, both risks and opportunities identified, confidence justified
   - Action: Agent revises or supplements if gates fail
   - Example: Prevent "no sources found" reports

4. **Agent Context Starvation**
   - Prevention: Workflows read all prerequisite files before spawning agents
   - Pattern: Workflows pass full context (IDEA, SUMMARY, HISTORY) to agents as prompt text
   - Example: `Task(prompt="...@.brainstorm/HISTORY.md...")` inlines full history

## Cross-Cutting Concerns

**Logging:** Everything persisted to markdown files in `.brainstorm/`
- Research logged per-dimension in research/
- Q&A logged in HISTORY.md with timestamp, question, answer, follow-up notes
- Decisions logged in spec files (Decision Log section)

**Validation:**
- User answers validated through dichotomy constraints (forced to choose)
- Research validated via source credibility hierarchy in `agents/brainstorm-researcher.md`
- Specs validated via quality_gates checklists in `agents/brainstorm-specwriter.md`

**Kill Signal Detection:**
- Defined in: `references/questioning.md` kill_signals section
- Monitored by: `agents/brainstorm-clarifier.md` (kill signals section)
- Named signals: circular reasoning, solution-first, everyone problem, no switching cost, timing vacuum
- Action: Explicitly surface with recommendation (pivot, kill, or override)

**Clarity Signal Detection:**
- Defined in: `references/questioning.md` clarity_signals section
- Monitored by: `agents/brainstorm-clarifier.md` (clarity signals section)
- Named signals: specific person, felt pain, clear villain, obvious trigger, simple pitch
- Action: Acknowledge progress, confirm when all five present

**Context Carryover Between Phases:**
- Research informs clarification focus (SUMMARY.md "Clarification Focus" section)
- Clarification decisions inform spec generation (HISTORY.md read by specwriter)
- Specs enable GSD integration (`/gsd:new-project --auto @.brainstorm/PRODUCT_SPEC.md`)

---

*Architecture analysis: 2026-02-13*
