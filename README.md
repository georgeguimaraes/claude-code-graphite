# Claude Code Graphite

Plugins for working with [Graphite](https://graphite.dev) stacked PRs in Claude Code.

## Plugins

### graphite-stacked-prs

Teaches Claude Code to use Graphite CLI (`gt`) for stacked PR workflows.

**Features:**
- Auto-detects Graphite repos via `.git/.graphite_repo_config`
- Uses `gt` commands instead of `git` for commits/branches
- SessionStart hook with quick command reference
- Conflict resolution guidance

**Install:**
```bash
claude --plugin-dir ~/claude-code-graphite/graphite-stacked-prs
```

### graphite-mcp

Adds the Graphite MCP server.

**Features:**
- Provides Graphite tools via MCP
- Built into Graphite CLI (v1.6.7+)

**Requires:** Graphite CLI v1.6.7 or later
```bash
brew upgrade withgraphite/tap/graphite
```

**Install:**
```bash
claude --plugin-dir ~/claude-code-graphite/graphite-mcp
```

## Install Both

```bash
claude --plugin-dir ~/claude-code-graphite/graphite-stacked-prs --plugin-dir ~/claude-code-graphite/graphite-mcp
```
