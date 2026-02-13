# Technology Stack

**Analysis Date:** 2026-02-13

## Languages

**Primary:**
- Markdown - Configuration, documentation, prompt/instruction files for agents and workflows

**Secondary:**
- YAML - Metadata headers in agent and command files

## Runtime

**Environment:**
- Claude AI (hosted inference through Anthropic's API)
- Designed for Claude Code (CLI interface)

**No Package Manager:**
- Pure text-based system using markdown files
- No code dependencies or lockfile

## Frameworks

**Core Orchestration:**
- Custom workflow orchestration system (native to Claude Code)
- Task/subagent spawning via `Task()` system for parallel execution
- File-based state persistence

**Specialized Agents:**
- `brainstorm-researcher` - Web search and research synthesis
- `brainstorm-clarifier` - Interactive questioning and history logging
- `brainstorm-specwriter` - Specification generation

## Key Dependencies

**Claude Code Built-in Tools (No External Packages):**
- `Read` - File reading for context loading
- `Write` - File output for markdown generation
- `Bash` - Directory/file operations
- `WebSearch` - Used by brainstorm-researcher for market research
- `WebFetch` - Used by brainstorm-researcher for source validation
- `AskUserQuestion` - Used by brainstorm-clarifier for dichotomy prompting

**Critical Capabilities Required:**
- Web search access (brainstorm-researcher dimension)
- User interaction prompting (brainstorm-clarifier for Q&A)
- File I/O (all agents for state persistence)

## Configuration

**Environment:**
- Markdown file-based configuration (no env vars)
- YAML frontmatter in agent descriptors:
  ```yaml
  ---
  name: brainstorm-researcher
  description: [description]
  tools: Read, Write, Bash, WebSearch, WebFetch
  ---
  ```

**Build:**
- No build step required
- Deployment: Copy directories to `~/.claude/brainstomer/` for Claude Code CLI

**State Storage:**
- Local `.brainstorm/` directory (relative to execution context)
- Subdirectories:
  - `research/` - Four research dimension outputs (MARKET.md, COMPETITORS.md, WILLINGNESS.md, TIMING.md)
  - Root: IDEA.md, HISTORY.md, PRODUCT_SPEC.md, TECHNICAL_SPEC.md

## Platform Requirements

**Development:**
- Text editor for markdown authoring
- Claude Code installed and configured
- Access to Claude AI (subscription required)

**Production (User Perspective):**
- Claude Code CLI with brainstomer installed
- Write permissions to user's working directory
- Web search capability (part of Claude Code environment)

## Technology Rationale

**Why Markdown + Claude Code:**
- **Reproducibility**: Pure text means version control friendly, auditable
- **Portability**: Works anywhere Claude Code runs (no runtime dependencies)
- **Interactivity**: Leverages Claude's conversational abilities for questioning
- **Integration**: Outputs feed directly into GSD pipeline (`@.brainstorm/PRODUCT_SPEC.md`)
- **Simplicity**: No infrastructure overhead, instant availability

**Agent Specialization:**
- Separation of concerns: researcher handles market signals, clarifier handles dialogue, specwriter handles synthesis
- Parallel execution: Four researchers run simultaneously for speed
- Tool precision: Each agent uses only required tools (researcher needs web access, clarifier needs user interaction)

---

*Stack analysis: 2026-02-13*
