#!/bin/sh
# Block and auto-unstage any private files (.local/state/, private hook dirs) from being committed.

# Private paths: .local/state/, plus per-repo hook dirs listed as private in
# the dots repo's info/exclude (--no-index so force-added files still match)
private_paths() {
  paths=$(cat)
  printf '%s\n' "$paths" | grep '^\.local/state/'
  printf '%s\n' "$paths" | grep '^\.config/git/hooks/' | git check-ignore --no-index --stdin
}

bad_files=$(git diff --cached --name-only | private_paths)

[ -z "$bad_files" ] && exit 0

echo "pre-commit: blocked private files (.local/state/, private hook dirs) from being committed." >&2
echo "Unstaging:" >&2
echo "$bad_files" | while IFS= read -r f; do
  echo "  $f" >&2
  git restore --staged -- "$f"
done
echo "These files have been unstaged. Commit aborted." >&2
exit 1
