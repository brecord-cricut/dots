# Ben's dotfiles

## Installation

Clone the repo and set it up to manage dots:

```sh
git clone --bare git@github.com:Benjman/dots.git $XDG_DATA_HOME/repos/dots/.git
alias dots="git --git-dir=$XDG_DATA_HOME/repos/dots/.git --work-tree=$HOME"
dots config --local status.showUntrackedFiles false
dots checkout
dots checkout  # see "Git hooks" below
exec zsh
```

## Git hooks

`dots` is configured (via `.config/git/dots-hooks/`, wired up through `.config/git/dots.config`'s `core.hooksPath`) to run drop-in scripts on `pre-commit`, `post-checkout`, `post-merge`, and `pre-push`. See `.config/git/dots-hooks/*.d/` for the current set, notably `post-checkout.d/10-bootstrap.sh`, which creates required XDG directories and initializes submodules if any are uninitialized.

`core.hooksPath` only becomes active once `~/.config/git/config`'s `includeIf` for this repo's gitdir is on disk and matches — which isn't true yet during the very first `dots checkout` above (that command is what writes the file in the first place). That's why the sequence above ends with a second, otherwise-no-op `dots checkout`: by that point `hooksPath` is live, so this second checkout actually triggers `post-checkout.d/10-bootstrap.sh` and exercises the bootstrap for real (creating XDG dirs, initializing submodules). On every checkout after that (branch switches, future machines), it just runs automatically.

Note the clone path must end in `/.git` — it's matched literally (no normalization) against `dots.config`'s `includeIf "gitdir:...dots/.git"` and against `DOTS_PREFIX` in `.config/zsh/rc.d/aliases.zsh`. A bare clone without that suffix silently breaks both the hooks and every `dots`/`dflg`/`lazygit` helper.

Don't run `dots submodule update --init` directly using the `alias dots=... --work-tree=...` form above — `git submodule` refuses to run when both `--git-dir` and `--work-tree` are set explicitly (a known quirk of the bare-repo-as-dotfiles trick). That's exactly why the second `dots checkout` handles submodule init instead, via the hook (which uses `GIT_DIR` + `-C` rather than `--work-tree`). Once you're on the `dots()` zsh function (`.config/zsh/rc.d/aliases.zsh`, active after `exec zsh`), submodule commands still shouldn't be run through it directly for the same reason.
