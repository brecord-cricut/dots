local submodule_dir="$ZSH_DATA/plugins/powerlevel10k"

if [[ ! -f "$submodule_dir/powerlevel10k.zsh-theme" ]]; then
  print -u2 "warning: powerlevel10k not found at $submodule_dir — run: dots submodule update --init"
  return 1
fi

POWERLEVEL9K_CONFIG_FILE="$ZSH_STATE/p10k"
[[ -n "$XDG_SESSION_TYPE" ]] && POWERLEVEL9K_CONFIG_FILE+="-$XDG_SESSION_TYPE"
[[ -r "$POWERLEVEL9K_CONFIG_FILE" ]] && source "$POWERLEVEL9K_CONFIG_FILE"

source "$submodule_dir/powerlevel10k.zsh-theme"
