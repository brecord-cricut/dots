[[ ! -t 0 ]] && return

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

_refresh_zsh() {
  if [[ -f $ZSH_UPDATE_TRIGGER_PATH ]]; then
    echo "Sourcing $HOME/.zshrc..."
    source ~/.zshrc
    rm -f "$ZSH_UPDATE_TRIGGER_PATH"
  fi
}

notes() {
  local notes_path="$NEXTCLOUD_DIR/Notes"
  if [[ -d "$notes_path" ]]; then
    cd "$notes_path"
    $EDITOR -c "lua require('persistence').load()" .
    cd - >/dev/null
  else
    echo "Notes directory not found: $notes_path"
  fi
}

nvimc() {
  cd "$XDG_CONFIG_HOME/nvim"
  nvim
  cd - >/dev/null
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

zshc() {
  cd "$ZDOTDIR"
  $EDITOR -c "lua require('persistence').load()"
  if [[ -f "$ZSH_STALE_PATH" ]]; then
    rm "$ZSH_STALE_PATH"
    [[ -r "$HOME/.zshenv" ]] && source "$HOME/.zshenv"
    [[ -r "$ZDOTDIR/.zshenv" ]] && source "$ZDOTDIR/.zshenv"
    [[ -r "$HOME/.zprofile" ]] && source "$HOME/.zprofile"
    [[ -r "$ZDOTDIR/.zprofile" ]] && source "$ZDOTDIR/.zprofile"
    [[ -r "$HOME/.zshrc" ]] && source "$HOME/.zshrc"
    [[ -r "$ZDOTDIR/.zshrc" ]] && source "$ZDOTDIR/.zshrc"
    echo ":: Resourced ZSH files"
  fi
  cd - >/dev/null
}

[[ -d "$XDG_CACHE_HOME/user" ]] || mkdir -p "$XDG_CACHE_HOME/user"
[[ -d "$XDG_CONFIG_HOME/user" ]] || mkdir -p "$XDG_CONFIG_HOME/user"
[[ -d "$XDG_DATA_HOME/user" ]] || mkdir -p "$XDG_DATA_HOME/user"

alias dflg="lazygit --git-dir=$REPOS/dots --work-tree=$HOME"
alias dots="git --git-dir=$REPOS/dots --work-tree=$HOME"
alias lg="lazygit"
alias ld="lazydocker"
alias ls="ls --color=auto"
alias ll="ls -la"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

if command -v nproc &>/dev/null; then
  alias make="make -j$(nproc)"
fi

if [[ -d "$ZDOTDIR"/rc ]]; then
  for file in "$ZDOTDIR"/rc/*.zsh; do
    if [[ -r "$file" ]]; then
      source "$file"
    fi
  done
  unset -v file
fi

if [[ -n $DISPLAY || -n $WAYLAND_DISPLAY || $OSTYPE == darwin* ]]; then
  [[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
else
  [[ ! -f $ZDOTDIR/.p10k.tty.zsh ]] || source $ZDOTDIR/.p10k.tty.zsh
fi
