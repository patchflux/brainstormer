# Coding Conventions

**Analysis Date:** 2026-02-13

## Document Structure

**File Format:**
- YAML frontmatter header for metadata
- Role/purpose defined in `<role>` blocks
- XML-style tags for structured sections: `<philosophy>`, `<framework>`, `<process>`, `<anti_patterns>`
- Markdown body for human-readable content

**Example header:**
```yaml
---
name: brainstorm-clarifier
description: Devil's advocate cofounder that challenges ideas through dichotomy questioning
tools: Read, Write, AskUserQuestion
---
```

See: `agents/brainstorm-clarifier.md` (lines 1-5), `agents/brainstorm-researcher.md` (lines 1-5)

## Naming Patterns

**Files:**
- Agent files: `brainstorm-[role].md` (e.g., `brainstorm-clarifier`, `brainstorm-researcher`, `brainstorm-specwriter`)
- Workflow files: `[action].md` (e.g., `new.md`, `clarify.md`, `specs.md`)
- Command help: `help.md`
- Output files: UPPERCASE (e.g., `IDEA.md`, `HISTORY.md`, `PRODUCT_SPEC.md`, `TECHNICAL_SPEC.md`)
- Research dimensions: UPPERCASE (e.g., `MARKET.md`, `COMPETITORS.md`, `WILLINGNESS.md`, `TIMING.md`)

See: `agents/` directory structure, `commands/brainstorm/` directory

**Variables in templates:**
- Template variables use double curly braces: `{{variable_name}}`
- Descriptive naming: `{{specific_target_user_description}}`, `{{product_helps_who_do_what_by_how}}`

See: `templates/PRODUCT_SPEC.md` (lines 1-50), `templates/TECHNICAL_SPEC.md` (lines 1-80)

## Code Style

**Organization:**
- Logical XML sections group related content (not arbitrary line breaks)
- Sections typically contain: purpose, examples, guidelines, anti-patterns
- Deep nesting allowed but each level should have clear purpose

**Formatting:**
- YAML frontmatter for all agent/workflow files
- Markdown formatting throughout content
- Code blocks use triple backticks with language hints (bash, markdown, json, typescript)
- Tables for structured comparisons (signals, risks, decisions)
- Bullet lists for guidelines and patterns
- Numbered lists for sequential processes

See: `agents/brainstorm-clarifier.md` (comprehensive example of sections and formatting)

**ASCII diagrams for visualization:**
- Used in architecture sections to show data flow and components
- Used in workflows to show decision trees and state transitions

See: `workflows/new.md` (lines 39-63), `PROJECT.md` (lines 49-73)

## Philosophy Sections

**Purpose:**
Every agent has a `<philosophy>` section that explains the WHY before the HOW. This prevents mechanical execution and enables intelligent adaptation.

**Content pattern:**
- Core mindset/principles (2-3 foundational ideas)
- Why these principles matter
- Trade-offs or constraints these principles impose

See: `agents/brainstorm-clarifier.md` (lines 26-57), `agents/brainstorm-specwriter.md` (lines 24-52)

## Framework/Methodology Sections

**Purpose:**
Explicit frameworks (dichotomy method, challenge ladder, research dimensions) that guide decision-making and ensure consistency.

**Content pattern:**
- Name the framework clearly
- Show good vs bad examples
- Provide hierarchy or progression (from simple to complex)
- Explain the reasoning behind each level

See: `agents/brainstorm-clarifier.md` (lines 59-127 - dichotomy method and challenge ladder)

**Dichotomy method pattern:**
- Bad example with open-ended question
- Good example with binary or ternary choice
- Explains why the good version forces clarity

Example from `agents/brainstorm-clarifier.md`:
```
**Bad:** "Who is your target user?"
**Good:** "Is this for developers or non-technical users?"
```

## Process Sections

**Purpose:**
Step-by-step workflows with concrete examples and decision points. Each step is numbered and actionable.

**Content pattern:**
- Numbered steps (1, 2, 3...)
- Clear inputs/outputs for each step
- Code blocks showing exactly what to execute or write
- Decision branches with "If X → do this"
- State files that persist between steps

See: `workflows/new.md` (lines 6-342 - full process for new brainstorm session)

**Decision branches:**
Always explicit. Use "If X:" followed by action blocks.

Example from `workflows/new.md`:
```
**If "Show full research":** Display each research file, then re-ask.

**If "Pause here:"** [action block] Exit workflow.

**If "Let's go":** Continue to step 4.
```

## Output Format Sections

**Purpose:**
Explicit templates showing exactly what to return, with examples showing structure not just description.

**Content pattern:**
- Triple backticks wrapper
- Example content with placeholders filled in
- Visual hierarchy with markdown (headers, bold, etc.)

See: `agents/brainstorm-clarifier.md` (lines 346-374 - return format for clarification complete)

## Anti-Patterns Sections

**Purpose:**
Never do this / Always do this guidance. Explicit prohibitions prevent common mistakes.

**Content pattern:**
- **Never do these:** list of what not to do
- **Always do these:** list of what to do instead
- Actionable, not abstract

See: `agents/brainstorm-clarifier.md` (lines 322-343)

## Signal and Risk Documentation

**Pattern:**
Both opportunities AND risks are documented together. No one-sided assessment.

**Structure:**
- Opportunity/Risk name
- Why it matters (impact statement)
- How to detect it (signals)
- Suggested response

See: `agents/brainstorm-researcher.md` (lines 151-159 - risk factors and opportunity indicators)

## Quality Gates

**Purpose:**
Explicit verification checklist before completing a task. Ensures quality and prevents incomplete work.

**Content pattern:**
- Checkbox list of verifiable criteria
- Specific enough to check programmatically (where possible)
- Organized by section (Product Spec, Technical Spec, etc.)

See: `agents/brainstorm-specwriter.md` (lines 430-449)

## Success Criteria

**Purpose:**
Clear definition of done. States what must be true when task completes.

**Content pattern:**
- Checkbox list of completed artifacts
- Specific deliverables (file paths, counts, formats)
- Observable outcomes

See: `workflows/new.md` (lines 344-352)

## File Path References

**Convention:**
- All file paths wrapped in backticks for clarity
- Relative paths shown from repo root or from `.brainstorm/` context
- Shown alongside descriptions, not hidden in prose

Examples from docs:
- `.brainstorm/IDEA.md` (capture output)
- `.brainstorm/research/MARKET.md` (research dimension output)
- `agents/brainstorm-clarifier.md` (agent instruction file)

## Linking and References

**Internal references:**
- Other agents referenced by filename: "Read your instructions: @agents/brainstorm-researcher.md"
- Output files referenced as: `.brainstorm/[FILENAME].md`
- Workflow phases linked to orchestrator commands: `/brainstorm:new`, `/brainstorm:clarify`, `/brainstorm:specs`

See: `workflows/new.md` (lines 88-142 - task spawning syntax)

## Documentation Versioning

**MVP Status:**
Files explicitly mark version and MVP status:
```
**Version:** 0.1 (MVP)
**Status:** Ready for Technical Spec
**Last Updated:** [date]
```

See: `templates/PRODUCT_SPEC.md` (lines 3-5), `templates/TECHNICAL_SPEC.md` (lines 3-5)

## Comments and Annotations

**Purpose:**
Explanatory notes about why choices exist, especially in templates and critical logic.

**Pattern:**
- Inline in prose form when explaining framework
- Bolded headers for section purposes
- Explicit "why" statements in quality gates and ending conditions

See: `agents/brainstorm-specwriter.md` (lines 34-51 - philosophy section explaining MVP thinking)

## Endpoint and API Documentation

**Pattern:**
RESTful convention with method, path, description, and auth requirement.

**Format:**
```
| Method | Path | Description | Auth |
|--------|------|-------------|------|
| GET | /api/[resource] | List all | [Yes/No] |
```

See: `agents/brainstorm-specwriter.md` (lines 329-336)

---

*Convention analysis: 2026-02-13*
