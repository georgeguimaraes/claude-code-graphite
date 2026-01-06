# Conflict Resolution in Graphite

## When Conflicts Occur

Conflicts happen during `gt sync` or `gt restack` when:
- Trunk has changes that overlap with stack changes
- Mid-stack edits affect dependent branches
- Multiple people modify the same code

## Resolution Workflow

### 1. Identify the Conflict

When Graphite pauses for conflicts:

```bash
git status              # See conflicted files
gt log                  # See which branch is being rebased
```

### 2. Understand the Context

Before resolving, understand what each side is doing:

```bash
# See what the current branch changed
git diff HEAD~1

# See what's incoming
git diff REBASE_HEAD
```

Check the PR descriptions and commit messages to understand intent.

### 3. Resolve Conflicts

#### Auto-Resolvable (Handle Automatically)

These conflicts can typically be resolved without asking:

**Import order changes:**
- Keep all imports, sort them appropriately
- Deduplicate if same import appears twice

**Whitespace/formatting:**
- Accept the version that matches project style
- Or accept incoming if it's just reformatting

**Non-overlapping additions:**
- If both sides added different things to a list/file
- Keep both additions in logical order

**Version bumps:**
- Take the higher version number

#### Ambiguous (Ask the User)

Stop and ask about these conflicts:

**Same code modified differently:**
- Both sides changed the same function/logic
- Need to understand which behavior is intended

**Delete vs modify:**
- One side deleted code, other modified it
- Need to know if deletion was intentional

**Semantic conflicts:**
- Changes that compile but might break logic
- Function signature changes affecting callers

**Test conflicts:**
- Test expectations changed on both sides
- Need to determine correct expected behavior

### 4. Complete Resolution

After resolving all conflicts in a file:

```bash
git add <file>          # Stage resolved file
```

After all files resolved:

```bash
gt continue -a          # Stage remaining and continue restack
```

If things go wrong:

```bash
gt abort                # Abandon and return to pre-restack state
```

## Common Conflict Patterns

### Pattern: Lock File Conflicts

`package-lock.json`, `yarn.lock`, `mix.lock`, etc.

**Resolution:** Regenerate the lock file:
```bash
# Accept either version, then regenerate
git checkout --theirs package-lock.json
npm install
git add package-lock.json
```

### Pattern: Migration Conflicts

Database migration files with sequence numbers.

**Resolution:** Usually keep both, but may need to renumber:
- Check if migrations are independent
- Renumber if needed to maintain order
- Ensure no conflicting schema changes

### Pattern: Generated Code Conflicts

Auto-generated files (GraphQL types, API clients, etc.)

**Resolution:** Regenerate from source:
```bash
git checkout --theirs <generated-file>
# Run generation command
npm run generate
git add <generated-file>
```

### Pattern: Test Snapshot Conflicts

Jest snapshots, approval tests, etc.

**Resolution:**
- If test logic changed, regenerate snapshots
- If snapshot format changed, accept incoming
- Run tests to verify

### Pattern: Config File Conflicts

`.eslintrc`, `tsconfig.json`, etc.

**Resolution:**
- Merge config options manually
- Test that combined config works
- Watch for conflicting rules

## Prevention Strategies

### Keep PRs Small

Smaller PRs = fewer potential conflicts:
- One logical change per PR
- Split large refactors into steps
- Avoid mixing unrelated changes

### Sync Frequently

Run `gt sync` at least daily:
- Catches conflicts early when easier to resolve
- Prevents conflict accumulation
- Keeps stack fresh with trunk changes

### Coordinate on Shared Code

When multiple people touch same areas:
- Communicate about who's changing what
- Consider sequential rather than parallel work
- Review and merge foundational changes first

### Stack Strategically

Order stack to minimize conflicts:
- Put risky/conflicting changes at top (easier to rebase)
- Put stable changes at bottom
- Consider dependencies between changes

## Debugging Difficult Conflicts

### Check Branch History

```bash
gt log                  # See stack structure
git log --oneline -10   # Recent commits
git diff main...HEAD    # All changes from trunk
```

### Visualize Conflict

```bash
git diff                # See current conflicts
git log --merge         # Commits involved in conflict
```

### Reset and Retry

If resolution went wrong:

```bash
gt abort                # Return to pre-restack state
gt sync                 # Try again fresh
```

### Manual Rebase Control

For complex situations:

```bash
gt abort
git rebase --onto <target> <old-base> <branch>
gt restack              # Let Graphite fix the rest
```
