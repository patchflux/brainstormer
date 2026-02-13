# Brainstomer

## What This Is

A devil's advocate cofounder bot for Claude Code that challenges ideas through dichotomy questioning until they're crystal clear — or recommends killing them early. It runs parallel market research, forces binary choices to eliminate vagueness, and outputs specs that feed directly into GSD for implementation.

## Core Value

Force clarity through constraint. If an idea can't survive skeptical questioning, better to kill it now than watch it fail slowly.

## Requirements

### Validated

- ✓ Agent prompts designed (researcher, clarifier, specwriter) — existing
- ✓ Workflows created (new, clarify, specs) — existing
- ✓ Commands created (/brainstorm:new, clarify, specs, help) — existing
- ✓ Reference guides written (questioning.md) — existing
- ✓ Output templates created — existing
- ✓ README documentation — existing
- ✓ Codebase mapped — existing
- ✓ Installer script for easy deployment — v1.0

### Active

- [ ] Real-world testing on actual ideas (VALD-01 through VALD-04)
- [ ] Iteration based on usage feedback
- [ ] Specialized parallel agents for deep idea analysis
- [ ] Smart contextual commands (progress, resume, next, help)
- [ ] Commands for existing projects (analyze, zoom)
- [ ] Feedback command for external input processing
- [ ] Multi-timeline vision planning

### Out of Scope

- GUI/web interface — CLI-first, Claude Code native
- Paid/commercial features — open source tool
- Integration with other AI platforms — Claude Code only for now

## Context

**Technical environment:**
- Pure markdown-based system (no code dependencies)
- Leverages Claude Code's native Task() spawning for parallel agents
- State persisted in `.brainstorm/` directory
- Designed to integrate with GSD via `--auto` flag

**Prior work:**
- Inspired by GSD patterns: thin orchestrators, specialized agents, goal-backward thinking
- Draws from Y Combinator application questions and The Mom Test

**Known patterns:**
- 4 parallel researchers (MARKET, COMPETITORS, WILLINGNESS, TIMING)
- Dichotomy questioning method (binary/ternary choices only)
- Kill signals (circular reasoning, solution-first, everyone problem, no switching cost, timing vacuum)
- Clarity signals (specific person, felt pain, clear villain, obvious trigger, simple pitch)

## Constraints

- **Platform**: Claude Code CLI only — designed for native tool integration
- **State**: File-based in `.brainstorm/` — no database or external services
- **Output**: Must produce specs compatible with GSD `--auto` flag

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Dichotomy-only questions | Forces specificity, reveals priorities | — Pending |
| 4 parallel research dimensions | Speed + comprehensive coverage | — Pending |
| Kill/pivot/clarity outcomes | Honest assessment over validation | — Pending |
| GSD integration | Seamless handoff to implementation | — Pending |
| POSIX sh for installer | Maximum portability | ✓ Good |
| Detect source dir by file check | Works in non-tty environments | ✓ Good |
| Remove+copy for idempotent updates | Clean updates without merge conflicts | ✓ Good |

## Current State

**v1.0 MVP shipped:** 2026-02-13
- Installer complete and working
- Validation requires manual testing in fresh sessions
- 11 v2 feature todos captured

---
*Last updated: 2026-02-14 after v1.0 milestone*
