#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

alias dflg="lazygit --git-dir=$REPOS/dots --work-tree=$HOME"
alias lg="lazygit"
