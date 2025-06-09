_refresh_zsh() {
  if [ -f $ZSH_UPDATE_TRIGGER_PATH ]; then
    echo "Sourcing $HOME/.zshrc..."
    source ~/.zshrc
    rm -f $ZSH_UPDATE_TRIGGER_PATH
  fi
}

zshc() {
  cd $ZSH_CUSTOM
  $EDITOR -c "lua require('persistence').load()"
  cd - >/dev/null
  _refresh_zsh
}
