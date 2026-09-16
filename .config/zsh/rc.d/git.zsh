if [[ -z "$GIT_AUTHOR_NAME" || -z "$GIT_AUTHOR_EMAIL" ]]; then
  git_name='' git_email=''
  printf "git user context is missing.\n"
  printf "Enter your Git author name: "
  read -r git_name
  printf "Enter your Git author email: "
  read -r git_email
  if [[ -z "$git_name" || -z "$git_email" ]]; then
    printf "Error: Both Git author name and email are required.\n"
    return 1
  fi
  env_path="$ZSH_STATE/env/git.zsh"
  cat <<-EOF >"$env_path"
			export GIT_AUTHOR_NAME="$git_name"
			export GIT_AUTHOR_EMAIL="$git_email"
			export GIT_COMMITTER_NAME="$git_name"
			export GIT_COMMITTER_EMAIL="$git_email"
	EOF
  chmod 600 "$env_path"
  source "$env_path"
  unset -v env_path git_name git_email
fi

wtadd() {
  local dir branch
  if [[ $# -eq 2 ]]; then
    local id="$1" subject="$2"
    dir="${id}-${subject}"
    branch="br/${id}"
  else
    local subject="$1"
    dir="${subject}"
    branch="${subject}"
  fi

  git -C .git worktree add "../$dir" -b "$branch" || return 1
  cd "$dir" || return 1

  # Repo-specific post-checkout setup can be defined privately, e.g. in
  # $ZSH_STATE/rc/git.zsh, as a `wtadd_post_hook_{repo}` function, where
  # {repo} is the parent directory's basename
  local repo
  repo="$(basename "$(realpath ..)")"
  local hook="wtadd_post_hook_${repo//[^a-zA-Z0-9_]/_}"
  if typeset -f "$hook" >/dev/null; then
    echo ":: Executing worktree add hook for $repo"
    "$hook"
  fi
}
