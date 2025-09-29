[[ $OSNAME != darwin* ]] && return

alias ls="ls -G"

_symlink_config_dir() {
  local name="$1"
  if [[ -z "$name" ]]; then
    echo "Usage: _symlink_config_dir <config_dir_name>" >&2
    return 1
  fi
  local src="$XDG_CONFIG_HOME/$name"
  local dest="$HOME/Library/Application Support/$name"
  if [[ ! -L "$dest" && -d "$src" ]]; then
    if [[ -e "$dest.bak" ]]; then
      echo "Backup $dest.bak already exists. Aborting." >&2
      return 1
    fi
    if [[ -e "$dest" ]]; then
      echo "Backing up existing directory at: $dest → $dest.bak"
      mv "$dest" "$dest.bak" || {
        echo "Failed to backup $dest" >&2
        return 1
      }
    fi
    echo "Creating symlink: $src → $dest"
    ln -s "$src" "$dest" || {
      echo "Failed to create symlink" >&2
      return 1
    }
  fi
}
_symlink_config_dir lazygit
_symlink_config_dir qutebrowser
unset -f _symlink_config_dir

launchctl setenv BROWSER $BROWSER
launchctl setenv EDITOR $EDITOR
launchctl setenv PAGER $PAGER
launchctl setenv TERMINAL $TERMINAL
