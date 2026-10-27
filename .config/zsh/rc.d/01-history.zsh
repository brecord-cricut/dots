HISTFILE="$ZSH_CACHE/history"
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY        # save timestamp + duration per entry
setopt HIST_EXPIRE_DUPS_FIRST  # when trimming, remove duplicates first
setopt HIST_FIND_NO_DUPS       # when searching history (↑ / Ctrl-R), skip duplicates
setopt HIST_IGNORE_ALL_DUPS    # never store duplicates at all
setopt HIST_IGNORE_SPACE       # don’t store commands starting with space
setopt HIST_REDUCE_BLANKS      # remove superfluous blanks before saving
setopt HIST_SAVE_NO_DUPS       # don’t write duplicates when saving
setopt HIST_VERIFY             # when using !! or !123, show the command before executing
setopt INC_APPEND_HISTORY_TIME # write immediately + after each command (best of both worlds)
setopt SHARE_HISTORY           # share history across all live zsh sessions

# Noisy commands not worth recalling. HISTORY_IGNORE is zsh's built-in for
# exactly this: the pattern is matched against the whole command line, so it
# replaces the hand-rolled zshaddhistory hook this file used to carry.
HISTORY_IGNORE='(bg|fg|jobs|cd|..|...|....|.....|date|uptime|exit|clear|lazydocker|lazygit|lg|dflg|ls|ll|la|l|scratch|tmp|top|btop|htop|make|pwd|docker ps|git status|git diff|git diff --cached|git log --oneline|git log --graph --oneline)'
