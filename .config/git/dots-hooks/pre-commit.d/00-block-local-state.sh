#!/bin/sh
# Block and auto-unstage any files under .local/state/ from being committed.

bad_files=$(git diff --cached --name-only | grep '^\.local/state/')

[ -z "$bad_files" ] && exit 0

echo "pre-commit: blocked files under .local/state/ from being committed." >&2
echo "Unstaging:" >&2
echo "$bad_files" | while IFS= read -r f; do
  echo "  $f" >&2
  git restore --staged -- "$f"
done
echo "These files have been unstaged. Commit aborted." >&2
exit 1
