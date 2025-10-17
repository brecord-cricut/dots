#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
