if [[ $OSTYPE == darwin* ]]; then
  if (( ${+HOMEBREW_PREFIX} == 0 )); then
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  fi

  # Run path_helper to ensure proper PATH ordering
  [[ -x /usr/libexec/path_helper ]] && eval "$(/usr/libexec/path_helper -s)"
fi
