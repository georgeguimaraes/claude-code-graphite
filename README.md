# Claude Code Graphite

Claude Code plugins for [Graphite](https://graphite.dev) stacked PRs workflow.

## Installation

```bash
claude plugin marketplace add georgeguimaraes/claude-code-graphite
```

Install all plugins:

```bash
claude plugin install graphite@claude-code-graphite && \
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
| [graphite](#graphite) | Skill + Hook | gt commands, stack planning, conflict resolution |
| [graphite-mcp](#graphite-mcp) | MCP | Graphite MCP server integration (gt mcp) |

---

### graphite

Skill and hooks for Graphite CLI (`gt`) stacked PR workflows.

| Feature | Description |
|---------|-------------|
| Detection | Auto-detects Graphite repos via `.git/.graphite_repo_config` |
| Commands | Uses `gt` commands instead of `git` for commits/branches |
| Stack planning | Break features into atomic, reviewable PRs |
| Conflict resolution | Guidance for handling restack conflicts |
| SessionStart hook | Context when entering a Graphite repo |

**Commit style:** Conventional commits (feat:, fix:, etc.), casual and concise, no LLM fluff.

**PR bodies:** What changed, why, and the benefit.

---

### graphite-mcp

MCP server integration for Graphite CLI.

| Feature | Description |
|---------|-------------|
| MCP tools | Graphite tools via Model Context Protocol |
| Command | Uses `gt mcp` from Graphite CLI (v1.6.7+) |

---

## License

Copyright (c) 2026 George Guimarães

Licensed under the Apache License, Version 2.0.
