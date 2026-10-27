# Directory listing
if ((${+commands[eza]})); then
  alias ls='eza --color=auto --group-directories-first'
  alias ll='eza --long --all --header --git --group-directories-first --time-style=long-iso'
  alias la='eza --all --group-directories-first'
  alias l='eza --oneline --all --group-directories-first'
  alias tree='eza --tree --level=4 --group-directories-first'
  alias lsg='eza --git-ignore'

elif ((${+commands[exa]})); then
  # old exa (still better than ls)
  alias ls='exa --color=auto --group-directories-first'
  alias ll='exa --long --all --header --git --group-directories-first'
  alias la='exa --all --group-directories-first'
  alias tree='exa --tree --level=3'

elif ((${+commands[gls]})); then
  # GNU coreutils ls
  alias ls='gls --color=auto --group-directories-first -p'
  alias ll='gls --color=auto -lAh --group-directories-first -p'
  alias la='gls --color=auto -A --group-directories-first'

else
  # Last resort
  alias ls='ls -G' # -G = color on macOS
  alias ll='ls -lAhG'
  alias la='ls -AG'
fi

# Safer core utilities
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias ln='ln -v'

# Modern replacements
((${+commands[bat]})) && alias cat='bat --style=plain'
((${+commands[batcat]})) && alias cat='batcat --style=plain' # Ubuntu name
((${+commands[delta]})) && alias diff='delta'
((${+commands[dust]})) && alias du='dust'
((${+commands[fd]})) && alias find='fd'
((${+commands[htop]})) && alias top='htop'
((${+commands[btop]})) && alias top='btop' # preferred over htop
((${+commands[moor]})) && alias less='moor'
((${+commands[ncdu]})) && alias ncdu='ncdu --color dark'
((${+commands[procs]})) && alias ps='procs'
((${+commands[rg]})) && alias grep='rg'

if [[ $OSTYPE == linux* ]] && ((${+commands[xdg-open]})); then
  alias open='xdg-open'
fi

# Quick navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# Tool-specific, guarded on the tool actually being installed
((${+commands[claude]})) && alias cl="claude"
((${+commands[lazydocker]})) && alias ld="lazydocker"
((${+commands[tmux]})) && alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
((${+commands[wget]})) && alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
