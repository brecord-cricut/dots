git-identity() {
  local cfg="$XDG_STATE_HOME/git/config"
  local name email
  read -r "name?Git author name: "
  read -r "email?Git author email: "
  if [[ -z "$name" || -z "$email" ]]; then
    print -u2 "git-identity: both name and email are required."
    return 1
  fi
  mkdir -p "${cfg:h}" || return 1
  [[ -e "$cfg" ]] || (
    umask 077
    : >"$cfg"
  ) || return 1
  git config --file "$cfg" user.name "$name" &&
    git config --file "$cfg" user.email "$email" || return 1
  print "Wrote git identity to $cfg"
}

if ! git config --get user.email >/dev/null 2>&1; then
  print -u2 "git: no user.email configured; run \`git-identity\` to set it."
fi

DOTS_PREFIX=(GIT_DIR="$REPOS/dots/.git" GIT_WORK_TREE="$HOME")

if command -v lazygit >/dev/null; then
  lazygit() {
    if git rev-parse --git-dir &>/dev/null 2>&1; then
      command lazygit "$@"
    elif [[ -n "$(env "${DOTS_PREFIX[@]}" git ls-files "$PWD" 2>/dev/null)" ]]; then
      env "${DOTS_PREFIX[@]}" command lazygit "$@"
    else
      command lazygit "$@"
    fi
  }
  alias lg="lazygit"
fi

dflg() { env "${DOTS_PREFIX[@]}" lazygit "$@"; }
dots() { env "${DOTS_PREFIX[@]}" git "$@"; }

wtadd() {
  local dir branch
  if [[ $# -eq 2 ]]; then
    local id="$1" subject="$2"
    dir="${id}-${subject}"
    branch="br/${id}"
  else
    local subject="$1"
    dir="${subject}"
    branch="${subject}"
  fi

  git worktree add "$dir" -b "$branch" || return 1
  cd "$dir" || return 1
}
