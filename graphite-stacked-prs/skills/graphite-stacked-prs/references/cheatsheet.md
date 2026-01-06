# Graphite CLI Cheatsheet

## Viewing Stack

| Command | Short | Description |
|---------|-------|-------------|
| `gt log` | | Full stack with PR info |
| `gt log short` | `gt ls` | Abbreviated stack view |

## Creating & Modifying

| Command | Short | Description |
|---------|-------|-------------|
| `gt create [name]` | `gt c` | New branch |
| `gt create --all --message "msg"` | `gt c -am "msg"` | New branch, stage all, commit |
| `gt modify` | `gt m` | Amend staged changes |
| `gt modify --all` | `gt m -a` | Stage all and amend |
| `gt modify --commit` | `gt m -c` | Add new commit (not amend) |

## Syncing & Submitting

| Command | Short | Description |
|---------|-------|-------------|
| `gt sync` | | Pull trunk, restack, clean merged |
| `gt submit` | `gt s` | Push current branch, create/update PR |
| `gt submit --stack` | `gt ss` | Push entire stack |
| `gt submit --stack --update-only` | `gt ss -u` | Update existing PRs only |

## Navigation

| Command | Short | Description |
|---------|-------|-------------|
| `gt checkout [branch]` | `gt co` | Switch to branch |
| `gt up [steps]` | `gt u` | Move up in stack |
| `gt down [steps]` | `gt d` | Move down in stack |
| `gt top` | `gt t` | Jump to stack top |
| `gt bottom` | `gt b` | Jump to stack bottom |

## Reorganizing

| Command | Short | Description |
|---------|-------|-------------|
| `gt move --onto <branch>` | | Move branch to new parent |
| `gt fold` | | Merge into parent branch |
| `gt split` | `gt sp` | Divide branch into multiple |
| `gt squash` | `gt sq` | Combine commits into one |
| `gt reorder` | | Reorder stack interactively |
| `gt absorb` | `gt ab` | Distribute staged changes to downstack |

## Recovery

| Command | Description |
|---------|-------------|
| `gt undo` | Revert recent Graphite operation |
| `gt abort` | Stop rebase/conflict resolution |
| `gt continue` | Resume after conflict resolution |
| `gt continue -a` | Stage all and continue |

## Collaboration

| Command | Short | Description |
|---------|-------|-------------|
| `gt get [branch]` | | Fetch teammate's stack |
| `gt track [branch]` | `gt tr` | Track existing git branch |
| `gt untrack [branch]` | `gt utr` | Stop tracking branch |

## Branch Management

| Command | Description |
|---------|-------------|
| `gt delete [branch]` | Delete branch |
| `gt rename [name]` | Rename current branch |
| `gt restack` | Rebase stack to fix parent relationships |

## Info & Config

| Command | Description |
|---------|-------------|
| `gt info` | Show branch details |
| `gt trunk` | Show/manage trunk branches |
| `gt auth --token <token>` | Authenticate with GitHub |
