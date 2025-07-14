#!/usr/bin/env zsh

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS="${XDG_DATA_HOME}:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

if [ -z "$XDG_RUNTIME_DIR" ]; then
  if [ $(uname) == "Darwin" ]; then
    export XDG_RUNTIME_DIR="$(getconf DARWIN_USER_TEMP_DIR 2>/dev/null)"
  fi
  if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR=/tmp
  fi
fi

export BROWSER=firefox
export EDITOR=nvim
export PAGER=less
export REPOS="$XDG_DATA_HOME/repos"
export TERMINAL=kitty

export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
export ZSH="$HOME/.local/share/oh-my-zsh"
export ZSH_CACHE_DIR="$ZSH/cache"
export ZSH_CUSTOM="$HOME/.config/zsh"

if ! source $ZDOTDIR/.zshenv; then
  echo "FATAL Error: Could not source $ZDOTDIR/.zshenv"
  return 1
fi
