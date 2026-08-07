#!/usr/bin/env bash
# Strip leading icon/whitespace if present
item=$(echo "$1" | sed -E 's/^[^ ]+ //')
eval_item=$(eval echo "$item")

if tmux has-session -t "$item" 2>/dev/null; then
    session_path=$(tmux display-message -p -t "$item" '#{pane_current_path}' 2>/dev/null)
    # Format path with ~ for HOME
    pretty_path="${session_path/#$HOME/~}"

    echo -e "\033[1;34m⚡ Session:\033[0m \033[1;37m$item\033[0m"
    echo -e "\033[1;33m📂 Path:\033[0m \033[1;36m$pretty_path\033[0m"
    echo -e "\033[90m----------------------------------------\033[0m"
    tmux list-windows -t "$item" -F "  #I: #W #{?window_active,*(active),} [#{pane_current_command}]"
    echo -e "\033[90m----------------------------------------\033[0m"
    
    # Capture pane and strip trailing empty lines so terminal prompt is always visible
    tmux capture-pane -ep -t "$item" | awk 'NF {last=NR} {a[NR]=$0} END {for (i=1; i<=last; i++) print a[i]}'
elif [ -d "$eval_item" ]; then
    echo -e "\033[1;32m📁 Directory:\033[0m \033[1;37m$eval_item\033[0m"
    echo -e "\033[90m----------------------------------------\033[0m"
    ls -la --color=always "$eval_item" | head -n 35
else
    echo "$1"
fi
