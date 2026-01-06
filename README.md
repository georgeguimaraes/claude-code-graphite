# Claude Code Graphite

Claude Code plugins for [Graphite](https://graphite.dev) stacked PRs workflow.

## Installation

```bash
claude plugin marketplace add georgeguimaraes/claude-code-graphite
```

Install all plugins:

```bash
claude plugin install graphite-stacked-prs@claude-code-graphite && \
claude plugin install graphite-mcp@claude-code-graphite
```

## Prerequisites

| Platform | Command |
|----------|---------|
| macOS | `brew install withgraphite/tap/graphite` |
| npm | `npm install -g @withgraphite/graphite-cli@stable` |

> **Note:** MCP server requires Graphite CLI v1.6.7 or later.

---

## Plugins

### Overview

| Plugin | Type | Description |
|--------|------|-------------|
| [graphite-stacked-prs](#graphite-stacked-prs) | Skill + Hook | Graphite workflow, gt commands, conflict resolution |
| [graphite-mcp](#graphite-mcp) | MCP | Graphite MCP server integration |

---

### graphite-stacked-prs

Skill for working with Graphite CLI (`gt`) for stacked PR workflows.

| Feature | Description |
|---------|-------------|
| Detection | Auto-detects Graphite repos via `.git/.graphite_repo_config` |
| Commands | Uses `gt` commands instead of `git` for commits/branches |
| SessionStart hook | Quick command reference when entering a Graphite repo |
| Conflict resolution | Guidance for handling restack conflicts |

**Commit style:** Conventional commits (feat:, fix:, etc.), casual and concise, no LLM fluff.

**PR bodies:** What changed, why, and the benefit.

---

### graphite-mcp

Adds the Graphite MCP server.

| Feature | Description |
|---------|-------------|
| MCP tools | Provides Graphite tools via Model Context Protocol |
| Built-in | Uses `gt mcp` from Graphite CLI (v1.6.7+) |

---

## License

Copyright (c) 2026 George Guimarães

Licensed under the Apache License, Version 2.0.
