#!/bin/sh
# Per-repo hook dispatcher, enabled for everything under ~/.local/share/repos
# via core.hooksPath (see ../hooks.config). Every hook name symlinks here.
#
# <repo> is the name of the directory holding the repo's shared .git dir
# (e.g. dots for repos/dots/.git and all of its worktrees).
# For each hook, in order:
#   1. post-checkout into a brand-new worktree or clone (all-zero previous
#      HEAD) runs <repo>/worktree-init.d/*.sh from the worktree root, with
#      git's repo-scoped env vars cleared
#   2. <repo>/<hook>.d/*.sh run with the hook's args and stdin
#   3. the repo's own hooks/<hook> runs, if installed, since core.hooksPath
#      otherwise hides it
# Scripts run in filename order; any non-zero exit aborts.

hook_name=$(basename "$0")
hooks_root=$(dirname "$0")

common_dir=$(git rev-parse --path-format=absolute --git-common-dir) || exit 1
# Submodules keep their git dir at <super>/.git/modules/<path>; only map
# top-level repos to a name.
repo=
[ "$(basename "$common_dir")" = .git ] && repo=$(basename "$(dirname "$common_dir")")

# Buffer stdin once so every script can read it
stdin_file=$(mktemp)
trap 'rm -f "$stdin_file"' EXIT
cat >"$stdin_file"

run_dir() {
  dir=$1
  shift
  [ -d "$dir" ] || return 0
  for script in "$dir"/*.sh; do
    [ -f "$script" ] && [ -x "$script" ] || continue
    "$script" "$@" <"$stdin_file" || {
      status=$?
      echo "hook: $hook_name aborted by ${script#"$hooks_root"/} (exit $status)" >&2
      exit $status
    }
  done
}

if [ -n "$repo" ] && [ "$hook_name" = post-checkout ] && [ "$3" = 1 ] &&
  [ -d "$hooks_root/$repo/worktree-init.d" ]; then
  case "$1" in
  *[!0]*) ;;
  *)
    (
      # e.g. GIT_IMPLICIT_WORK_TREE=0 when `worktree add` runs from a bare
      # repo, which breaks submodule clones and tools that shell out to git
      # shellcheck disable=SC2046
      unset $(git rev-parse --local-env-vars)
      echo "hook: initializing new $repo worktree $(basename "$PWD")"
      run_dir "$hooks_root/$repo/worktree-init.d"
    ) || exit
    ;;
  esac
fi

[ -n "$repo" ] && run_dir "$hooks_root/$repo/$hook_name.d" "$@"

if [ -x "$common_dir/hooks/$hook_name" ]; then
  "$common_dir/hooks/$hook_name" "$@" <"$stdin_file" || exit
fi
