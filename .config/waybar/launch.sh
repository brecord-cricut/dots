#!/usr/bin/env bash

exec 200>/tmp/waybar-launch.lock
flock -n 200 || exit 0

killall waybar || true
pkill waybar || true
sleep 0.1

# -----------------------------------------------------
# Loading the configuration
# -----------------------------------------------------
config_file="config.jsonc"
style_file="style.css"

waybar -c ~/.config/waybar/$config_file -s ~/.config/waybar/$style_file &

# Explicitly release the lock (optional) -> flock releases on exit
flock -u 200
exec 200>&-
