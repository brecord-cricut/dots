export BROWSER=firefox
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
export NEXTCLOUD_DIR=$XDG_DATA_HOME/Nextcloud
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
export NVMRC_PATH="$XDG_CONFIG_HOME/nvmrc"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export PASSWORD_STORE_DIR="$REPOS/password-store/"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
export ZSH="$HOME/.local/share/oh-my-zsh"
export ZSH_CACHE_DIR="$ZSH/cache"
export ZSH_CUSTOM="$HOME/.config/zsh"
export ZSH_UPDATE_TRIGGER_PATH="$XDG_RUNTIME_DIR/zsh_updated"

[[ -d $HOME/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"

for var in BROWSER EDITOR PAGER TERMINAL; do
  file="$XDG_CONFIG_HOME/user/${var:l}"
  value="${(P)var}"
  if [[ ! -f "$file" ]] || [[ "$(cat "$file" 2>/dev/null)" != "$value" ]]; then
    echo "$value" > "$file"
  fi
done
unset file value
