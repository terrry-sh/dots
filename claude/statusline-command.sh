#!/bin/bash

# Read Claude Code input
input=$(cat)

# Extract information from input
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
model_name=$(echo "$input" | jq -r '.model.display_name')

# Color codes for statusline (Claude Code supports colors when using printf)
BLUE='\033[94m'
GREEN='\033[92m'
MAGENTA='\033[95m'
RESET='\033[0m'

# Function to truncate path similar to zsh %(5~|%-1~/…/%3~|%4~)
truncate_path() {
    local path="$1"
    local home_pattern="s|^$HOME|~|"
    path=$(echo "$path" | sed "$home_pattern")
    
    # Count path segments
    IFS='/' read -ra segments <<< "$path"
    local count=${#segments[@]}
    
    # If more than 5 segments, truncate to show first, ..., and last 3
    if [ $count -gt 5 ]; then
        local first="${segments[0]}"
        local last_three="${segments[-3]}/${segments[-2]}/${segments[-1]}"
        echo "${first}/…/${last_three}"
    else
        echo "$path"
    fi
}

# Get git branch if in a git repository
get_git_branch() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local branch=$(git branch --show-current 2>/dev/null)
        if [ -n "$branch" ]; then
            echo "in ($branch) "
        fi
    fi
}

# Truncate current directory
currdir=$(truncate_path "$current_dir")

# Get git info
cd "$current_dir" 2>/dev/null || true  # Change to the workspace directory for git commands
git_info=$(get_git_branch)

# Format the status line with colors using printf
if [ -n "$git_info" ]; then
    # Extract branch name from git_info (remove "in (" and ") ")
    branch_name=$(echo "$git_info" | sed 's/in (\(.*\)) /\1/')
    printf "${BLUE}%s${RESET} (${GREEN}%s${RESET}) ${MAGENTA}%s${RESET}" "$currdir" "$branch_name" "$model_name"
else
    printf "${BLUE}%s${RESET} ${MAGENTA}%s${RESET}" "$currdir" "$model_name"
fi