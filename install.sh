#!/usr/bin/env bash
# Symlink this repo's Claude skills + tools into ~/.claude on a new machine.
# Safe to re-run. Existing real dirs are backed up, not deleted.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_HOME:-$HOME/.claude}"
mkdir -p "$CLAUDE_DIR"

link() {
  local name="$1"
  local src="$REPO/$name"
  local dst="$CLAUDE_DIR/$name"

  if [ -L "$dst" ]; then
    # already a symlink — repoint it
    rm "$dst"
  elif [ -e "$dst" ]; then
    # real file/dir in the way — back it up
    local backup="$dst.backup.$(date +%Y%m%d%H%M%S)"
    echo "  backing up existing $dst -> $backup"
    mv "$dst" "$backup"
  fi
  ln -s "$src" "$dst"
  echo "  linked $dst -> $src"
}

echo "Installing Claude dotfiles from $REPO"
link skills
link tools
count=$(find -L "$CLAUDE_DIR/skills" -maxdepth 2 -name SKILL.md | wc -l | tr -d ' ')
echo "Done. $count skills available in $CLAUDE_DIR/skills"
