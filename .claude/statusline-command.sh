#!/usr/bin/env bash
# Claude Code statusline — Powerlevel10k lean style (macOS, nerdfont-v3)
# Colors mirror p10k config:
#   dir foreground:        256-color 31  (anchor: 39 bold, shortened: 103)
#   vcs clean:             256-color 76  (green)
#   vcs modified:          256-color 178 (yellow)
#   vcs untracked:         256-color 39  (blue)
#   vcs conflicted:        256-color 196 (red)
#   model name (dim):      256-color 244 (grey)

# ── ANSI helpers ────────────────────────────────────────────────────────────
c() { printf '\033[38;5;%sm' "$1"; }   # set 256-color foreground
bold() { printf '\033[1m'; }
reset() { printf '\033[0m'; }

# ── Read JSON from stdin ─────────────────────────────────────────────────────
input=$(cat)

cwd=$(printf '%s' "$input" | jq -r '.cwd // .workspace.current_dir // ""')
model=$(printf '%s' "$input" | jq -r '.model.display_name // ""')

# ── OS icon (Apple ) ────────────────────────────────────────────────────────
OS_ICON=$''   # nf-fa-apple  (nerdfont-v3)

# ── Directory: shorten to ~-relative, show last 2 path components ─────────
home="$HOME"
if [[ "$cwd" == "$home" ]]; then
  dir_display="~"
elif [[ "$cwd" == "$home/"* ]]; then
  rel="${cwd#"$home/"}"
  # Count path components
  IFS='/' read -ra parts <<< "$rel"
  total=${#parts[@]}
  if (( total <= 2 )); then
    dir_display="~/$rel"
  else
    # Show shortened prefix components + last component
    # Each intermediate component truncated to first letter (like p10k truncate_to_unique)
    short=""
    for (( i=0; i < total-1; i++ )); do
      if (( i == 0 )); then
        short="${parts[i]:0:1}"
      else
        short="$short/${parts[i]:0:1}"
      fi
    done
    dir_display="~/$short/${parts[total-1]}"
  fi
else
  IFS='/' read -ra parts <<< "${cwd#/}"
  total=${#parts[@]}
  if (( total <= 2 )); then
    dir_display="$cwd"
  else
    short=""
    for (( i=0; i < total-1; i++ )); do
      if (( i == 0 )); then
        short="${parts[i]:0:1}"
      else
        short="$short/${parts[i]:0:1}"
      fi
    done
    dir_display="/$short/${parts[total-1]}"
  fi
fi

# ── Git status ───────────────────────────────────────────────────────────────
BRANCH_ICON=$''   # nf-dev-git_branch  

git_part=""
if git_dir=$(git -C "$cwd" rev-parse --git-dir 2>/dev/null); then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
           || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)

  # Dirty check: staged, unstaged, untracked
  staged=$(git -C "$cwd" diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
  unstaged=$(git -C "$cwd" diff --name-only 2>/dev/null | wc -l | tr -d ' ')
  untracked=$(git -C "$cwd" ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

  if (( staged > 0 )); then
    vcs_color=178   # modified — yellow
    dirty=" +${staged}"
  elif (( unstaged > 0 )); then
    vcs_color=178   # modified — yellow
    dirty=" !${unstaged}"
  elif (( untracked > 0 )); then
    vcs_color=39    # untracked — blue
    dirty=" ?${untracked}"
  else
    vcs_color=76    # clean — green
    dirty=""
  fi

  git_part=" $(c $vcs_color)${BRANCH_ICON} ${branch}${dirty}"
fi

# ── Model name (right-aligned hint, grey) ────────────────────────────────────
model_part=""
if [[ -n "$model" ]]; then
  model_part=" $(c 244)${model}"
fi

# ── Assemble ─────────────────────────────────────────────────────────────────
printf '%s' \
  "$(c 250)${OS_ICON}" \
  " $(bold)$(c 39)${dir_display}$(reset)" \
  "${git_part}" \
  "${model_part}" \
  "$(reset)"
printf '\n'
