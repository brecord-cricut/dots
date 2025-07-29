#!/usr/bin/env zsh

export BROWSER=firefox
export EDITOR=nvim
export PAGER=less
export REPOS="$XDG_DATA_HOME/repos"
export TERMINAL=alacritty

[[ -d $HOME/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"

if [[ $(uname) == "Darwin" ]]; then
  launchctl setenv BROWSER $BROWSER
  launchctl setenv EDITOR $EDITOR
  launchctl setenv PAGER $PAGER
  launchctl setenv TERMINAL $TERMINAL
fi

_updateUserSettings() {
  for var in BROWSER EDITOR PAGER TERMINAL; do
    local value="${(P)var}"
    local file="$XDG_CONFIG_HOME/user/${var:l}"
    if [[ ! -f "$file" ]] || [[ "$(cat "$file" 2>/dev/null)" != "$value" ]]; then
      echo "$value" > "$file"
    fi
  done
}
_updateUserSettings
