command -v wal >/dev/null || return 0

default_wallpaper="$XDG_DATA_HOME/wallpapers/thunderstorm-sea.png"
[[ -d "$XDG_CACHE_HOME/wal" ]] || sh "$XDG_CONFIG_HOME/hypr/scripts/wallpaper.sh" "$default_wallpaper"
unset -v default_wallpaper
