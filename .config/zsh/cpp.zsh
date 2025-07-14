#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

export CMAKE_PREFIX_PATH="$HOME/.local"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
