#!/usr/bin/env zsh

notes() {
  local notes_path="$HOME/Nextcloud/Notes"
  if [[ -d $notes_path ]]; then
    cd $notes_path
    $EDITOR -c "lua require('persistence').load()" .
    cd - >/dev/null
  else
    echo "Notes directory not found: $notes_path"
  fi
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

alias aliases="$EDITOR $ZSH_CUSTOM/aliases.zsh && source $ZSH_CUSTOM/aliases.zsh; cd - >/dev/null"
alias nv="$EDITOR"
alias repos="cd $XDG_DATA_HOME/repos"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

[[ -x nproc ]] && alias make="make -j${nproc}"

if [[ $(uname) == "Darwin" ]]; then
  alias ls="ls -G"
elif [[ $(uname) == "Linux" ]]; then
  alias ls="ls --color=auto"
fi
