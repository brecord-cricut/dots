#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

nvimc() {
  cd $XDG_CONFIG_HOME/nvim
  if [[ "$1" == "d" ]]; then
    pwd
  else
    nvim -c "PersistenceLoad"
    cd - >/dev/null
  fi
}

plugins+=vi-mode
