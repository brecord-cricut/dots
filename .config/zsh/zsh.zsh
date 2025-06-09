#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

if [[ -n "$XDG_RUNTIME_DIR" ]]; then
  export ZSH_UPDATE_TRIGGER_PATH="$XDG_RUNTIME_DIR/zsh_updated"
elif [[ -n "$(getconf DARWIN_USER_TEMP_DIR 2>/dev/null)" ]]; then
  export ZSH_UPDATE_TRIGGER_PATH="$(getconf DARWIN_USER_TEMP_DIR)zsh_updated"
else
  export ZSH_UPDATE_TRIGGER_PATH="/tmp/zsh_updated"
fi

_refresh_zsh() {
  if [ -f $ZSH_UPDATE_TRIGGER_PATH ]; then
    echo "Sourcing $HOME/.zshrc..."
    source ~/.zshrc
    rm -f $ZSH_UPDATE_TRIGGER_PATH
  fi
}

zshc() {
  cd $ZSH_CUSTOM
  $EDITOR -c "lua require('persistence').load()"
  cd - >/dev/null
  _refresh_zsh
}

plugins+=zsh-interactive-cd
