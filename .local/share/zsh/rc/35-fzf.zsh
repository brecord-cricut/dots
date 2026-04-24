(( ${+commands[fzf]} )) && source <(fzf --zsh)

# fzf-tab must load after compinit and fzf
[[ -f "$ZSH_STATE/plugins/fzf-tab/fzf-tab.plugin.zsh" ]] && source "$ZSH_STATE/plugins/fzf-tab/fzf-tab.plugin.zsh"
