[[ -f "$XDG_CACHE_HOME/user/p10k-disabled" ]] && return

if [[ ! -d "$REPOS/powerlevel10k" ]]; then
  printf "Download and install Powerlevel10k? [y/n]: "
  read answer
  case "$answer" in
  [Yy])
    if git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$REPOS/powerlevel10k"; then
      printf "Powerlevel10k installed successfully.\n"
    else
      printf "Failed to clone Powerlevel10k\n"
      unset answer
      return 1
    fi
    ;;
  *)
    mkdir -p "$XDG_CACHE_HOME/user"
    touch "$XDG_CACHE_HOME/user/p10k-disabled"
    printf "Powerlevel10k installation skipped.\n"
    printf "To re-enable Powerlevel10k delete %s\n" "$XDG_CACHE_HOME/user/p10k-disabled"
    unset answer
    return 0
    ;;
  esac
fi

if [[ -r "$REPOS/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$REPOS/powerlevel10k/powerlevel10k.zsh-theme"
fi
