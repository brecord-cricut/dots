repos() {
  local dir="$REPOS/$1"
  [[ -d "$dir" ]] && cd "$dir" || echo "\"$dir\" is not a directory."
}

if command -v compdef &> /dev/null; then
  _reposCompletion() {
    _files -W "$REPOS" -/
  }
  compdef _reposCompletion repos
fi
