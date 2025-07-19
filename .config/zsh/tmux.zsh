#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

plugins+=tmux

alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
