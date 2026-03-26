lazygit() {
  if git rev-parse --git-dir &>/dev/null 2>&1; then
    command lazygit "$@"
  elif [[ -n "$(env "${DOTS_PREFIX[@]}" command git ls-files "$PWD" 2>/dev/null)" ]]; then
    env "${DOTS_PREFIX[@]}" command lazygit "$@"
  else
    command lazygit "$@"
  fi
}

dflg() { env "${DOTS_PREFIX[@]}" command lazygit "$@"; }
dots() { env "${DOTS_PREFIX[@]}" git "$@"; }

alias ld="lazydocker"
alias lg="lazygit"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
