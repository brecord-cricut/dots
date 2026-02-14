# Zsh initialization script to run 'pass git pull' once per day in background
# This script should be sourced from ~/.zshrc

# Timestamp file to track last run
timestamp_file="$ZSH_CACHE/pass_pull_timestamp"

# Get current time in seconds since epoch
current_time=$(date +%s)

# Check if timestamp file exists and if less than 24 hours have passed
if [[ ! -f "$timestamp_file" ]] || [[ $((current_time - $(cat "$timestamp_file"))) -gt 86400 ]]; then
  # Run pass git pull in background, suppress normal output, log errors only
  pass git pull >/dev/null 2>>/tmp/ERROR_pass_pull.log &

  # Update timestamp file with current time
  echo "$current_time" >"$timestamp_file"
fi
