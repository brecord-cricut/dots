#!/usr/bin/env zsh

[ -d "$HOME/.local/state/zsh" ] || mkdir -p "$HOME/.local/state/zsh"
[ -d "$HOME/.cache/zsh" ] || mkdir -p "$HOME/.cache/zsh"

export ZSH="$HOME/.local/share/oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/zsh"
export ZSH_CACHE_DIR="$ZSH/cache"

HISTFILE="$ZSH_CACHE_DIR/history"
HISTSIZE=10000
SAVEHIST=1000
bindkey -v

zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit -C

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

function ensure_plugin_installed() {
  local plugin_name=$(basename -s ".git" "$1")
  local plugin_path="${ZSH_CUSTOM}/plugins/${plugin_name}"

  if [ ! -d "$plugin_path" ]; then
    echo "Installing ZSH plugin: $plugin_name"
    git clone "$1" "$plugin_path" || echo "Failed to clone $plugin_name"
  fi
}

ensure_plugin_installed https://github.com/zdharma-continuum/fast-syntax-highlighting.git
ensure_plugin_installed https://github.com/zsh-users/zsh-autosuggestions.git

unset -f ensure_plugin_installed

plugins=(
  dirhistory
  zsh-autosuggestions
  fast-syntax-highlighting
)

if [ ! -d "$ZSH" ]; then
  zsh_repo=https://github.com/Benjman/ohmyzsh.git
  echo "oh-my-zsh not found."
  read "?Would you like to clone it ($zsh_repo)? (y/n): " response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    git clone "$zsh_repo" "$ZSH"
  fi
  unset zsh_repo
fi

source $ZSH/oh-my-zsh.sh
