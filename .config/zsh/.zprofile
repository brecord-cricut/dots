typeset -U path fpath
typeset -TU PATH path
typeset -TU FPATH fpath

path=(
  $HOME/.local/bin
  $XDG_DATA_HOME/{cargo,go,npm}/bin(N-/)
  $XDG_DATA_HOME/gem/ruby/*/bin(N-/)
  /opt/homebrew/bin(N-/)
  /usr/local/{,s}bin(N-/)
  $path[@]
)

for f in "$ZDOTDIR"/env.d/*.zsh(N); do
  . "$f"
done
unset -v f
