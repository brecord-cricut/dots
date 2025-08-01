export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_DATA_DIRS="${XDG_DATA_HOME}:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

if [[ -z "$XDG_RUNTIME_DIR" ]]; then
  if [[ "$(uname -s)" == "Darwin" ]]; then
    export XDG_RUNTIME_DIR="$(getconf DARWIN_USER_TEMP_DIR 2>/dev/null)"
  fi
  if [[ -z "$XDG_RUNTIME_DIR" ]]; then
    export XDG_RUNTIME_DIR=/tmp
  fi
fi

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
