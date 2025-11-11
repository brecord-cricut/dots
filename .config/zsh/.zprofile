typeset -U path fpath
typeset -TU PATH path
typeset -TU FPATH fpath

path=($XDG_DATA_HOME/{cargo,go,npm}/bin(N-/) $path)
path=($XDG_DATA_HOME/gem/ruby/*/bin(N-/) $path)
path=(/usr/local/{,s}bin(N-/) $path)

for f in {"$ZSH_DATA"/env,"$ZSH_STATE"/env,"$ZDOTDIR"/env.d}/*.zsh(N); do
  . "$f"
done
unset -v f

typeset -U path
