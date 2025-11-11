if [[ $OSTYPE == darwin* && ${+HOMEBREW_PREFIX} == 0 ]]; then
  (( ${+commands[brew]} )) && eval "$(brew shellenv)"
  [[ -x /usr/libexec/path_helper ]] && eval "$(/usr/libexec/path_helper -s)"
  path=(/opt/homebrew/bin(N-/) $path)
fi
