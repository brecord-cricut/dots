DOTS_PREFIX=(GIT_DIR=$REPOS/dots/.git GIT_WORK_TREE=$HOME)

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

((${+commands[claude]})) && alias cl="claude"
((${command[lazydocker]})) && alias ld="lazydocker"
((${command[opencode]})) && alias oc="OPENCODE=1 command opencode"
((${command[tmux]})) && alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
((${command[wget]})) && alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
