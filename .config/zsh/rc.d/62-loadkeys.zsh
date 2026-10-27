command -v loadkeys >/dev/null 2>&1 || return 0

# loadkeys only affects the Linux console; skip in terminal emulators, tmux, ssh, etc.
case "$TTY" in
  /dev/tty[0-9]*) ;;
  *) return 0 ;;
esac

keymap_file="$XDG_CONFIG_HOME/us.map"
if [ -r "$keymap_file" ]; then
  sudo loadkeys "$keymap_file" 2>/dev/null
fi
