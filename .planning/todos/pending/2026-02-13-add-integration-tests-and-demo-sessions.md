---
created: 2026-02-13T21:25:00.000Z
title: Add integration tests and demo sessions
area: testing
files:
  - workflows/new.md
  - workflows/clarify.md
  - workflows/specs.md
---

## Problem

The project needs:
1. **Integration tests** — Automated verification that the full brainstorm pipeline works end-to-end
2. **Demo sessions** — Pre-recorded/scripted sessions to showcase capabilities and serve as examples

Currently, Phase 2 validation is manual and requires running commands in fresh Claude sessions. There's no way to automatically verify the system works or to demonstrate it to others.

## Solution

### Integration Test Suite

Create test harness that can:
- Spawn test sessions with predefined ideas
- Verify expected outputs are generated (.brainstorm/ files)
- Check file content matches expected patterns
- Run regression tests when agents/workflows change

Possible approaches:
- Shell script that simulates workflow execution
- Mock Claude Code responses for deterministic testing
- Snapshot testing of generated files

### Demo Sessions

Create example `.brainstorm/` directories showing:
- Complete session from idea → specs
- Different idea types (SaaS, CLI tool, mobile app, etc.)
- Edge cases (pivot recommendation, kill signal detection)

Each demo includes:
- IDEA.md with input
- research/*.md with findings
- HISTORY.md with clarification Q&A
- PRODUCT_SPEC.md and TECHNICAL_SPEC.md outputs
- README explaining the session

### Benefits
- Verify system works without manual testing
- Showcase capabilities to potential users
- Provide examples for documentation
- Enable CI/CD integration
