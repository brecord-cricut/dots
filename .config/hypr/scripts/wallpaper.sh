#!/usr/bin/env bash

set_wallpaper() {
  if [ ! -f "$1" ]; then
    echo ":: File not found: $1"
    return 1
  fi

  echo ":: Updating wallpaper: $1"

  # Update cache
  wal -o "$XDG_CONFIG_HOME/hypr/scripts/wallpaper-post.sh" -i "$1" || exit 1
}

# If present, the first argument will be used to set the wallpaper to the provided path.
if [ -n "$1" ]; then
  set_wallpaper $@
fi

# Refresh env values
[[ -r "$XDG_CACHE_HOME/wal/colors.sh" ]] && source "$XDG_CACHE_HOME/wal/colors.sh"

if [ -z "$wallpaper" ]; then
  echo ":: Wallpaper cache missing. To resolve, execute: $0 /path/to/wallpaper.png"
  exit 1
fi

if [ ! -r "$wallpaper" ]; then
  echo ":: Wallpaper not found: $wallpaper"
  exit 1
fi

# Start wallpaper daemon, if not running
pidof swww-daemon &>/dev/null || swww-daemon &

# Apply wallpaper
swww img "$wallpaper" \
  --transition-fps 120 \
  --transition-type fade \
  --transition-duration 1.6

echo ":: Completed wallpaper update"

unset -f set_wallpaper
