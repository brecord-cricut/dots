[[ -o interactive ]] || return 0

command mkdir -pm 700 -- "$ZSH_CACHE_DIR"

HISTFILE="$ZSH_CACHE_DIR/history"
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_FIND_NO_DUPS

autoload -Uz compinit
for dump in "$ZSH_CACHE_DIR/zcompdump"(N.mh+24); do
  compinit
done
compinit -C
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

bindkey -v
export KEYTIMEOUT=1

alias ll="ls --color=auto -lah"
alias ls="ls --color=auto"

(( ${+commands[nproc]} )) && alias make='make -j$(nproc)'

for f in "$ZDOTDIR"/rc.d/*.zsh(N); do
  . "$f"
done
unset -v f
