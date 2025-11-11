export GEM_HOME="$XDG_DATA_HOME/gem"
if command -v rbenv >/dev/null; then
  path=("$GEM_HOME/bin:" $path[@])
  eval "$(rbenv init -)"
fi
