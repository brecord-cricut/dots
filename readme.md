# Ben's dotfiles

## Installation

Clone the repo and set it up to manage dotfiles:

```sh
git clone --bare git@github.com:Benjman/dots.git $XDG_DATA_HOME/repos/dots
alias dotfiles="git --git-dir=$XDG_DATA_HOME/repos/dots --work-tree=$HOME"
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
