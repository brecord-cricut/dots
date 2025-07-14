#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export NVMRC_PATH="$XDG_CONFIG_HOME/nvmrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"

plugins+=nvm
