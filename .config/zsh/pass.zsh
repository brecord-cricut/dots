#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

export PASSWORD_STORE_DIR="$REPOS/password-store/"

plugins+=pass
