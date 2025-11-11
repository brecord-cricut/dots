autoload -Uz compinit

# Regenerate zcompdump only if it's older than 1 day OR missing
zcompdump="${ZSH_CACHE}/zcompdump"
if [[ ! -f "$zcompdump"(N) || $zcompdump -nt $zcompdump.zwc(#qN) || \
  ${#${(f)"$(find "$ZSH_CACHE" -name 'zcompdump*' -mtime +1 2>/dev/null || true)"}} -gt 0 ]]; then
    compinit -d "$zcompdump"
    # Compile the dump into .zwc for ~30–50 % faster loading next time
    zcompile "$zcompdump" 2>/dev/null
  else
    # Skip checking all the completion files (huge speedup on large $fpath)
    compinit -C -d "$zcompdump"
fi

# If the compiled version exists and is newer, load that instead
[[ -r "${zcompdump}.zwc" && ${zcompdump}.zwc -nt ${zcompdump} ]] && compinit -i -d "$zcompdump"

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
