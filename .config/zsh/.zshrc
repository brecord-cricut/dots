[[ ! -t 0 ]] && return

_refresh_zsh() {
  if [ -f $ZSH_UPDATE_TRIGGER_PATH ]; then
    echo "Sourcing $HOME/.zshrc..."
    source ~/.zshrc
    rm -f "$ZSH_UPDATE_TRIGGER_PATH"
  fi
}

notes() {
  local notes_path="$NEXTCLOUD_DIR/Notes"
  if [ -d "$notes_path" ]; then
    cd "$notes_path"
    $EDITOR -c "lua require('persistence').load()" .
    cd - >/dev/null
  else
    echo "Notes directory not found: $notes_path"
  fi
}

nvimc() {
  cd "$XDG_CONFIG_HOME/nvim"
  case "$1" in
  "d") pwd ;;
  *)
    nvim
    cd - >/dev/null
    ;;
  esac
}

repos() {
  local dir="$REPOS/$1"
  [[ -d "$dir" ]] && cd "$dir" || echo "\"$dir\" is not a directory."
}

if command -v compdef &> /dev/null; then
  _reposCompletion() {
    compadd -- ${(f)"$(ls -1d $REPOS/*(/) 2>/dev/null | xargs -n1 basename)"}
  }
  compdef _reposCompletion repos
fi

[[ -d "$XDG_CACHE_HOME/$USER" ]] || mkdir -p "$XDG_CACHE_HOME/$USER"
[[ -d "$XDG_CONFIG_HOME/$USER" ]] || mkdir -p "$XDG_CONFIG_HOME/$USER"
[[ -d "$XDG_DATA_HOME/$USER" ]] || mkdir -p "$XDG_DATA_HOME/$USER"

alias dflg="lazygit --git-dir=$REPOS/dots --work-tree=$HOME"
alias dots="git --git-dir=$REPOS/dots --work-tree=$HOME"
alias ld="lazydocker"
alias lg="lazygit"
alias ll="ls -lah"
alias ls="ls --color=auto"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

if command -v nproc &>/dev/null; then
  alias make="make -j$(nproc)"
fi

if [ -d "$ZDOTDIR"/rc ]; then
  for file in "$ZDOTDIR"/rc/*.zsh; do
    if [ -r "$file" ]; then
      source "$file"
    fi
  done
  unset -v file
fi
