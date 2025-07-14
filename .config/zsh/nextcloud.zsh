notes() {
  local notes_path="$NEXTCLOUD_DIR/Notes"
  if [[ -d $notes_path ]]; then
    cd $notes_path
    $EDITOR -c "lua require('persistence').load()" .
    cd - >/dev/null
  else
    echo "Notes directory not found: $notes_path"
  fi
}
