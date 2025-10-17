if command -v rbenv >/dev/null; then
  export GEM_HOME="$XDG_DATA_HOME/gem"
  export PATH="$GEM_HOME/bin:$PATH"
  eval "$(rbenv init -)"
fi
