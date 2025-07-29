for var in BROWSER EDITOR PAGER TERMINAL; do
  file="$XDG_CONFIG_HOME/user/${var:l}"
  value="${(P)var}"
  if [[ ! -f "$file" ]] || [[ "$(cat "$file" 2>/dev/null)" != "$value" ]]; then
    echo "$value" > "$file"
  fi
done
uset file value
