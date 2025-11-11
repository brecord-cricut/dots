local p10k_dir="$ZSH_CACHE/p10k"

if [[ -f "$p10k_dir/powerlevel10k.zsh-theme" ]]; then
  source "$p10k_dir/powerlevel10k.zsh-theme"
  return 0
fi

p10k_instantiate() {
  echo "Powerlevel10k is not installed."
  echo -n "Install it now? (y/N) "
  read -q "reply? " || return 0
  echo

  if command -v brew >/dev/null 2>&1; then
    echo "Installing via Homebrew..."
    brew install powerlevel10k
  elif command -v yay >/dev/null 2>&1; then
    echo "Installing via yay..."
    yay -S --noconfirm zsh-theme-powerlevel10k-git
  else
    echo "No supported package manager found (need brew or yay)"
    return 1
  fi

  # Standard locations where the above commands install it
  if [[ -d "$HOME/.powerlevel10k" ]]; then
    ln -sf "$HOME/.powerlevel10k" "$p10k_dir"
  elif [[ -d "/opt/homebrew/share/powerlevel10k" ]]; then
    ln -sf "/opt/homebrew/share/powerlevel10k" "$p10k_dir"
  elif [[ -d "/usr/share/zsh-theme-powerlevel10k" ]]; then
    ln -sf "/usr/share/zsh-theme-powerlevel10k" "$p10k_dir"
  fi

  [[ -f "$p10k_dir/powerlevel10k.zsh-theme" ]] && source "$p10k_dir/powerlevel10k.zsh-theme"
  echo "Powerlevel10k installed! Run p10k configure or reopen terminal."
}

# Only trigger the installer if the prompt is actually needed now
# (i.e. we're in an interactive shell and p10k isn't already loaded)
if [[ -o interactive ]] && [[ -z "$POWERLEVEL9K_CONFIG_FILE" ]]; then
  p10k_instantiate
  unset -f p10k_instantiate
fi
