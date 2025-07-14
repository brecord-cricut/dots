#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
