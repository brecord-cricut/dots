#!/usr/bin/env zsh

export EDITOR="nvim"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export REPOS="$XDG_DATA_HOME/repos"

if [[ -n "$XDG_RUNTIME_DIR" ]]; then
  export ZSH_UPDATE_TRIGGER_PATH="$XDG_RUNTIME_DIR/zsh_updated"
elif [[ -n "$(getconf DARWIN_USER_TEMP_DIR 2>/dev/null)" ]]; then
  export ZSH_UPDATE_TRIGGER_PATH="$(getconf DARWIN_USER_TEMP_DIR)zsh_updated"
else
  export ZSH_UPDATE_TRIGGER_PATH="/tmp/zsh_updated"
fi

[[ -d $HOME/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"
