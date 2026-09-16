repos() {
  local dir="$REPOS/$1"
  if [[ -d "$dir" ]]; then
    cd "$dir"
    return
  fi

  # Match partial input: `repos f` would resolve to `cd $REPOS/foo`, if that directory exists.
  local matches=("$REPOS"/$1*(N/))
  if ((${#matches[@]} > 0)); then
    cd "${matches[1]}"
  else
    echo "\"$dir\" is not a directory."
  fi
}

if command -v compdef &>/dev/null; then
  _reposCompletion() {
    _files -W "$REPOS" -/
  }
  compdef _reposCompletion repos
fi
