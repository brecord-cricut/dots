if [[ -z "$GIT_AUTHOR_NAME" || -z "$GIT_AUTHOR_EMAIL" ]]; then
  printf "git user context is missing.\n"
  printf "Enter your Git author name: "
  read git_name
  printf "Enter your Git author email: "
  read git_email
  if [[ -z "$git_name" || -z "$git_email" ]]; then
    printf "Error: Both Git author name and email are required.\n"
    return 1
  fi
  local env_path="$ZSH_STATE/env/git.zsh"
  [[ -d "$(dirname $env_path)" ]] || mkdir -p "$(dirname $env_path)"
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
