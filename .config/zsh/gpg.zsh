plugins+=gpg-agent

if [[ $(uname) == "Linux" ]] && ! command pacman -Qs gnome-keyring >/dev/null; then
  if [[ ! -f "$XDG_CACHE_HOME/user/gnome_keyring_toggle" ]]; then
    read "input?gnome-keyring is not installed. Would you like to install it? (y/n): "
    [[ "$input" == [Yy] ]] && yay -S --noconfirm gnome-keyring || touch "$XDG_CACHE_HOME/user/gnome_keyring_toggle"
  fi
fi
