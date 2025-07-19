#!/usr/bin/env zsh

export BROWSER=firefox
export EDITOR=nvim
export PAGER=less
export REPOS="$XDG_DATA_HOME/repos"
export TERMINAL=kitty

[[ -d $HOME/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"

if [[ $(uname) == "Darwin" ]]; then
  launchctl setenv BROWSER $BROWSER
  launchctl setenv EDITOR $EDITOR
  launchctl setenv PAGER $PAGER
  launchctl setenv TERMINAL $TERMINAL
fi
