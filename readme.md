# Ben's dotfiles

## Installation

Clone the repo and set it up to manage dots:

```sh
git clone --bare git@github.com:Benjman/dots.git $XDG_DATA_HOME/repos/dots
alias dots="git --git-dir=$XDG_DATA_HOME/repos/dots --work-tree=$HOME"
dots checkout
dots config --local status.showUntrackedFiles no
source "$HOME/.zshenv"
source "$ZDOTDIR/.zprofile"
source "$ZDOTDIR/.zshrc"
```
