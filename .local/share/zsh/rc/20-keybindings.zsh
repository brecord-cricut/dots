bindkey -v
export KEYTIMEOUT=1

# Better history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search
bindkey -M viins '^P' up-line-or-beginning-search
bindkey -M viins '^N' down-line-or-beginning-search

# Edit command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line  # v in normal mode
bindkey -M viins '^V' edit-command-line # Ctrl-V in insert mode (rarely needed)

# Useful movement that should have been default
bindkey -M viins '^A' beginning-of-line  # Ctrl-A
bindkey -M viins '^E' end-of-line        # Ctrl-E
bindkey -M viins '^W' backward-kill-word # Ctrl-W
bindkey -M viins '^U' backward-kill-line # Ctrl-U
bindkey -M viins '^K' kill-line          # Ctrl-K

# Better backspace in insert mode
bindkey -M viins '^?' backward-delete-char # sometimes needed on macOS

# Bonus tiny widgets everyone copies
zle -N select-in-word
bindkey -M visual 'iw' select-in-word
bindkey -M visual 'aw' select-a-word

# Jump to beginning/end of line in normal mode (like vim’s 0 and $)
bindkey -M vicmd '^' beginning-of-line
bindkey -M vicmd '$' end-of-line

# ── Instant escape from insert → normal with jk (optional but addictive) ─
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode
