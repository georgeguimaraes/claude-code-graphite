---
name: Graphite Stacked PRs
description: >
  This skill should be used ONLY when working in a Graphite-enabled repository
  (detected by .git/.graphite_repo_config existing). Use when the user mentions
  "graphite", "stacked PRs", "gt create", "gt modify", "gt submit", "gt sync",
  "gt restack", or asks to commit/push changes in a Graphite repo. For repos
  WITHOUT .git/.graphite_repo_config, use standard git commands instead.
---

# Graphite Stacked PRs Workflow

**IMPORTANT:** This workflow applies ONLY to repositories with `.git/.graphite_repo_config`. For repositories without this file, use standard git commands (`git commit`, `git push`, etc.).

## Detection

Check for `.git/.graphite_repo_config` to determine if a repo uses Graphite:
- **File exists:** Use `gt` commands (this skill applies)
- **File does not exist:** Use standard `git` commands (this skill does NOT apply)

When Graphite is detected, use `gt` commands instead of `git` for all commit and branch operations.

## MCP Server

A Graphite MCP server may be available (check with `/mcp`). If the `graphite` MCP is connected, it provides tools to automatically break large changes into stacked PRs. Use MCP tools when available for complex multi-file changes.

## Command Mapping

Use these `gt` commands instead of their git equivalents:

| Instead of | Use | Purpose |
|------------|-----|---------|
| `git commit` | `gt create -am "msg"` | Create new branch/PR with changes |
| `git commit --amend` | `gt modify -a` | Amend current PR |
| `git push` | `gt submit --stack` or `gt ss` | Push entire stack |
| `git pull` | `gt sync` | Pull trunk, restack, clean merged |
| `git checkout` | `gt checkout <branch>` | Switch branches |
| `git rebase` | `gt restack` | Rebase stack (usually via `gt sync`) |

## When to Create vs Amend

**Use `gt create -am "message"`** when:
- Starting new work (new feature, new fix)
- The change is logically separate from current PR
- Building the next piece in a stack

**Use `gt modify -a`** when:
- Addressing PR review feedback
- Fixing something in the current PR
- Adding forgotten changes to current work

## Commit and PR Style

### Commit Messages

Use conventional commits with casual, concise descriptions:

- Start with type: `feat:`, `fix:`, `chore:`, `docs:`, `refactor:`, `perf:`, `test:`
- Capitalize after the prefix
- Keep it brief and human
- No LLM fluff, no em dashes

### PR Body Descriptions

Write PR bodies that explain:
1. **What** changed
2. **Why** it changed
3. **The benefit** or purpose

Keep descriptions casual, concise, and human-like. Avoid corporate speak or overly formal language.

## Stack Philosophy

Each PR in a stack should be:
- **Small** - ideally under 250 lines changed
- **Focused** - one logical change per branch
- **Independent** - reviewable on its own (even if it depends on others)

Break large features into functional components:
- Database changes first
- Backend logic next
- Frontend last

Or use iterative stacking:
- Basic implementation
- Error handling
- Tests
- Polish

## Navigation

Move through the stack:

```bash
gt log          # View full stack with PR status
gt ls           # Abbreviated stack view
gt up           # Move up one branch (toward tip)
gt down         # Move down one branch (toward trunk)
gt top          # Jump to top of stack
gt bottom       # Jump to bottom of stack
gt checkout X   # Switch to specific branch
```

## Sync Workflow

Run `gt sync` regularly (at least daily) to:
1. Pull latest trunk changes
2. Restack all branches
3. Clean up merged branches

When `gt sync` encounters conflicts, it pauses for resolution. See conflict resolution below.

## Submitting Work

Push changes with:

```bash
gt submit --stack   # Push current branch and all descendants
gt ss               # Shorthand for above
gt ss -u            # Update existing PRs only (no new PRs)
```

For a single PR without descendants:
```bash
gt submit           # Push current branch only
gt s                # Shorthand
```

## Conflict Resolution

When `gt sync` or `gt restack` hits conflicts:

1. **Understand what conflicted** - check which branch and what files
2. **Check what each branch does** - use `gt log` and review the changes
3. **Auto-resolve obvious conflicts:**
   - Import order changes
   - Whitespace differences
   - Non-overlapping additions
4. **Ask about ambiguous conflicts:**
   - Same code modified differently
   - Deleted vs modified conflicts
   - Semantic conflicts (logic changes)

After resolving:
```bash
gt continue -a      # Stage all and continue restack
```

If stuck:
```bash
gt abort            # Abandon restack, return to previous state
```

For detailed conflict resolution patterns, see `references/conflict-resolution.md`.

## Reorganizing Stacks

Adjust stack structure when needed:

```bash
gt move --onto <branch>   # Move current branch to new parent
gt fold                   # Merge branch into its parent
gt split                  # Break branch into multiple
gt squash                 # Combine commits in branch to one
gt reorder                # Interactively reorder branches
```

## Collaboration

Work with others' stacks:

```bash
gt get <branch>           # Fetch someone's stack locally
gt track <branch>         # Start tracking existing git branch
```

## Quick Reference

See `references/cheatsheet.md` for a complete command reference.

## Common Workflows

### Starting a New Feature

```bash
gt sync                           # Get latest
gt create -am "feat: Add user avatar support"
# ... make more changes ...
gt modify -a                      # Amend to current PR
gt ss                             # Push stack
```

### Stacking Multiple PRs

```bash
gt create -am "feat: Add avatar upload API"
# ... work on next piece ...
gt create -am "feat: Add avatar display component"
# ... work on next piece ...
gt create -am "feat: Add avatar to user profile"
gt ss                             # Push entire stack
```

### Addressing Review Feedback

```bash
gt checkout <branch-with-feedback>
# ... make fixes ...
gt modify -a                      # Amend changes
gt ss                             # Push updates (auto-restacks dependents)
```

### Daily Sync Routine

```bash
gt sync                           # Pull, restack, clean
# Resolve any conflicts if prompted
gt continue -a                    # After resolving
```
