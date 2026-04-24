#!/bin/sh
# Generic hook dispatcher.
# Runs all *.sh scripts in <hook-name>.d/ in filename order.
# Stdin is buffered to a temp file so each script receives it intact.
# Any script exiting non-zero aborts immediately.

hook_name=$(basename "$0")
hook_dir="$(dirname "$0")/${hook_name}.d"

[ -d "$hook_dir" ] || exit 0

# Buffer stdin once so every script can read it
stdin_file=$(mktemp)
trap 'rm -f "$stdin_file"' EXIT
cat > "$stdin_file"

for script in "$hook_dir"/*.sh; do
  [ -f "$script" ] && [ -x "$script" ] || continue
  "$script" "$@" < "$stdin_file"
  status=$?
  if [ $status -ne 0 ]; then
    echo "hook: $hook_name aborted by $(basename "$script") (exit $status)" >&2
    exit $status
  fi
done
