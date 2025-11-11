[[ -o interactive ]] || return 0

for f in {"$ZSH_DATA"/rc,"$ZSH_STATE"/rc,"$ZDOTDIR"/rc.d}/*.zsh(N); do
  . "$f"
done
unset -v f
