#!/usr/bin/env bash

raw_input="$1"
# Strip ANSI escape codes if present
input=$(echo "$raw_input" | sed -r "s/\x1B\[[0-9;]*[mK]//g")

# Expand ~ to $HOME safely
eval_input=$(eval echo "$input" 2>/dev/null)

target=""

# 1. Direct tmux session check (handles names like "a", "0", "new session")
if tmux has-session -t "$input" 2>/dev/null; then
    target="$input"
# 2. Direct directory check (e.g., "~/.config/tmux")
elif [ -d "$eval_input" ]; then
    echo -e "\033[1;32m📁 Directory:\033[0m \033[1;37m$eval_input\033[0m"
    echo -e "\033[90m----------------------------------------\033[0m"
    ls -la --color=always "$eval_input" | head -n 35
    exit 0
else
    # Strip leading non-alphanumeric icon/symbol if present (e.g. "⚡ session" -> "session")
    stripped=$(echo "$input" | sed -E 's/^[^a-zA-Z0-9\/~._\-]+ //')
    eval_stripped=$(eval echo "$stripped" 2>/dev/null)

    if tmux has-session -t "$stripped" 2>/dev/null; then
        target="$stripped"
    elif [ -d "$eval_stripped" ]; then
        echo -e "\033[1;32m📁 Directory:\033[0m \033[1;37m$eval_stripped\033[0m"
        echo -e "\033[90m----------------------------------------\033[0m"
        ls -la --color=always "$eval_stripped" | head -n 35
        exit 0
    fi
fi

if [ -n "$target" ]; then
    session_path=$(tmux display-message -p -t "$target" '#{pane_current_path}' 2>/dev/null)
    pretty_path="${session_path/#$HOME/~}"

    echo -e "\033[1;34m⚡ Session:\033[0m \033[1;37m$target\033[0m"
    echo -e "\033[1;33m📂 Path:\033[0m \033[1;36m$pretty_path\033[0m"
    echo -e "\033[90m----------------------------------------\033[0m"
    tmux list-windows -t "$target" -F "  #I: #W #{?window_active,*(active),} [#{pane_current_command}]" 2>/dev/null
    echo -e "\033[90m----------------------------------------\033[0m"
    
    pane_content=$(tmux capture-pane -ep -t "$target" 2>/dev/null)
    if [ -n "$pane_content" ]; then
        echo "$pane_content" | awk 'NF {last=NR} {a[NR]=$0} END {for (i=1; i<=last; i++) print a[i]}'
    fi
else
    echo "$raw_input"
fi
