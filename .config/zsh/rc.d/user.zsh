repos() {
  local dir="$REPOS/$1"
  [[ -d "$dir" ]] && cd "$dir" || echo "\"$dir\" is not a directory."
}

if command -v compdef &> /dev/null; then
  _reposCompletion() {
    compadd -- ${(f)"$(ls -1d $REPOS/*(/) 2>/dev/null | xargs -n1 basename)"}
  }
  compdef _reposCompletion repos
fi
