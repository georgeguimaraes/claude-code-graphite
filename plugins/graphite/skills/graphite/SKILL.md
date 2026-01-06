---
name: graphite
description: |
  Use for Graphite CLI stacked PRs workflow in repos with .git/.graphite_repo_config.
  Triggers: graphite, stacked PRs, dependent PRs, chained PRs, PR stack, gt create,
  gt modify, gt submit, gt sync, gt restack, gt log, gt checkout, gt up, gt down,
  rebase my stack, fix stack conflicts, split PR, land my stack, merge stack,
  sync with main/trunk, reorder branches, fold commits, amend stack, move branch
  to different parent, stack out of date, update my stack. For repos WITHOUT
  .git/.graphite_repo_config, use standard git commands instead.
---

# Graphite Stacked PRs Workflow

**IMPORTANT:** This workflow applies ONLY to repositories with `.git/.graphite_repo_config`. For repositories without this file, use standard git commands (`git commit`, `git push`, etc.).

## Detection

Check for `.git/.graphite_repo_config` to determine if a repo uses Graphite:
- **File exists:** Use `gt` commands (this skill applies)
- **File does not exist:** Use standard `git` commands (this skill does NOT apply)

When Graphite is detected, use `gt` commands instead of `git` for all commit and branch operations.

## MCP Server

A Graphite MCP server may be available (check with `/mcp`). If the `graphite` MCP is connected, it provides tools to work with stacked PRs.

## Planning Stacks (CRITICAL)

**Before writing any code, present the stack structure and ask for confirmation.**

When building a feature as a stack:

1. **Plan first** - break the work into logical, sequential PRs
2. **Use TodoWrite** - each todo item maps to one PR/`gt create`
3. **Present the structure** - show the user the planned stack:
   ```
   PR Stack for [Feature]:
   1. PR 1: [description] - [what it does]
   2. PR 2: [description] - [what it does]
   3. PR 3: [description] - [what it does]
   ```
4. **Ask for confirmation** - "Does this structure look good to proceed?"
5. **Only then start coding**

**IMPORTANT:** Each PR must be atomic and pass CI independently. Verify this before committing.

## Command Mapping

Use these `gt` commands instead of their git equivalents:

| Instead of | Use | Purpose |
|------------|-----|---------|
| `git commit` | `gt create -am "msg"` | Create new branch/PR with changes |
| `git commit --amend` | `gt modify -a` | Amend current PR |
| `git push` | `gt submit --no-interactive` | Submit current + all downstack branches |
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

Each PR in a stack must be:
- **Atomic** - passes CI independently, no broken intermediate states
- **Small** - ideally under 250 lines changed
- **Focused** - one logical change per branch
- **Reviewable** - makes sense on its own (even if it depends on others)

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
gt submit --no-interactive   # Submit current + all downstack branches (recommended)
gt submit --stack            # Submit current + all descendant branches
gt ss                        # Shorthand for --stack
```

Use `--no-interactive` to avoid prompts during submission.

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

### Building a Feature as a Stack

1. Plan the stack structure first (use TodoWrite)
2. Present to user and get confirmation
3. Implement each PR sequentially:

```bash
gt sync                                    # Get latest
gt create -am "feat: Add avatar upload API"
# ... verify it passes CI ...
gt create -am "feat: Add avatar display component"
# ... verify it passes CI ...
gt create -am "feat: Add avatar to user profile"
gt submit --no-interactive                 # Submit entire stack
```

### Addressing Review Feedback

```bash
gt checkout <branch-with-feedback>
# ... make fixes ...
gt modify -a                               # Amend changes
gt submit --no-interactive                 # Push updates (auto-restacks dependents)
```

### Daily Sync Routine

```bash
gt sync                                    # Pull, restack, clean
# Resolve any conflicts if prompted
gt continue -a                             # After resolving
```
