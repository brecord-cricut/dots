((${+commands[claude]})) && alias cl="claude"
((${+commands[lazydocker]})) && alias ld="lazydocker"
((${+commands[tmux]})) && alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
((${+commands[wget]})) && alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
