export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"

[ -d "$XDG_CONFIG_HOME/npm" ] || mkdir -p "$XDG_CONFIG_HOME/npm"

command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd)"
