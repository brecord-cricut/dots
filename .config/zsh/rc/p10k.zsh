[[ -f "$XDG_CACHE_HOME/$USER/p10k-disabled" ]] && return

if [ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

p10k_home="$XDG_DATA_HOME/p10k"

if [ ! -d "$p10k_home" ]; then
  printf "Download and install Powerlevel10k? [y/n]: "
  read answer
  case "$answer" in
  [Yy])
    if git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_home"; then
      printf "Powerlevel10k installed successfully.\n"
    else
      printf "Failed to clone Powerlevel10k\n"
      unset answer
      return 1
    fi
    ;;
  *)
    touch "$XDG_CACHE_HOME/$USER/p10k-disabled"
    printf "Powerlevel10k installation skipped.\n"
    printf "To re-enable Powerlevel10k delete %s\n" "$XDG_CACHE_HOME/$USER/p10k-disabled"
    unset answer
    return 0
    ;;
  esac
fi

if [[ -r "$p10k_home/powerlevel10k.zsh-theme" ]]; then
  source "$p10k_home/powerlevel10k.zsh-theme"
fi

if [[ -n $DISPLAY || -n $WAYLAND_DISPLAY || $OSTYPE == darwin* ]]; then
  [[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
else
  [[ ! -f $ZDOTDIR/.p10k.tty.zsh ]] || source $ZDOTDIR/.p10k.tty.zsh
fi

unset -v p10k_home
