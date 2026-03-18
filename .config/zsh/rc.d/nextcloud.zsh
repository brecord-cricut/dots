NEXTCLOUD_DIR="${NEXTCLOUD_DIR:-XDG_DATA_HOME/Nextcloud}"

[[ -d "$NEXTCLOUD_DIR" ]] || return 0
[[ -d "$NEXTCLOUD_DIR/bin" ]] && path=("$NEXTCLOUD_DIR/bin" $path[@])

export NEXTCLOUD_DIR

notes() {
  local notes_path="$NEXTCLOUD_DIR/Notes"
  if [ -d "$notes_path" ]; then
    cd "$notes_path"
    nvim
    cd - >/dev/null
  else
    echo "Notes directory not found: $notes_path"
  fi
}
