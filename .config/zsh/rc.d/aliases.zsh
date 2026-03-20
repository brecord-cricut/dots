dflg() {
  env "${DOTS_PREFIX[@]}" lazygit "$@"
}
dots() {
  env "${DOTS_PREFIX[@]}" git "$@"
}
alias ld="lazydocker"
alias lg="lazygit"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
