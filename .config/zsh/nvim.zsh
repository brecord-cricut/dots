#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

nvimc() {
  cd $XDG_CONFIG_HOME/nvim
  $EDITOR -c "lua require('persistence').load()"
  cd - >/dev/null
}

plugins+=vi-mode
