[[ ! -t 0 ]] && return

if [ -f $XDG_CONFIG_HOME/git/env ]; then
  source $XDG_CONFIG_HOME/git/env
fi

if [[ -z "$GIT_AUTHOR_NAME" || -z "$GIT_AUTHOR_EMAIL" ]]; then
  echo "git user context is missing."
  if [[ -z "$GIT_AUTHOR_NAME" ]]; then
    echo -n "Enter your Git author name: "
    read git_name
  fi
  if [[ -z "$GIT_AUTHOR_EMAIL" ]]; then
    echo -n "Enter your Git author email: "
    read git_email
  fi
  if [[ -z "$git_name" || -z "$git_email" ]]; then
    echo "Error: Both Git author name and email are required."
    return 1
  fi
  mkdir -p $XDG_CONFIG_HOME/git
  {
    echo "#!/usr/bin/env zsh"
    echo "export GIT_AUTHOR_NAME=\"$git_name\""
    echo "export GIT_AUTHOR_EMAIL=\"$git_email\""
    echo "export GIT_COMMITTER_NAME=\"$git_name\""
    echo "export GIT_COMMITTER_EMAIL=\"$git_email\""
  } >$XDG_CONFIG_HOME/git/env
  source $XDG_CONFIG_HOME/git/env
  unset git_name git_email
fi
