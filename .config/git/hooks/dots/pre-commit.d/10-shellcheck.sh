#!/bin/sh
# Run shellcheck against staged shell scripts (.sh) and zsh files (.zsh, treated as sh
# via --shell=bash since shellcheck has no zsh dialect; this still catches quoting,
# word-splitting, and unset-variable classes of bugs).

command -v shellcheck >/dev/null 2>&1 || exit 0

files=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(sh|zsh)$')

[ -z "$files" ] && exit 0

files_file=$(mktemp)
trap 'rm -f "$files_file"' EXIT
echo "$files" >"$files_file"

failed=0
while IFS= read -r f; do
  [ -f "$f" ] || continue
  shellcheck --shell=bash --exclude=SC1090,SC1091 "$f" || failed=1
done <"$files_file"

[ "$failed" -eq 0 ] && exit 0

echo "pre-commit: shellcheck reported issues above. Fix them or commit with --no-verify to bypass." >&2
exit 1
