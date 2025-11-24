export BROWSER=firefox
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

export REPOS="$XDG_DATA_HOME/repos"

if [[ $OSTYPE == darwin* && ${+HOMEBREW_PREFIX} == 0 ]]; then
  (( ${+commands[brew]} )) && eval "$(brew shellenv)"
  [[ -x /usr/libexec/path_helper ]] && eval "$(/usr/libexec/path_helper -s)"
fi
