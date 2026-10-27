# Plugin configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=1'

local plugin_home="$ZSH_STATE/plugins"

local -a plugins=(
  https://github.com/hlissner/zsh-autopair
  https://github.com/zsh-users/zsh-autosuggestions
  https://github.com/zsh-users/zsh-completions
  https://github.com/zsh-users/zsh-history-substring-search
  https://github.com/z-shell/F-Sy-H
  https://github.com/Aloxaf/fzf-tab
)

# Plugins that must be sourced after compinit; see 35-fzf.zsh
local -a deferred_plugins=(
  fzf-tab
)

local repo= name= dir=
for repo in "${plugins[@]}"; do
  name=${repo##*/}
  dir="$plugin_home/$name"

  if [[ ! -d "$dir" ]]; then
    echo "Installing $name..."
    git clone --depth 1 "$repo" "$dir" >/dev/null 2>&1
  fi

  (( ${deferred_plugins[(Ie)$name]} )) && continue
  [[ -f "$dir/$name.zsh" ]] && source "$dir/$name.zsh"
  [[ -f "$dir/$name.plugin.zsh" ]] && source "$dir/$name.plugin.zsh"
done

unset -v plugin_home plugins deferred_plugins repo name dir
