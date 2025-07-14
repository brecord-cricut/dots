#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

alias dflg="lazygit --git-dir=$XDG_DATA_HOME/repos/dots --work-tree=$HOME"
alias lg="lazygit"

# Make symbolic link for macos to $XDG_CONFIG_HOME/lazygit:
if [[ "$(uname)" == "Darwin" ]]; then
  xdg_config_dir="$XDG_CONFIG_HOME/lazygit"
  macos_config_dir="$HOME/Library/Application Support/lazygit"
  if [[ ! -L "$macos_config_dir" && -d "$xdg_config_dir" ]]; then
    echo "Backing up existing directory at: $macos_config_dir → $macos_config_dir.bak"
    mv "$macos_config_dir" "$macos_config_dir.bak" 2>/dev/null
    echo "Creating symlink: $xdg_config_dir → $macos_config_dir"
    ln -s "$xdg_config_dir" "$macos_config_dir"
  fi
  unset xdg_config_dir macos_config_dir
fi
