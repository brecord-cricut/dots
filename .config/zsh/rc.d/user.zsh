export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CMAKE_PREFIX="$HOME/.local"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border=sharp --no-scrollbar"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export GOPATH="$XDG_DATA_HOME/go"
export LESS="-iMRx4 -j.5"
export MANPAGER="nvim +Man!"
export PASSWORD_STORE_DIR="$REPOS/password-store"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

alias dflg="lazygit --git-dir=$REPOS/dots --work-tree=$HOME"
alias dots="git --git-dir=$REPOS/dots --work-tree=$HOME"
alias ld="lazydocker"
alias lg="lazygit"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

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
