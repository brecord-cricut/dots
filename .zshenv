: ${XDG_CACHE_HOME:=$HOME/.cache}
: ${XDG_CONFIG_HOME:=$HOME/.config}
: ${XDG_DATA_HOME:=$HOME/.local/share}
: ${XDG_STATE_HOME:=$HOME/.local/state}
: ${XDG_RUNTIME_DIR:=/run/user/$UID}

if [[ ! -d $XDG_RUNTIME_DIR || ! -w $XDG_RUNTIME_DIR ]]; then
  if [[ $OSTYPE == darwin* ]] && dir=$(getconf DARWIN_USER_TEMP_DIR 2>/dev/null) && [[ -d $dir ]]; then
    XDG_RUNTIME_DIR=$dir
  else
    XDG_RUNTIME_DIR=$XDG_CACHE_HOME/zsh-runtime
    mkdir -pm 700 $XDG_RUNTIME_DIR
  fi
fi

export XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME XDG_RUNTIME_DIR

typeset -gx ZDOTDIR=$XDG_CONFIG_HOME/zsh
typeset -gx ZSH_CACHE=$XDG_CACHE_HOME/zsh
typeset -gx ZSH_DATA=$XDG_DATA_HOME/zsh
typeset -gx ZSH_STATE=$XDG_STATE_HOME/zsh
