HISTFILE="$ZSH_CACHE/history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_EXPIRE_DUPS_FIRST  # when trimming, remove duplicates first
setopt HIST_FIND_NO_DUPS       # when searching history (↑ / Ctrl-R), skip duplicates
setopt HIST_IGNORE_ALL_DUPS    # never store duplicates at all
setopt HIST_IGNORE_SPACE       # don’t store commands starting with space
setopt HIST_REDUCE_BLANKS      # remove superfluous blanks before saving
setopt HIST_SAVE_NO_DUPS       # don’t write duplicates when saving
setopt HIST_VERIFY             # when using !! or !123, show the command before executing
setopt INC_APPEND_HISTORY_TIME # write immediately + after each command (best of both worlds)
setopt SHARE_HISTORY           # share history across all live zsh sessions

typeset -gU HISTORY_IGNORE_COMMANDS   # -g = global, -U = unique (no dups)
[[ $cmd == (ls|ll|la|l|cd|pwd|exit|date|clear|bg|fg) ]] && return 1
HISTORY_IGNORE_COMMANDS=(
  bg fg jobs
  cd .. .. ... .... .....
  date uptime
  exit clear
  lazydocker lazygit
  ls ll la l la lg
  scratch tmp
  top btop htop
  make
  pwd
)

typeset -gU HISTORY_IGNORE_PATTERNS
HISTORY_IGNORE_PATTERNS=(
  'docker ps'
  'git diff --cached'
  'git diff'
  'git log --graph --oneline'
  'git log --oneline'
  'git status'
)

# ignore some noisy commands globally
zshaddhistory() {
  emulate -L zsh
  setopt extendedglob

  local line="${1%%$'\n'}"
  local cmd="${line%%[[:space:]]#}"

  (( ${HISTORY_IGNORE_PATTERNS[(Ie)${line}]} )) && return 1
  (( ${HISTORY_IGNORE_COMMANDS[(Ie)$cmd]} )) && return 1

  # Ignore empty lines or lines with only whitespace
  [[ -z "${line// }" ]] && return 1

  # Return 0 = save this line
  return 0
}
