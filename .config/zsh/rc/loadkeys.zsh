if [[ -t 0 ]] && command -v loadkeys >/dev/null 2>&1; then
  keymap_file="$XDG_CONFIG_HOME/us.map"
  if [[ -r "$keymap_file" ]]; then
    sudo loadkeys "$keymap_file" 2>/dev/null
  fi
fi
