# Codebase Structure

**Analysis Date:** 2026-02-13

## Directory Layout

```
brainstomer/
├── agents/                    # Specialized Claude agent definitions
│   ├── brainstorm-researcher.md       # Market/competitor/willingness/timing research
│   ├── brainstorm-clarifier.md        # Devil's advocate dichotomy questioning
│   └── brainstorm-specwriter.md       # Synthesizes specs from clarity
│
├── commands/                  # User-facing command definitions
│   └── brainstorm/
│       ├── new.md                     # Start new session
│       ├── clarify.md                 # Resume clarification
│       ├── specs.md                   # Generate specs (after clarity)
│       └── help.md                    # Usage documentation
│
├── workflows/                 # Multi-step orchestration processes
│   ├── new.md                         # Full flow: capture → research → clarify → specs
│   ├── clarify.md                     # Resume clarification session
│   └── specs.md                       # Generate product/technical specs
│
├── references/                # Shared knowledge and guidelines
│   └── questioning.md                 # Dichotomy method reference guide
│
├── templates/                 # Output templates for generated files
│   ├── IDEA.md                        # Raw idea capture template
│   ├── HISTORY.md                     # Q&A log template
│   ├── PRODUCT_SPEC.md                # Product specification template
│   ├── TECHNICAL_SPEC.md              # Technical specification template
│   └── research/
│       ├── MARKET.md                  # Market research template
│       ├── COMPETITORS.md             # Competitor research template
│       ├── WILLINGNESS.md             # Willingness-to-pay research template
│       ├── TIMING.md                  # Timing research template
│       └── SUMMARY.md                 # Research synthesis template
│
├── .planning/                 # This planning directory (generated)
│   └── codebase/
│       ├── ARCHITECTURE.md            # This file's companion
│       └── STRUCTURE.md               # This file
│
├── PROJECT.md                 # Project vision and status
├── README.md                  # User documentation
└── .gitignore                 # Git configuration
```

## Directory Purposes

**agents/**
- Purpose: Define specialized Claude agent personas and operational guidelines
- Contains: YAML headers + role/framework/output_format/quality_gates sections
- Key files:
  - `brainstorm-researcher.md` (200 lines): Market research, competitor analysis, willingness-to-pay, timing signals
  - `brainstorm-clarifier.md` (374 lines): Dichotomy questioning, kill/clarity signal detection
  - `brainstorm-specwriter.md` (484 lines): Transform validated ideas into product and technical specs

**commands/brainstorm/**
- Purpose: User entry points — thin wrappers delegating to workflows
- Contains: Simple command definitions with usage examples
- Naming: `{action}.md` → `/brainstorm:{action}`
- Key files:
  - `new.md`: Start new session
  - `clarify.md`: Resume clarification
  - `specs.md`: Generate specs
  - `help.md`: Show all commands

**workflows/**
- Purpose: Orchestrate multi-step processes with explicit control flow
- Contains: `<purpose>`, `<process>`, `<output>`, `<success_criteria>` sections
- Key files:
  - `new.md` (354 lines): 4-step workflow (capture idea → research in parallel → present findings → enter clarification)
  - `clarify.md` (93 lines): State check → load context → resume clarification → handle outcome
  - `specs.md` (184 lines): Validate prerequisites → load context → spawn specwriter → present results → offer next steps

**references/**
- Purpose: Shared methodologies and operational guides
- Contains: Deep-dive explanations, examples, anti-patterns
- Key file:
  - `questioning.md` (376 lines): Dichotomy method philosophy, examples by category (WHO/WHAT/WHY/HOW/WHEN), kill/clarity signals, session flow, anti-patterns

**templates/**
- Purpose: Structure output files for consistency
- Contains: Markdown templates with sections and placeholders
- Key files:
  - `IDEA.md`: Capture idea + initial observations (raw session input)
  - `HISTORY.md`: Q&A log template with session summary
  - `PRODUCT_SPEC.md`: One-liner, problem, solution, MVP scope, user journey, business model, risks
  - `TECHNICAL_SPEC.md`: Architecture, stack, data model, API, phases, security
  - `research/*.md`: Four templates (MARKET, COMPETITORS, WILLINGNESS, TIMING) with Key Findings, Signal Quality, Risk/Opportunity, Bottom Line

## Key File Locations

**Entry Points:**
- `README.md`: User-facing documentation with examples and installation
- `PROJECT.md`: Vision, problem statement, target user, architecture overview, status
- `commands/brainstorm/help.md`: Command reference table

**Configuration:**
- `.gitignore`: Git-tracked files (agents, commands, workflows, etc.)
- `.planning/codebase/`: Analysis documents (this directory)

**Core Logic:**
- `agents/brainstorm-researcher.md`: Research methodology (search strategy, quality gates, output format)
- `agents/brainstorm-clarifier.md`: Questioning framework (dichotomy method, kill/clarity signals, ending conditions)
- `agents/brainstorm-specwriter.md`: Spec generation (goal-backward thinking, MVP scope definition)

**Orchestration:**
- `workflows/new.md`: Complete session workflow (most complex, 354 lines)
- `workflows/clarify.md`: Resume flow (state verification, context loading)
- `workflows/specs.md`: Spec generation flow (prerequisite checking)

**References:**
- `references/questioning.md`: Deep guide to dichotomy method (376 lines, most comprehensive)

## Naming Conventions

**Files:**
- Command files: lowercase action name → `/brainstorm:{action}`
  - Example: `commands/brainstorm/new.md` → `/brainstorm:new`

- Workflow files: lowercase action name
  - Example: `workflows/clarify.md` for the clarify workflow

- Agent files: `brainstorm-{role}.md`
  - Example: `brainstorm-researcher.md` for researcher agent
  - Roles: researcher, clarifier, specwriter

- Reference files: lowercase topic name
  - Example: `references/questioning.md`

- Template files: UPPERCASE_CATEGORY.md
  - Examples: IDEA.md, HISTORY.md, PRODUCT_SPEC.md, TECHNICAL_SPEC.md
  - Research templates in `templates/research/`: MARKET.md, COMPETITORS.md, WILLINGNESS.md, TIMING.md, SUMMARY.md

**Directories:**
- Logical grouping: `{layer}/{type}`
  - `agents/` — Agent definitions
  - `commands/brainstorm/` — Commands in brainstorm namespace
  - `workflows/` — Workflows
  - `references/` — Reference guides
  - `templates/` — Output templates
  - `templates/research/` — Research-specific templates
  - `.planning/codebase/` — Analysis documents

**Output Files (`.brainstorm/`):**
- Session root: `.brainstorm/`
- Raw idea: `IDEA.md`
- Research: `research/{MARKET,COMPETITORS,WILLINGNESS,TIMING,SUMMARY}.md`
- Clarification: `HISTORY.md`
- Specs: `PRODUCT_SPEC.md`, `TECHNICAL_SPEC.md`

## Where to Add New Code

**New Agent (rare):**
- Location: `agents/brainstorm-{role}.md`
- Template structure: YAML header + `<role>`, `<framework>`, `<output_format>`, `<quality_gates>`, `<return_format>`
- Reference examples: Study `agents/brainstorm-researcher.md` (research-focused) or `agents/brainstorm-clarifier.md` (interactive)
- Spawning: Called from workflow via `Task(subagent_type="brainstorm-{role}", ...)`

**New Workflow Step:**
- Location: `workflows/{name}.md` or extend existing workflow
- Template structure: `<purpose>`, `<process>` (numbered steps), `<output>`, `<success_criteria>`
- Decision gates: Use `ls` checks for state files, display messages for missing state
- Agent spawning: Reference agents by path, pass context inline as `@.brainstorm/...`
- Examples: `workflows/new.md` shows 4-step complex flow; `workflows/clarify.md` shows state-check + resume pattern

**New Command:**
- Location: `commands/brainstorm/{action}.md`
- Template: Minimal wrapper with `<command>` section
- Delegation: Always reference the workflow to execute
- Example: `commands/brainstorm/new.md` simply says "Execute workflows/new.md"

**New Reference Guide:**
- Location: `references/{topic}.md`
- Purpose: Support agents or users with deep operational knowledge
- Examples: `references/questioning.md` supports the clarifier; could add `references/research-strategy.md` to support researcher

**New Template:**
- Location: `templates/{CATEGORY}.md` or `templates/{category}/{SUBCATEGORY}.md`
- Purpose: Standardize output format from agents
- Pattern: Markdown with section headings, optional tables, examples
- Adoption: Reference in agent's `output_format` section; agent fills placeholders

## Special Directories

**`.planning/codebase/`**
- Purpose: GSD codebase mapping output location
- Generated: Yes (written by `/gsd:map-codebase` orchestrator)
- Committed: Yes (to track codebase analysis over time)
- Contents: ARCHITECTURE.md, STRUCTURE.md (this file), plus other focus-specific docs
- Consumed by: `/gsd:plan-phase` and `/gsd:execute-phase` to understand conventions and structure

**`templates/research/`**
- Purpose: Organize research output templates separately from core templates
- Generated: No (committed templates)
- Committed: Yes
- Contents: MARKET.md, COMPETITORS.md, WILLINGNESS.md, TIMING.md, SUMMARY.md
- Used by: `brainstorm-researcher` agent reads format guidance; workflow writes actual research files to `.brainstorm/research/`

**`.brainstorm/` (not in repo, generated per session)**
- Purpose: Session state and artifacts
- Generated: Yes (created on first `/brainstorm:new`)
- Committed: No (in .gitignore)
- Contents: IDEA.md, research/, HISTORY.md, PRODUCT_SPEC.md, TECHNICAL_SPEC.md
- Lifespan: Persists across `/brainstorm:clarify` calls; multiple sessions create separate `.brainstorm/` instances

## Patterns and Conventions

**YAML Frontmatter in Agent Files:**
```yaml
---
name: {agent-name}
description: {what it does}
tools: {comma-separated list of Claude tools used}
---
```

**Structured Sections in Agent/Workflow Files:**
- XML-style tags: `<role>`, `<philosophy>`, `<framework>`, `<process>`, `<output>`, `<success_criteria>`
- Not enforced as strict XML (markdown parsing allows), but readable and searchable
- Pattern aids navigation and understanding of intent

**Process Steps in Workflows:**
- Numbered steps (## 1., ## 2., etc.)
- Display/UX sections use code blocks with `━━━` borders
- Decision points use AskUserQuestion with options
- File operations use bash code blocks

**Agent Handoffs:**
- Workflows call agents via `Task()` function
- Agent name: `subagent_type="brainstorm-{role}"`
- Context passed via `prompt=` parameter, often inlining files with `@.brainstorm/...` syntax
- Agent reads full context before writing output

**Output Format in Templates:**
- Markdown headers mark sections (# for title, ## for major sections, ### for subsections)
- Tables for comparative data (research signal quality, spec decisions, tech stack rationale)
- Code blocks for JSON/config examples
- Lists for risks, opportunities, learnings
- Placeholders in [brackets] indicate user/tool-specific values

## File Purposes Quick Reference

| File | Purpose | Owner | Reads | Writes |
|------|---------|-------|-------|--------|
| `agents/brainstorm-researcher.md` | Market/competitor/willingness/timing research | Design | Task context | `.brainstorm/research/*.md` |
| `agents/brainstorm-clarifier.md` | Dichotomy questioning, kill/clarity detection | Design | IDEA.md, SUMMARY.md, HISTORY.md | `.brainstorm/HISTORY.md` |
| `agents/brainstorm-specwriter.md` | Transform clarity into specs | Design | IDEA.md, SUMMARY.md, HISTORY.md | `.brainstorm/PRODUCT_SPEC.md`, `.brainstorm/TECHNICAL_SPEC.md` |
| `workflows/new.md` | Complete new session flow | Orchestration | User input | All `.brainstorm/` files |
| `workflows/clarify.md` | Resume clarification | Orchestration | HISTORY.md | `.brainstorm/HISTORY.md` (append) |
| `workflows/specs.md` | Generate product/technical specs | Orchestration | All `.brainstorm/` files | `.brainstorm/PRODUCT_SPEC.md`, `.brainstorm/TECHNICAL_SPEC.md` |
| `references/questioning.md` | Dichotomy method guide | Reference | — | — |
| `templates/*.md` | Output format templates | Reference | — | — |

---

*Structure analysis: 2026-02-13*
