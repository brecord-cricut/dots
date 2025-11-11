export NEXTCLOUD_DIR="$XDG_DATA_HOME/Nextcloud"

[[ -d "$NEXTCLOUD_DIR/bin" ]] && path=("$NEXTCLOUD_DIR/bin" $path[@])

notes() {
  local notes_path="$NEXTCLOUD_DIR/Notes"
  if [ -d "$notes_path" ]; then
    cd "$notes_path"
    $EDITOR -c "lua require('persistence').load()" .
    cd - >/dev/null
  else
    echo "Notes directory not found: $notes_path"
  fi
}
