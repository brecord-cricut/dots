#!/usr/bin/env zsh

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
export XDG_DATA_DIRS="$XDG_DATA_HOME:$XDG_DATA_DIRS"

[[ -d "$XDG_CACHE_HOME/user" ]] || mkdir "$XDG_CACHE_HOME/user"
[[ -d "$XDG_CONFIG_HOME/user" ]] || mkdir "$XDG_CONFIG_HOME/user"
