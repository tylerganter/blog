#!/usr/bin/env bash
# Claude Code status line script
# Displays: model name | context usage bar | git branch

input=$(cat)

# --- Model ---
model=$(echo "$input" | jq -r '.model.display_name // "Unknown Model"')

# --- Context window ---
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

if [ -n "$used_pct" ]; then
    # Build a 10-char progress bar
    filled=$(echo "$used_pct" | awk '{printf "%d", ($1 / 10 + 0.5)}')
    bar=""
    for i in $(seq 1 10); do
        if [ "$i" -le "$filled" ]; then
            bar="${bar}█"
        else
            bar="${bar}░"
        fi
    done
    used_int=$(echo "$used_pct" | awk '{printf "%d", $1}')
    ctx_str="[${bar}] ${used_int}%"
else
    ctx_str="[░░░░░░░░░░] --"
fi

# --- Git branch (from cwd) ---
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
git_branch=""
if [ -n "$cwd" ]; then
    git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
        || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# --- Cruise mode ---
cruise=""
if [ "${CLAUDE_CRUISE:-}" = "1" ]; then
    cruise="🚗💨 "
fi

# --- Assemble status line ---
# Use printf with ANSI colors (dim-friendly)
# Order: cruise indicator  model  context_bar  git branch
parts=$(printf '%s\033[0;36m%s\033[0m  \033[0;33m%s\033[0m' "$cruise" "$model" "$ctx_str")

if [ -n "$git_branch" ]; then
    printf '%s  \033[0;32m\ue0a0 %s\033[0m' "$parts" "$git_branch"
else
    printf '%s' "$parts"
fi
