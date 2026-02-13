# Codebase Concerns

**Analysis Date:** 2026-02-13

## Implementation Status

**Status:** Incomplete — Design phase complete, orchestration layer missing

**Issue:** The project is a comprehensive design system for idea validation with all agent prompts and workflows defined, but lacks the actual command orchestrator that ties everything together.

**Files affected:** `commands/brainstorm/*.md`, `workflows/*.md`

**Impact:** Commands like `/brainstorm:new`, `/brainstorm:clarify`, `/brainstorm:specs` cannot execute without:
- CLI command dispatcher
- Workflow state orchestration
- Agent task spawning system
- File I/O coordination

**Fix approach:**
- Build an orchestrator that parses commands (`/brainstorm:new`, etc.)
- Implement workflow execution engine that reads `.md` workflow files
- Create task spawning system for parallel agent execution
- Implement state persistence (`.brainstorm/` directory management)

**Priority:** High — Blocks all functionality

---

## Missing Installer Script

**Issue:** Installation process is incomplete

**Files affected:** `README.md` (line 23 - "TODO: installer script")

**Impact:** Users cannot easily install the tool. Manual copying is required.

**Current approach:** Copy to `~/.claude/brainstomer/`

**Fix approach:**
- Create shell script that copies agent, workflow, command, reference, and template files
- Handle directory creation
- Validate installation
- Provide usage instructions

**Priority:** Medium — Usability issue for distribution

---

## Assumption about Task Spawning

**Issue:** Workflows assume Claude Code `Task()` system exists

**Files affected:**
- `workflows/new.md` (lines 88-143) - spawns 4 parallel researchers
- `workflows/specs.md` (lines 64-79) - spawns specwriter agent

**Current pattern:**
```
Task(prompt="...", subagent_type="brainstorm-researcher", description="...")
```

**Problem:** No documentation of:
- How `Task()` function works
- Whether subagent_type values are correct
- Error handling for failed task spawning
- Timeout behavior for parallel tasks
- How results are returned from agents

**Fix approach:**
- Document Claude Code Task() API
- Create helper functions for consistent task spawning
- Add error handling wrapper
- Test with actual Claude Code environment

**Priority:** High — Orchestration depends on this

---

## Agent Output File Conflicts

**Issue:** Multiple agents write to same directory without coordination

**Scenario:**
- 4 parallel researchers write to `.brainstorm/research/`
- Clarifier updates `.brainstorm/HISTORY.md`
- Specwriter writes `.brainstorm/PRODUCT_SPEC.md` and `.brainstorm/TECHNICAL_SPEC.md`

**Files affected:**
- `agents/brainstorm-researcher.md` (writes MARKET.md, COMPETITORS.md, etc.)
- `agents/brainstorm-clarifier.md` (writes HISTORY.md)
- `agents/brainstorm-specwriter.md` (writes PRODUCT_SPEC.md, TECHNICAL_SPEC.md)

**Risk:** Race conditions if tasks overlap or files get truncated on concurrent writes

**Fix approach:**
- Use file locking mechanism or atomic writes
- Add file version timestamps
- Validate file existence before operations
- Add recovery mechanism for partial writes

**Priority:** Medium — Risk increases with concurrent usage

---

## Research Agent Web Search Limitations

**Issue:** Research agent depends on WebSearch and WebFetch tools that may have limitations

**Files affected:** `agents/brainstorm-researcher.md` (lines 97-119)

**Current assumptions:**
- WebSearch can find relevant market data
- WebFetch can retrieve full pages
- Results are up-to-date
- Search quality is high enough for business decisions

**Risks:**
- Search may return irrelevant results
- Real-time data requires internet access
- Some sources may require authentication
- Search results can be biased or outdated

**Impact:** Research quality directly affects clarification questions and final specs

**Mitigation strategies:**
- Add quality gates for research findings (min 3 sources per dimension)
- Require both positive and negative signals
- Flag low-confidence findings
- Provide researcher with fact-checking instructions

**Priority:** Medium — Data quality issue

---

## Dichotomy Question Fatigue

**Issue:** Clarifier enforces strict binary questions but may not adapt to idea complexity

**Files affected:** `agents/brainstorm-clarifier.md` (lines 59-127)

**Current pattern:**
- Always binary/ternary choices
- No open-ended questions allowed
- Escalating challenge levels

**Risks:**
- User frustration if their idea requires nuance
- False precision if forced to choose between unsuitable options
- May miss novel or hybrid approaches
- Question sequencing (WHO → WHAT → WHY → HOW) may not fit all ideas

**Fix approach:**
- Add "None of the above" or "Combination" options
- Track user frustration signals
- Allow pivoting question strategy if hitting resistance
- Document exceptions to dichotomy rule

**Priority:** Low — Design decision, intentional constraint

---

## Kill Signal Detection Reliability

**Issue:** Kill signals rely on pattern matching but may produce false positives/negatives

**Files affected:** `agents/brainstorm-clarifier.md` (lines 181-202)

**Signals defined:**
1. Circular reasoning
2. Solution-first thinking
3. Everyone problem
4. No switching cost
5. Timing vacuum

**Risk:**
- May incorrectly kill viable ideas
- May miss actual fatal flaws
- Depends on clarifier's interpretation

**Example false positive:** "Everyone problem" signal might misidentify legitimate horizontal markets

**Fix approach:**
- Add confidence scoring to kill signal detection
- Require multiple signals before recommending kill
- Allow user override with evidence
- Log reasoning for each signal

**Priority:** Medium — Potential for wrong recommendations

---

## Spec Template Incompleteness

**Issue:** Templates use placeholder syntax that assumes template engine

**Files affected:**
- `templates/PRODUCT_SPEC.md` (uses `{{product_name}}`, `{{timestamp}}`, etc.)
- `templates/TECHNICAL_SPEC.md` (same pattern)

**Current approach:** Uses Mustache-style placeholders

**Problem:**
- No template rendering engine mentioned
- Specwriter agent must manually replace all placeholders
- Easy to miss placeholders
- Risk of templates with unreplaced variables in final output

**Fix approach:**
- Use actual template engine (Jinja2, Handlebars, etc.)
- Pass context object to specwriter
- Validate all placeholders replaced before output
- Add template validation in quality gates

**Priority:** Medium — Output quality issue

---

## No Session Recovery Mechanism

**Issue:** If clarification session is interrupted, recovery is manual

**Files affected:**
- `workflows/clarify.md` (resume functionality)
- `agents/brainstorm-clarifier.md` (stores to HISTORY.md)

**Current state:**
- HISTORY.md is logged but resume requires user to manually run `/brainstorm:clarify`
- No automatic checkpointing during long sessions
- If session times out, all context is in files but requires manual recovery

**Risk:**
- User loses momentum on multi-session clarifications
- No automatic retries for failed questions
- No graceful degradation for network failures

**Fix approach:**
- Add session state metadata file (`.brainstorm/.session`)
- Implement automatic resume detection
- Add timeout handling with context preservation
- Create session rollback capability

**Priority:** Low → Medium — Improves UX for long sessions

---

## Performance Unknown for Large Research Datasets

**Issue:** Research agent may retrieve large amounts of data without pagination or limiting

**Files affected:** `agents/brainstorm-researcher.md` (search strategy section)

**Concerns:**
- WebFetch may return very large pages
- Research may take significant time with 4 parallel agents
- No timeout or size limits documented
- Synthesis step must process all results

**Impact:** Long wait times before clarification begins

**Fix approach:**
- Add result size/count limits to search strategy
- Implement timeout for each research dimension (e.g., 30s max)
- Reduce verbosity if results exceed threshold
- Cache research if re-running same idea

**Priority:** Medium — User experience under load

---

## Circular Dependency in Spec Generation

**Issue:** Specwriter depends on clarification output but templates may reference technical decisions not yet made

**Files affected:**
- `agents/brainstorm-specwriter.md` (Product and Technical specs)
- `templates/PRODUCT_SPEC.md` (lines 41-45 - What Must Be True)
- `templates/TECHNICAL_SPEC.md` (lines 29-39 - Technology Stack)

**Problem:**
- Product spec includes technical constraints that should come from tech spec
- Tech spec needs product decisions about success metrics
- Risk of inconsistent or circular reasoning

**Fix approach:**
- Define clear boundaries:
  - Product spec: problem, solution, business model (not technical)
  - Technical spec: architecture, stack, implementation (not business)
- Add validation to check for cross-document consistency
- Clarify which decisions drive which specs

**Priority:** Medium — Design clarity issue

---

## Testing and Validation Gaps

**Issue:** No test scenarios or validation approach for the entire system

**Files affected:** All agent and workflow files

**Missing:**
- Example session transcripts
- Test cases for kill signal detection
- Validation of spec output quality
- User feedback mechanisms

**Impact:**
- Cannot verify system works as designed
- No quality baseline
- Difficult to debug issues

**Fix approach:**
- Create example `.brainstorm/` sessions
- Build test harness for clarifier logic
- Add acceptance criteria for output specs
- Implement feedback loop to learn from real usage

**Priority:** Medium → High — Needed before public release

---

## Documentation Gaps for Claude Code Integration

**Issue:** Assumes Claude Code `Task()` API but doesn't document it

**Files affected:**
- `workflows/new.md` (lines 88-143)
- `workflows/specs.md` (lines 64-79)
- Agent descriptions

**Specific gaps:**
- How to pass `@file` references in prompt
- Error handling for failed agent execution
- How results are returned
- Timeout behavior for parallel tasks
- Token limit per task

**Impact:** Unclear if implementation approach is correct for Claude Code

**Fix approach:**
- Document Claude Code Task() API requirements
- Create wrapper utilities for consistent task spawning
- Add error handling pattern documentation
- Validate with actual Claude Code execution

**Priority:** High — Blocks implementation

---

## Security Considerations Not Addressed

**Issue:** System captures ideas and research but security implications unclear

**Files affected:** All files (general architecture)

**Concerns:**
- `.brainstorm/` directory stores sensitive business ideas
- No encryption mentioned
- File permissions not specified
- No cleanup/archive strategy
- May contain API keys or credentials in research

**Fix approach:**
- Document file permission requirements (`.brainstorm/` should be private)
- Add security section to README
- Create cleanup/archive workflow
- Advise against storing credentials in idea/research files
- Consider encryption for sensitive sessions

**Priority:** Medium — Important before distribution

---

## Scope Creep Risk in MVP Definition

**Issue:** "MVP" concept in specs but scope boundaries may not be enforced

**Files affected:**
- `agents/brainstorm-specwriter.md` (lines 43-52 - MVP definition)
- `templates/PRODUCT_SPEC.md` (lines 56-72 - MVP scope)

**Pattern:** Templates define "Max 5 Features" but specwriter may allow more

**Risk:** MVP inflation → longer build times → delayed validation

**Fix approach:**
- Add hard validation: reject specs with > 5 MVP features
- Require justification for each feature
- Create "nice-to-have" section distinct from MVP
- Track scope creep in decision log

**Priority:** Low → Medium — Helps with product discipline

---

## Monitoring and Observability Missing

**Issue:** No way to observe system health or usage

**Files affected:** All workflows and agents

**Missing:**
- Logging strategy
- Metrics collection
- Error rate tracking
- Session success/failure rates
- Research quality metrics

**Impact:** Difficult to debug issues or improve system

**Fix approach:**
- Add structured logging to each workflow step
- Track session outcomes (clarity/pivot/kill distribution)
- Monitor research quality signals
- Collect clarifier question effectiveness
- Create observability dashboard

**Priority:** Low → Medium — Useful after launch

---

## Version Compatibility Concerns

**Issue:** Heavy dependence on specific Claude Code version/capabilities

**Files affected:** All files (general dependency)

**Concerns:**
- WebSearch/WebFetch tool availability
- Task spawning API stability
- Token limits per operation
- Model capabilities for research quality

**Fix approach:**
- Document Claude Code version requirements
- Add compatibility checks
- Create fallback modes if tools unavailable
- Test with multiple Claude versions

**Priority:** Medium — Maintenance risk over time

---

*Concerns audit: 2026-02-13*
