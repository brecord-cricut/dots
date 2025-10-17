#!/usr/bin/env zsh
[[ ! -t 0 ]] && return

export NEXTCLOUD_DIR=$XDG_DATA_HOME/Nextcloud

notes() {
  local notes_path="$NEXTCLOUD_DIR/Notes"
  if [[ ! -d $notes_path ]]; then
    echo "Notes directory not found: $notes_path"
    return
  fi
  if [[ "$1" == "d" ]]; then
    cd $notes_path && pwd
  else
    cd $notes_path
    nvim
    cd - >/dev/null
  fi
}
