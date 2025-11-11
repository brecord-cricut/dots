# Directory listing
if (( ${+commands[eza]} )); then
  alias ls='eza --color=auto --group-directories-first'
  alias ll='eza --long --all --header --git --group-directories-first --time-style=long-iso'
  alias la='eza --all --group-directories-first'
  alias l='eza --oneline --all --group-directories-first'
  alias tree='eza --tree --level=4 --group-directories-first'
  alias lsg='eza --git-ignore'

elif (( ${+commands[exa]} )); then
  # old exa (still better than ls)
  alias ls='exa --color=auto --group-directories-first'
  alias ll='exa --long --all --header --git --group-directories-first'
  alias la='exa --all --group-directories-first'
  alias tree='exa --tree --level=3'

elif (( ${+commands[gls]} )); then
  # GNU coreutils ls
  alias ls='gls --color=auto --group-directories-first -p'
  alias ll='gls --color=auto -lAh --group-directories-first -p'
  alias la='gls --color=auto -A --group-directories-first'

else
  # Last resort
  alias ls='ls -G'          # -G = color on macOS
  alias ll='ls -lAhG'
  alias la='ls -AG'
fi

# macOS still ships BSD tools without --color, so force it when possible
if [[ $OSTYPE == darwin* ]]; then
  (( ${+commands[glsd]} )) || alias ls='ls -G'
fi

# Safer core utilities
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias ln='ln -v'

# Modern replacements
(( ${+commands[bat]} ))    && alias cat='bat --style=plain'
(( ${+commands[batcat]} )) && alias cat='batcat --style=plain'  # Ubuntu name
(( ${+commands[delta]} ))  && alias diff='delta'
(( ${+commands[dust]} ))   && alias du='dust'
(( ${+commands[fd]} ))     && alias find='fd'
(( ${+commands[rg]} ))     && alias grep='rg'
(( ${+commands[htop]} ))   && alias top='htop'
(( ${+commands[btop]} ))   && alias top='btop'
(( ${+commands[procs]} ))  && alias ps='procs'
(( ${+commands[ncdu]} ))   && alias ncdu='ncdu --color dark'

# macOS still ships BSD tools without --color, so force it when possible
if [[ $OSTYPE == darwin* ]]; then
  (( ${+commands[glsd]} )) || alias ls='ls -G'
fi

if (( ${+commands[nproc]} )); then
  alias make='make -j$(( $(nproc) + 1 ))'
elif (( ${+commands[ncpus]} )); then   # macOS
  alias make='make -j$(( $(ncpus) + 1 ))'
fi

# Quick navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'
