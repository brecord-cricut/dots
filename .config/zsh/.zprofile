export BROWSER=firefox
export EDITOR=nvim
export PAGER=less
export REPOS="$XDG_DATA_HOME/repos"
export TERMINAL=kitty

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CMAKE_PREFIX="$HOME/.local"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export GOPATH="$XDG_DATA_HOME/go"
export NEXTCLOUD_DIR=$XDG_DATA_HOME/Nextcloud
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
export NVMRC_PATH="$XDG_CONFIG_HOME/nvmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export PASSWORD_STORE_DIR="$REPOS/password-store/"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
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
