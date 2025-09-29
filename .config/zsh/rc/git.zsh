[[ -r "$XDG_CONFIG_HOME/git/env" ]] && source "$XDG_CONFIG_HOME/git/env"

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
  mkdir -p "$XDG_CONFIG_HOME/git"
  cat <<-EOF >"$XDG_CONFIG_HOME/git/env"
			export GIT_AUTHOR_NAME="$git_name"
			export GIT_AUTHOR_EMAIL="$git_email"
			export GIT_COMMITTER_NAME="$git_name"
			export GIT_COMMITTER_EMAIL="$git_email"
	EOF
  chmod 600 "$XDG_CONFIG_HOME/git/env"
  source "$XDG_CONFIG_HOME/git/env"
  unset -v git_name git_email
fi
