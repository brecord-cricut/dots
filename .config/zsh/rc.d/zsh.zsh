export ZSH_STALE_PATH="$XDG_RUNTIME_DIR/zsh_stale"

zshc() {
  cd "$ZDOTDIR"
  case "$1" in
  "d") pwd ;;
  *)
    nvim
    # The file $ZSH_STALE_PATH is created via a Neovim autocmd.
    # See $XDG_CONFIG_HOME/nvim/lua/custom/autocmds/zsh.lua
    if [[ -f "$ZSH_STALE_PATH" ]]; then
      echo ":: Sourcing zsh config..."
      \rm "$ZSH_STALE_PATH"
      exec zsh
    fi
    cd - >/dev/null
    ;;
  esac
}
