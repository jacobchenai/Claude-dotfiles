# claude-dotfiles

Portable Claude skill library. Single source of truth for the skills and shared
tool registry used across all my machines. `~/.claude/skills` and
`~/.claude/tools` are symlinked to the directories in this repo.

## Contents

- `skills/` — 68 skills (installed globally, available in every folder/session)
  - `stop-slop` — remove AI writing tells
  - `task-observer` — skill-improvement observer (from *one-skill-to-rule-them-all*)
  - 49 marketing skills (from *coreyhaines31/marketingskills*)
  - 17 context-engineering skills (from *muratcankoylan/agent-skills-for-context-engineering*)
- `tools/` — shared registry (`REGISTRY.md` + `integrations/`) that the marketing
  skills reference via `../../tools/...`

## Set up on a new machine

```bash
git clone <this-repo-url> ~/claude-dotfiles
~/claude-dotfiles/install.sh
```

`install.sh` symlinks `skills/` and `tools/` into `~/.claude/`. It's safe to
re-run: any existing real directory is backed up to `*.backup.<timestamp>`
rather than overwritten. Set `CLAUDE_HOME` to target a non-default location.

## Adding / updating skills

Edit files under `skills/` here (the `~/.claude/skills` symlink points back), then:

```bash
cd ~/claude-dotfiles && git add -A && git commit -m "update skills" && git push
```

On other machines: `cd ~/claude-dotfiles && git pull`.

## Not included

- `claude-mem` — install via `/plugin install claude-mem` inside Claude Code
  (it wires up its own hooks + database; not a static skill).
