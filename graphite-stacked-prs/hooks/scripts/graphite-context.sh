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
- `gt submit --stack` instead of `git push` - pushes entire stack
- `gt sync` instead of `git pull` - pulls trunk, restacks, cleans merged

**Navigation:**
- `gt log` / `gt ls` - view stack
- `gt up` / `gt down` - move through stack
- `gt checkout <branch>` - switch branch

**Commit style:** conventional commits (feat:, fix:, etc.), casual and concise, no LLM fluff, no em dashes.

**PR bodies:** what changed, why, and the benefit.

**Philosophy:** small, focused PRs stacked on each other. One logical change per branch.

When conflicts occur during restack: check what each branch does, auto-resolve obvious ones, ask about ambiguous ones.
EOF
fi
