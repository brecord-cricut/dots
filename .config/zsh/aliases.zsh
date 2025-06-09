#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

aliases() {
  $EDITOR $ZSH_CUSTOM/aliases.zsh
  refresh_zsh
}

zshc() {
  cd $ZSH_CUSTOM
  $EDITOR -c "lua require('persistence').load()"
  if [ -f $ZSH_UPDATE_TRIGGER_PATH ]; then
    echo "Sourcing $HOME/.zshrc..."
    source ~/.zshrc
    rm $ZSH_UPDATE_TRIGGER_PATH
  fi
  cd - >/dev/null
}

alias nv="$EDITOR"
alias repos="cd $XDG_DATA_HOME/repos"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

if command -v nproc &>/dev/null; then
  alias make="make -j$(nproc)"
fi

if [[ $(uname) == "Darwin" ]]; then
  alias ls="ls -G"
elif [[ $(uname) == "Linux" ]]; then
  alias ls="ls --color=auto"
fi
