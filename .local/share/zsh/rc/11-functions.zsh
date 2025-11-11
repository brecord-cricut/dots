extract() {
  if [[ -f "$1" ]]; then
    case $1 in
    *.tar.bz2 | *.tbz2) tar xjf "$1" ;;
    *.tar.gz | *.tgz) tar xzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# ── Create a temporary directory and cd into it ──────────────────────────
tmp() {
  local dir=$(mktemp -d "$XDG_RUNTIME_DIR/zsh.XXXXXX")
  echo "→ $dir"
  cd "$dir"
}

scratch() {
  tmp
  $EDITOR ${1:-scratch}.md
  cd - >/dev/null
}
