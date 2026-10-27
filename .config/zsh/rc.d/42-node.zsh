export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"

command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd)"
