_refresh_zsh() {
  if [ -f $ZSH_UPDATE_TRIGGER_PATH ]; then
    echo "Sourcing $HOME/.zshrc..."
    source ~/.zshrc
    rm -f $ZSH_UPDATE_TRIGGER_PATH
  fi
}

aliases() {
  cd $ZSH_CUSTOM
  $EDITOR aliases.zsh
  cd - >/dev/null
  _refresh_zsh
}

notes() {
  local notes_path="$NEXTCLOUD_DIR/Notes"
  if [[ -d $notes_path ]]; then
    cd $notes_path
    $EDITOR -c "lua require('persistence').load()" .
    cd - >/dev/null
  else
    echo "Notes directory not found: $notes_path"
  fi
}

nvimc() {
  cd $XDG_CONFIG_HOME/nvim
  $EDITOR -c "lua require('persistence').load()"
  cd - >/dev/null
}

repos() {
  local dir="$REPOS/$1"
  [[ -d $dir ]] && cd $dir || echo "\"$dir\" is not a directory."
}
if command -v compdef &> /dev/null; then
  _reposCompletion() {
    compadd -- ${(f)"$(ls -1d $REPOS/*(/) 2>/dev/null | xargs -n1 basename)"}
  }
  compdef _reposCompletion repos
fi

zshc() {
  cd $ZSH_CUSTOM
  $EDITOR -c "lua require('persistence').load()"
  if [ -f $ZSH_UPDATE_TRIGGER_PATH ]; then
    echo "Sourcing $HOME/.zshrc..."
    source ~/.zshrc
    rm $ZSH_UPDATE_TRIGGER_PATH
  fi
  cd - >/dev/null
}

if command -v rbenv >/dev/null; then
  eval "$(rbenv init -)"
  export GEM_HOME="$XDG_DATA_HOME/gem"
  export PATH="$GEM_HOME/bin:$PATH"
fi

[[ $(uname) == "Linux" ]] && [[ -f $XDG_CONFIG_HOME/custom.map ]] && sudo loadkeys $XDG_CONFIG_HOME/custom.map
