#!/bin/sh
# Block pushes that contain commits with private files (.local/state/, private hook dirs).

# Private paths: .local/state/, plus per-repo hook dirs listed as private in
# the dots repo's info/exclude (--no-index so force-added files still match)
private_paths() {
  paths=$(cat)
  printf '%s\n' "$paths" | grep '^\.local/state/'
  printf '%s\n' "$paths" | grep '^\.config/git/hooks/' | git check-ignore --no-index --stdin
}

while IFS=' ' read -r _ local_sha _ remote_sha; do
  if [ "$remote_sha" = "0000000000000000000000000000000000000000" ]; then
    range="$local_sha"
  else
    range="$remote_sha..$local_sha"
  fi

  bad_files=$(git diff-tree -r --name-only "$range" 2>/dev/null | private_paths)

  if [ -n "$bad_files" ]; then
    echo "pre-push: refusing to push — commits contain private files (.local/state/, private hook dirs):" >&2
    echo "$bad_files" | while IFS= read -r f; do
      echo "  $f" >&2
    done
    echo "Remove these files from the affected commits before pushing." >&2
    exit 1
  fi
done
