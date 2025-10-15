[[ ! -r "$XDG_CACHE_HOME/user/wallpaper" ]] && echo "$XDG_DATA_HOME/wallpapers/wallhaven-xe65ko.png"

wallpaper="$(cat $XDG_CACHE_HOME/user/wallpaper)"

[[ ! -d "$XDG_CACHE_HOME/wal" ]] && [[ -x pywal ]] && pywal -i "$wallpaper"

swww img $(cat $XDG_CACHE_HOME/user/wallpaper) \
  --transition-fps 255 \
  --transition-type outer \
  --transition-duration 0.8

# TODO: Add flag to update wallpaper. This will need to update pywal, and supporting utils:
#   - `sed` dunst, tofi
#   - Update lock screen's background with a blurred version of the current background.
