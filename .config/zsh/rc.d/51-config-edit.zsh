# Open one of the tracked config directories in nvim against the dots work
# tree, so edits there are staged against the dotfiles repo rather than
# whatever repo happens to be the cwd. `<name>c d` cds there and prints the
# path instead of opening an editor.
#
# Requires DOTS_PREFIX from 50-git.zsh.

export ZSH_STALE_PATH="$XDG_RUNTIME_DIR/zsh_stale"

_dots_config_edit() {
  cd "$1" || return 1
  case "$2" in
  "d") pwd ;;
  *)
    env "${DOTS_PREFIX[@]}" nvim
    cd - >/dev/null
    ;;
  esac
}

hyprc() { _dots_config_edit "$XDG_CONFIG_HOME/hypr" "$1" }
nvimc() { _dots_config_edit "$XDG_CONFIG_HOME/nvim" "$1" }

zshc() {
  _dots_config_edit "$ZDOTDIR" "$1" || return 1

  # The file $ZSH_STALE_PATH is created via a Neovim autocmd.
  # See $XDG_CONFIG_HOME/nvim/lua/custom/autocmds/zsh.lua
  if [[ -f "$ZSH_STALE_PATH" ]]; then
    echo ":: Sourcing zsh config..."
    \rm -f "$ZSH_STALE_PATH"
    exec zsh
  fi
}
