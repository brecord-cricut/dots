# Keep the Kitty tab title in sync with "<repo> [<branch>]" while inside
# $REPOS (falling back to the bare directory name elsewhere), instead of
# the default behavior of titling the tab after the last-run shell command.
# Recomputed on every directory change and before every prompt, so it
# tracks `cd` and `git checkout`/`switch` alike rather than going stale.
_kittyUpdateTabTitle() {
  [[ -n "$KITTY_WINDOW_ID" ]] && command -v kitty &>/dev/null || return

  local title
  if [[ "$PWD" == "$REPOS"/* ]]; then
    local project="${PWD#"$REPOS"/}"
    project="${project%%/*}"
    local branch
    branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null)"
    title="$project"
    [[ -n "$branch" ]] && title+="  [$branch]"
  else
    title="${PWD:t}"
  fi

  [[ "$title" == "$_kittyLastTabTitle" ]] && return
  _kittyLastTabTitle="$title"
  kitty @ set-tab-title "$title" &>/dev/null
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _kittyUpdateTabTitle
add-zsh-hook precmd _kittyUpdateTabTitle

repos() {
  local dir="$REPOS/$1"
  if [[ -d "$dir" ]]; then
    cd "$dir" || exit
    echo "→ $(pwd)"
    return
  fi

  # Match partial input: `repos f` would resolve to `cd $REPOS/foo`, if that directory exists.
  # shellcheck disable=SC2206 # zsh glob qualifier `(N/)`, not word splitting
  local matches=("$REPOS"/$1*(N/))
  if ((${#matches[@]} > 0)); then
    cd "${matches[1]}" || exit
    echo "→ $(pwd)"
  else
    echo "\"$dir\" is not a directory."
  fi
}

if command -v compdef &>/dev/null; then
  _reposCompletion() {
    _files -W "$REPOS" -/
  }
  compdef _reposCompletion repos
fi
