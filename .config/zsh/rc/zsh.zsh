[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"

HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=1000

zstyle :compinstall filename "$ZDOTDIR/.zshrc"

autoload -Uz compinit
compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump"

function add_plugin() {
  [[ -d "$ZDOTDIR/plugins" ]] || mkdir -p "$ZDOTDIR/plugins"
  local plugin_name=$(basename -s ".git" "$1")
  local plugin_path="$ZDOTDIR/plugins/${plugin_name}"
  if [ ! -d "$plugin_path" ]; then
    echo "Installing ZSH plugin: $plugin_name"
    git clone "$1" "$plugin_path" || echo "Failed to clone $plugin_name"
  fi
  source "$plugin_path/$plugin_name.plugin.zsh"
}

add_plugin https://github.com/Aloxaf/fzf-tab
add_plugin https://github.com/hlissner/zsh-autopair
add_plugin https://github.com/zdharma-continuum/fast-syntax-highlighting.git
add_plugin https://github.com/zsh-users/zsh-autosuggestions.git
add_plugin https://github.com/zsh-users/zsh-completions
add_plugin https://github.com/zsh-users/zsh-history-substring-search
