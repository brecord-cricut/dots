#!/bin/sh
# Clear zcompdump if any tracked zsh config files changed in this merge

changed_files=$(git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD)

if echo "$changed_files" | grep -qE '(\.zshrc|\.config/zsh/(env|rc)\.d/)'; then
  rm -f "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"*
fi
