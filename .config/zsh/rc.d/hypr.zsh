hyprc() {
  cd "$XDG_CONFIG_HOME/hypr"
  case "$1" in
  "d") pwd ;;
  *)
    nvim
    cd - >/dev/null
    ;;
  esac
}

if command -v Hyprland >/dev/null; then
  if [ ! -f "$XDG_CONFIG_HOME/hypr/style.conf" ]; then
    wallpaper="$(find "$XDG_DATA_HOME/wallpapers" -maxdepth 1 -type f | head -n 1)"
    if [ ! -r "$wallpaper" ]; then
      echo ":: Failed to locate suitable wallpaper. This will cause Hyprland to error!"
      return 1
    fi
    sh "$XDG_CONFIG_HOME/hypr/scripts/wallpaper.sh $wallpaper"
  fi

  if [[ "$(tty)" == "/dev/tty1" ]]; then
    pgrep -x Hyprland >/dev/null || Hyprland &
  fi
fi
