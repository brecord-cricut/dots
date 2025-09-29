[[ ! -t 0 ]] && return

export BROWSER=qutebrowser
export EDITOR=nvim
export PAGER=less
export REPOS="$XDG_DATA_HOME/repos"
export TERMINAL=kitty

export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export CMAKE_PREFIX="$HOME/.local"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export GOPATH="$XDG_DATA_HOME/go"
export NEXTCLOUD_DIR="$XDG_DATA_HOME/Nextcloud"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
export NVMRC_PATH="$XDG_CONFIG_HOME/nvmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export PASSWORD_STORE_DIR="$REPOS/password-store/"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
export ZSH_STALE_PATH="$XDG_RUNTIME_DIR/zsh_stale"

if [[ "$(uname -s)" == "Darwin" ]]; then
  export JAVA_HOME="$HOMEBREW_CELLAR/openjdk/24.0.1"
elif [[ "$(uname -s)" == "Linux" ]]; then
  export JAVA_HOME="$XDG_DATA_HOME/openjdk/current"
fi

[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
[[ -d "$HOME/.pub-cache/bin" ]] && path+=("$HOME/.pub-cache/bin")
[[ -d "$JAVA_HOME" ]] && path=("$JAVA_HOME/bin" $path)
[[ -d "$NEXTCLOUD_DIR/bin" ]] && path=("$NEXTCLOUD_DIR/bin" $path)

if [[ -d "$ZDOTDIR"/env ]]; then
  for file in "$ZDOTDIR"/env/*.zsh; do
    if [[ -r "$file" ]]; then
      source "$file"
    fi
  done
  unset -v file
fi

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
  $EDITOR -c "lua require('persistence').load()"
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

[[ -d "$NVM_DIR" ]] && source $NVM_DIR/nvm.sh
[[ -d "$XDG_CACHE_HOME/user" ]] || mkdir -p "$XDG_CACHE_HOME/user"
[[ -d "$XDG_CONFIG_HOME/user" ]] || mkdir -p "$XDG_CONFIG_HOME/user"
[[ -d "$XDG_DATA_HOME/user" ]] || mkdir -p "$XDG_DATA_HOME/user"

alias dflg="lazygit --git-dir=$REPOS/dots --work-tree=$HOME"
alias dots="git --git-dir=$REPOS/dots --work-tree=$HOME"
alias lg="lazygit"
alias ls="ls --color=auto"
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
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
