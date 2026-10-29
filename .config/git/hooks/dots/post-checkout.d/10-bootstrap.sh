#!/bin/sh
# Idempotent first-run setup: ensure XDG base dirs exist and submodules are
# initialized. Safe to run on every checkout (branch switches included) since
# every step is a no-op once done.

: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_STATE_HOME:=$HOME/.local/state}"

for d in "$XDG_CACHE_HOME/zsh" "$XDG_STATE_HOME/zsh/env" "$XDG_STATE_HOME/zsh/rc" \
  "$XDG_STATE_HOME/git" "$XDG_DATA_HOME/repos" "$XDG_DATA_HOME/wallpapers" \
  "$XDG_CONFIG_HOME/npm"; do
  [ -d "$d" ] || mkdir -p "$d"
done

# git submodule specifically requires GIT_DIR + a cwd inside the work tree,
# not GIT_WORK_TREE — the two combined make submodule refuse to run.
dots_git() {
  GIT_DIR="$XDG_DATA_HOME/repos/dots/.git" git -C "$HOME" "$@"
}

if dots_git submodule status 2>/dev/null | grep -q '^-'; then
  echo "post-checkout: initializing submodules..."
  dots_git submodule update --init
fi
