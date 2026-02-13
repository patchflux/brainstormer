# Roadmap: Brainstomer

## Overview

This brownfield project has core agents and workflows already implemented. Two remaining phases complete the v1 deliverable: create an installer for easy deployment, then validate the full system works end-to-end with real usage testing.

## Phases

**Phase Numbering:**
- Integer phases (1, 2): Planned milestone work
- Decimal phases (1.1, 1.2): Urgent insertions (marked with INSERTED)

Decimal phases appear between their surrounding integers in numeric order.

- [x] **Phase 1: Installation** - Make brainstomer deployable with single command ✓
- [ ] **Phase 2: Validation** - Verify all workflows work end-to-end

## Phase Details

### Phase 1: Installation
**Goal**: Users can install brainstomer with a single command and start using it immediately
**Depends on**: Nothing (existing codebase provides foundation)
**Requirements**: INST-01, INST-02, INST-03, INST-04
**Success Criteria** (what must be TRUE):
  1. User runs single install command and brainstomer becomes available
  2. All required files (agents, workflows, commands, references, templates) are copied to ~/.claude/brainstomer/
  3. Installation script verifies success and reports any issues
  4. User sees clear usage instructions after installation completes
**Plans:** 1 plan

Plans:
- [x] 01-01-PLAN.md — Create installer script and update README ✓

### Phase 2: Validation
**Goal**: All brainstorm workflows execute successfully with real ideas and produce usable specs
**Depends on**: Phase 1
**Requirements**: VALD-01, VALD-02, VALD-03, VALD-04
**Success Criteria** (what must be TRUE):
  1. /brainstorm:new captures idea, runs 4 parallel researchers, and enters clarification
  2. /brainstorm:clarify resumes existing session and continues dichotomy questioning
  3. /brainstorm:specs generates both product and technical spec files
  4. Generated specs work with /gsd:new-project --auto flag (valid format, complete sections)
**Plans:** 4 plans

Plans:
- [ ] 02-01-PLAN.md — Validate /brainstorm:new workflow (VALD-01)
- [ ] 02-02-PLAN.md — Validate /brainstorm:clarify workflow (VALD-02)
- [ ] 02-03-PLAN.md — Validate /brainstorm:specs workflow (VALD-03)
- [ ] 02-04-PLAN.md — Validate GSD compatibility (VALD-04)

## Progress

**Execution Order:**
Phases execute in numeric order: 1 → 2

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Installation | 1/1 | ✓ Complete | 2026-02-13 |
| 2. Validation | 0/4 | Not started | - |

---
*Roadmap created: 2026-02-13*
*Last updated: 2026-02-13*
