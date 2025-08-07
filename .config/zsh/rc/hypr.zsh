#!/usr/bin/zsh

[[ -d "$XDG_CONFIG_HOME/hypr" ]] || return

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
  if [[ "$(tty)" == "/dev/tty1" ]]; then
    pgrep -x Hyprland >/dev/null || Hyprland &
  fi
fi
