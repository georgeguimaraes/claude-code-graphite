#!/bin/bash
# SessionStart hook: inject Graphite context if in a Graphite-enabled repo

set -euo pipefail

# Check if we're in a git repo with Graphite initialized
if [ -f ".git/.graphite_repo_config" ]; then
  cat << 'EOF'
This repo uses Graphite CLI for stacked PRs.

**IMPORTANT: Use gt commands instead of git:**
- `gt create -am "msg"` instead of `git commit` - creates new branch/PR
- `gt modify -a` instead of `git commit --amend` - amends current PR
- `gt submit --no-interactive` instead of `git push` - submits stack
- `gt sync` instead of `git pull` - pulls trunk, restacks, cleans merged

**Before writing code for a feature:**
1. Plan the stack structure (use TodoWrite - each todo = one PR)
2. Present the plan and ask for confirmation
3. Each PR must be atomic and pass CI independently

**Commit style:** conventional commits (feat:, fix:, etc.), casual and concise, no LLM fluff, no em dashes.

**PR bodies:** what changed, why, and the benefit.

When conflicts occur during restack: check what each branch does, auto-resolve obvious ones, ask about ambiguous ones.
EOF
fi
