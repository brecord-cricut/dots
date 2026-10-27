typeset -TU PATH path
typeset -TU FPATH fpath

path=($XDG_DATA_HOME/{cargo,go,npm}/bin(N-/) $path)
path=($XDG_DATA_HOME/gem/ruby/*/bin(N-/) $path)
path=(/usr/local/{,s}bin(N-/) $path)

# Tracked fragments first, machine-local ones last so they can override.
for f in {"$ZDOTDIR"/env.d,"$ZSH_STATE"/env}/*.zsh(N); do
  . "$f"
done
unset -v f
