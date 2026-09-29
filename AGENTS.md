# nixos-config

## Agent skills

### Issue tracker

GitHub Issues via the `gh` CLI. See `docs/agents/issue-tracker.md`.

### Triage labels

Default five-role vocabulary (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: root `GLOSSARY.md` + `docs/adr/`. See `docs/agents/domain.md`.

## Workflow

Dotfiles repo — keep it light:

- **Small tweaks** (config adjustments, one-liners): work directly in `master/`, commit and push. No worktree, no issue.
- **Multi-step or risky changes**: use a feature worktree (`wtree.sh feature <name>`), merge back with `wtree.sh finish <name>` (rebases onto the default branch, ff-merges, removes the worktree dir, deletes the branch).
- **Rebuilds**: run `nixos-rebuild` only from `master/` or a path the user names explicitly — never from a feature worktree (that deploys WIP config to the host).
- **Big changes** (new host, new module): ad hoc by default — open a worktree and go. The issue pipeline (`/to-spec`, `/to-tickets`) is opt-in, not the mandatory path. GitHub Issues are for genuine bugs and ideas.
