aliases() {
  cd $ZSH_CUSTOM
  $EDITOR aliases.zsh
  cd - >/dev/null
  _refresh_zsh
}

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

alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

if command -v nproc &>/dev/null; then
  alias make="make -j$(nproc)"
fi

if [[ $(uname) == "Darwin" ]]; then
  alias ls="ls -G"
elif [[ $(uname) == "Linux" ]]; then
  alias ls="ls --color=auto"
fi
