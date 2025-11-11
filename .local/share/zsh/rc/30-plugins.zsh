local plugin_home="$ZSH_STATE/plugins"
local plugin_lock="$ZSH_CACHE/.plugins-installed"

local -a plugins=(
  https://github.com/hlissner/zsh-autopair
  https://github.com/zsh-users/zsh-autosuggestions
  https://github.com/zsh-users/zsh-completions
  https://github.com/zsh-users/zsh-history-substring-search
  https://github.com/z-shell/F-Sy-H
  https://github.com/Aloxaf/fzf-tab
)

local repo

if [[ ! -f "$plugin_lock" ]]; then
  _clone() {
    local repo=$1
    local name=${repo##*/}
    [[ -d "$plugin_home/$name" ]] && return
    echo "Installing $name..."
    git clone --depth 1 "$repo" "$plugin_home/$name" >/dev/null 2>&1
  }

  for repo in "${plugins[@]}"; do
    _clone "$repo"
  done

  touch "$plugin_lock"
fi

for repo in "${plugins[@]}"; do
  local name=${repo##*/}
  local dir="$plugin_home/$name"
  [[ -f "$dir/${name:t}.zsh" ]] && source "$dir/${name:t}.zsh"
  [[ -f "$dir/${name:t}.plugin.zsh" ]] && source "$dir/${name:t}.plugin.zsh"
done

unset -v dir plugin_home plugin_lock plugins repo
