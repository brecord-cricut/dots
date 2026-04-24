autoload -Uz compinit

# Regenerate zcompdump only if it's older than 24 hours or missing
zcompdump="${ZSH_CACHE}/zcompdump"
if [[ -n ${zcompdump}(#qN.mh+24) ]]; then
  compinit -d "$zcompdump"
  # Compile the dump into .zwc for faster loading next time
  zcompile "$zcompdump" 2>/dev/null
else
  # Skip compaudit — huge speedup on every shell start
  compinit -C -d "$zcompdump"
fi

zstyle ':completion:*' menu select                     # arrow-key driven menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # colored completion lists
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # case-insensitive + partial
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' squeeze-slashes true            # cd /u/lo/b<tab> → /usr/local/bin
zstyle ':completion:*' special-dirs true               # allow .. as completion
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:corrections' format '%F{magenta}-- %d (errors: %e) --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose true

# Show dots while completing (feels snappier)
zstyle ':completion:*' show-completer true
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Better process listing (kill, pgrep, etc.)
zstyle ':completion:*:processes' command 'ps -axww -o pid,user,cmd --forest'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# Cache expensive completions (e.g. brew, nix, apt)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE/completion"

# Don’t complete already-typed words twice
zstyle ':completion:*:(commands|builtins|aliases)' ignored-patterns '_*'
