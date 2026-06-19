#!/bin/sh
# Set Hammerspoon config path to XDG-compliant location.
# Skips if the default is already set to the correct value.

[ "$(uname)" = "Darwin" ] || exit 0

desired="$XDG_CONFIG_HOME/hammerspoon/init.lua"
current=$(defaults read org.hammerspoon.Hammerspoon MJConfigFile 2>/dev/null)

if [ "$current" = "$desired" ]; then
  exit 0
fi

defaults write org.hammerspoon.Hammerspoon MJConfigFile "$desired"
echo "hammerspoon: set MJConfigFile to $desired"
