[[ -o interactive ]] || return 0

# Tracked fragments first, machine-local ones last so they can override.
for f in {"$ZDOTDIR"/rc.d,"$ZSH_STATE"/rc}/*.zsh(N); do
  . "$f"
done
unset -v f
