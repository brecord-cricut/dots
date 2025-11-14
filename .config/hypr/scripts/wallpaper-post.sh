#!/usr/bin/env bash

##
## This script should only be called by `wal` (not manually)
##

# Refresh env values
[[ -r "$XDG_CACHE_HOME/wal/colors.sh" ]] && source "$XDG_CACHE_HOME/wal/colors.sh"

# Create lock screen artifacts
lockscreen_file="$XDG_CACHE_HOME/wal/lock.jpg"
magick $(cat "$XDG_CACHE_HOME/wal/wal") \
  -blur 0x15 \
  $lockscreen_file ||
  exit 1

# Update tofi colors
tofi_config="$XDG_CONFIG_HOME/tofi/config"
tofi_config_tmp="$XDG_RUNTIME_DIR/config"
sed -E "
  s|background-color = #[0-9a-fA-F]{6}|background-color = $background|
  s|text-color = #[0-9a-fA-F]{6}|text-color = $foreground|
  s|selection-color = #[0-9a-fA-F]{6}|selection-color = $cursor|
  " "$tofi_config" >"$tofi_config_tmp" || exit 1
mv "$tofi_config_tmp" "$tofi_config"

# Update Hyprland colors
hypr_style="$XDG_CONFIG_HOME/hypr/style.conf"
hypr_style_tmp="$XDG_RUNTIME_DIR/style.conf"
wal_colors_src="$XDG_CACHE_HOME/wal/colors.scss"
sed 's|: | = |
  s| = \#| = rgb(|
  s|\;|)|
  s|//|\#|
  s|wallpaper = "\(.*\)".*|wallpaper = \1|' $wal_colors_src |
  tail -n +2 >"$hypr_style_tmp" || exit 1

# Set lock wallpaper path as a Hyprland variable
echo "" >>"$hypr_style_tmp"
echo "# Lockscreen wallpaper" >>"$hypr_style_tmp"
echo "\$lock_wallpaper = $lockscreen_file" >>"$hypr_style_tmp"
mv "$hypr_style_tmp" "$hypr_style"
