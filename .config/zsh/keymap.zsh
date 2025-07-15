#!/usr/bin/env zsh

if [ -f $XDG_CONFIG_HOME/custom.map ] && [[ $(uname) == "Linux" ]]; then
  sudo loadkeys $XDG_CONFIG_HOME/custom.map
fi
