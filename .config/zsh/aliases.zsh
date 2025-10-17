#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

aliases() {
  cd $ZSH_CUSTOM
  nvim aliases.zsh && source aliases.zsh
  cd - >/dev/null
}

repos() {
  local dir="$REPOS/$1"
  cd $dir 2&> /dev/null || echo "\"$dir\" is not a directory."
}
_reposCompletion() {
  compadd -- ${(f)"$(ls -1d $REPOS/*(/) 2>/dev/null | xargs -n1 basename)"}
}
compdef _reposCompletion repos

alias nv="$EDITOR"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

if command -v nproc &>/dev/null; then
  alias make="make -j$(nproc)"
fi

if [[ $(uname) == "Darwin" ]]; then
  alias ls="ls -G"
elif [[ $(uname) == "Linux" ]]; then
  alias ls="ls --color=auto"
fi
