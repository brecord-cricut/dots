#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
