#!/bin/sh
# Block commits whose staged diff contains common credential/secret patterns.
# This is a best-effort net, not a substitute for not committing secrets.

pattern='-----BEGIN [A-Z ]*PRIVATE KEY-----'
pattern="$pattern|AKIA[0-9A-Z]{16}"
pattern="$pattern|xox[baprs]-[0-9A-Za-z-]{10,}"
pattern="$pattern|ghp_[0-9A-Za-z]{36}"
pattern="$pattern|(api|secret)_?key['\"]?[[:space:]]*[:=][[:space:]]*['\"][0-9A-Za-z_-]{16,}"

hits=$(git diff --cached -U0 | grep -E -e "$pattern")

[ -z "$hits" ] && exit 0

echo "pre-commit: possible secret detected in staged changes:" >&2
echo "$hits" | sed 's/^/  /' >&2
echo "If this is a false positive, commit with --no-verify to bypass." >&2
exit 1
