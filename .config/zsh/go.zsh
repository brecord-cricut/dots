#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export GOPATH="$XDG_DATA_HOME/go"
