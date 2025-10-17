[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"

HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=1000

zstyle :compinstall filename "$ZDOTDIR/.zshrc"

autoload -Uz compinit
compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump"

function add_plugin() {
  local plugin_home="$XDG_DATA_HOME/zsh"
  local plugin_name=$(basename -s ".git" "$1")
  local plugin_path="$plugin_home/${plugin_name}"
  local src_file="$plugin_path/$plugin_name.plugin.zsh"
  [[ -d "$plugin_home" ]] || mkdir -p "$plugin_home"
  if [ ! -d "$plugin_path" ]; then
    echo "Installing ZSH plugin: $plugin_name"
    git clone "$1" "$plugin_path" || echo "Failed to clone $plugin_name"
  fi
  [[ -r "$src_file" ]] && source "$src_file" || echo "FILE NOT FOUND: $src_file"
}

add_plugin https://github.com/Aloxaf/fzf-tab
add_plugin https://github.com/hlissner/zsh-autopair
add_plugin https://github.com/zdharma-continuum/fast-syntax-highlighting.git
add_plugin https://github.com/zsh-users/zsh-autosuggestions.git
add_plugin https://github.com/zsh-users/zsh-completions
add_plugin https://github.com/zsh-users/zsh-history-substring-search

bindkey -v
export KEYTIMEOUT=1
bindkey '^R' history-incremental-search-backward

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd e edit-command-line

zshc() {
  cd "$ZDOTDIR"
  nvim -c "lua require('persistence').load()"
  # The file $ZSH_STALE_PATH is created via an autocmd in Nevoim when exiting after altering a file in $ZDOTDIR
  if [[ -f "$ZSH_STALE_PATH" ]]; then
    echo ":: Sourcing zsh config..."
    rm "$ZSH_STALE_PATH"
    [[ -r "$HOME/.zshenv" ]] && source "$HOME/.zshenv"
    [[ -r "$ZDOTDIR/.zshenv" ]] && source "$ZDOTDIR/.zshenv"
    [[ -r "$HOME/.zprofile" ]] && source "$HOME/.zprofile"
    [[ -r "$ZDOTDIR/.zprofile" ]] && source "$ZDOTDIR/.zprofile"
    [[ -r "$HOME/.zshrc" ]] && source "$HOME/.zshrc"
    [[ -r "$ZDOTDIR/.zshrc" ]] && source "$ZDOTDIR/.zshrc"
  fi
  cd - >/dev/null
}
