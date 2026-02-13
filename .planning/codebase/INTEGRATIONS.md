# External Integrations

**Analysis Date:** 2026-02-13

## APIs & External Services

**Web Search:**
- Service: Claude Code built-in WebSearch
- What it's used for: Market research dimension - discovering customer pain signals, competitor landscape, willingness-to-pay indicators
- Tool: `WebSearch` (brainstorm-researcher agent)
- Integration point: `agents/brainstorm-researcher.md` lines 99-104

**Web Fetch:**
- Service: Claude Code built-in WebFetch
- What it's used for: Fetching and parsing competitor sites, pricing pages, funding data, review content
- Tool: `WebFetch` (brainstorm-researcher agent)
- Integration point: `agents/brainstorm-researcher.md` line 104

**User Interaction:**
- Service: Claude Code built-in AskUserQuestion
- What it's used for: Dichotomy questioning in clarification phase, user checkpoints
- Tool: `AskUserQuestion` (brainstorm-clarifier agent)
- Integration point: `agents/brainstorm-clarifier.md` lines 171-179, 272-289

## Data Storage

**Databases:**
- Type/Provider: None - purely file-based
- Storage: Local filesystem (`.brainstorm/` directory relative to execution)
- Files managed: IDEA.md, HISTORY.md, PRODUCT_SPEC.md, TECHNICAL_SPEC.md, research/*.md

**File Storage:**
- Service: Local filesystem only
- Pattern: State persisted to markdown files for manual inspection and git tracking

**Caching:**
- Service: None - fresh research on each run via WebSearch

## Authentication & Identity

**Auth Provider:**
- Service: None (inherits Claude Code authentication)
- Context: Brainstomer runs within authenticated Claude Code session
- Boundary: No user-specific auth required; operates within invoker's context

## Monitoring & Observability

**Error Tracking:**
- Service: None built-in
- Approach: Agent instructions include quality gates (quality_gates section in agents) but no external error collection

**Logs:**
- Approach: All session state logged to `.brainstorm/HISTORY.md` for manual review
- Archival: User responsible for manual backup/archival of `.brainstorm/` directory

## CI/CD & Deployment

**Hosting:**
- Platform: User's local system or Claude Code environment
- Mechanism: Manual file copy to `~/.claude/` or equivalent Claude configuration directory
- Installation: `cp -r agents commands references workflows ~/.claude/brainstomer/`

**CI Pipeline:**
- Service: None - no automated build/test pipeline
- Manual testing: Via Claude Code CLI invocation

## Environment Configuration

**Required env vars:**
- None - all configuration through markdown frontmatter and inline prompt templates

**Secrets location:**
- Not applicable - no secrets required
- User credentials inherited from Claude Code authentication

## Webhooks & Callbacks

**Incoming:**
- Service: None - Brainstomer is pull-based (user initiates via `/brainstorm:new`)

**Outgoing:**
- Service: Potential integration with GSD via spec output files
- Mechanism: `/gsd:new-project --auto @.brainstorm/PRODUCT_SPEC.md`
- Files passed: PRODUCT_SPEC.md acts as configuration file for downstream GSD pipeline
- No active webhook; file-based handoff

## Integration Points with GSD

**Integration Pattern:**
- Output files: PRODUCT_SPEC.md and TECHNICAL_SPEC.md are designed for GSD consumption
- Trigger: User manually invokes `/gsd:new-project --auto` with PRODUCT_SPEC.md path
- Data handoff: Brainstomer's research findings and clarification decisions embedded in spec documents
- No bidirectional communication; one-way output only

## Research Data Sources

**Public Web Sources (via WebSearch/WebFetch):**
- Reddit/HackerNews/Twitter for customer pain signals
- Product Hunt for competitor launches
- Crunchbase/funding databases for market signals
- App store reviews for user complaints
- GitHub repositories and stars for developer interest
- Conference talks and blog posts
- Pricing pages of competitors
- Job postings mentioning problem areas
- Google Trends for search volume

**Quality Requirements:**
- Credibility hierarchy: Direct user complaints > Industry reports > Competitor positioning > Funding signals > General articles
- Recency filter: Prioritize information < 2 years old for fast-moving markets
- Exclude: Generic market reports without methodology, affiliate/SEO content, vaporware

---

*Integration audit: 2026-02-13*
