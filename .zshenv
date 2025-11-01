export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

if [[ -z "$XDG_RUNTIME_DIR" ]]; then
  if [[ "$(uname -s)" == "Darwin" ]]; then
    export XDG_RUNTIME_DIR="$(getconf DARWIN_USER_TEMP_DIR 2>/dev/null)"
  fi
  if [[ -z "$XDG_RUNTIME_DIR" ]]; then
    export XDG_RUNTIME_DIR=/tmp
  fi
fi

for dir in "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"; do
  [[ -d "$dir" ]] || mkdir -p "$dir"
done

export BROWSER=firefox
export EDITOR=nvim
export NEXTCLOUD_DIR="$XDG_DATA_HOME/Nextcloud"
export PAGER=less
export PASSWORD_STORE_DIR="$REPOS/password-store/"
export REPOS="$XDG_DATA_HOME/repos"
export TERMINAL=kitty
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
