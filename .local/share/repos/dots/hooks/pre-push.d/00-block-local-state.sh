#!/bin/sh
# Block pushes that contain commits with files under .local/state/.

while IFS=' ' read -r local_ref local_sha remote_ref remote_sha; do
  if [ "$remote_sha" = "0000000000000000000000000000000000000000" ]; then
    range="$local_sha"
  else
    range="$remote_sha..$local_sha"
  fi

  bad_files=$(git diff-tree -r --name-only "$range" 2>/dev/null | grep '^\.local/state/')

  if [ -n "$bad_files" ]; then
    echo "pre-push: refusing to push — commits contain files under .local/state/:" >&2
    echo "$bad_files" | while IFS= read -r f; do
      echo "  $f" >&2
    done
    echo "Remove these files from the affected commits before pushing." >&2
    exit 1
  fi
done
