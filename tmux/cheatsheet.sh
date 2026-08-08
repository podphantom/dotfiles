#!/usr/bin/env bash

# Tmux Interactive Categorized Cheatsheet

generate_items() {
    printf "\033[1;35m--- 🚀 SESSIONS & SWITCHING ---\033[0m\n"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b K" "⚡ Open Sesh interactive session switcher (with fzf preview)"
    printf "\033[1;36m%-16s\033[0m %s\n" "  ├─ ^a" "🛸 List all sessions & directories"
    printf "\033[1;36m%-16s\033[0m %s\n" "  ├─ ^t" "◧ List active Tmux sessions only"
    printf "\033[1;36m%-16s\033[0m %s\n" "  ├─ ^g" "⛯ List config directory shortcuts"
    printf "\033[1;36m%-16s\033[0m %s\n" "  ├─ ^x" "🗃 List Zoxide recent directories"
    printf "\033[1;36m%-16s\033[0m %s\n" "  ├─ ^f" "🔭 Find directories on machine (fd search)"
    printf "\033[1;36m%-16s\033[0m %s\n" "  └─ ^d" "👽 Kill selected Tmux session"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b f" "🔭 Open Tmux Sessionizer popup"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b n" "➕ Create a new named session"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b w" "🗂 Interactive session & window tree picker"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b d" "🚪 Detach client (keep sessions running in background)"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b C-d" "💀 Kill all sessions & exit Tmux completely (with prompt)"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b C-r" "🔄 Restore saved sessions manually (tmux-resurrect)"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b C-s" "💾 Save current session state manually (tmux-resurrect)"
    printf "\n"

    printf "\033[1;35m--- 🪟 WINDOWS & PANES ---\033[0m\n"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b c" "📑 Create a new Tmux window/tab"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b ," "✏️ Rename current window"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b 1..9" "🔢 Switch directly to window number N"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b &" "❌ Kill current window"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b |" "📁 Split window Vertically (in current pane directory)"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b -" "📁 Split window Horizontally (in current pane directory)"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b m" "🔍 Maximize / toggle zoom on current pane (also Ctrl+b z)"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b x" "❌ Kill current pane"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+h/j/k/l" "🧭 Seamless pane navigation (Left/Down/Up/Right & Neovim)"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b h/j/k/l" "📐 Resize current pane (Left/Down/Up/Right by 5 cells)"
    printf "\n"

    printf "\033[1;35m--- 📱 FLOATING POPUPS ---\033[0m\n"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b C-y" "📂 Open Yazi terminal file manager float"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b C-t" "🖥️ Open quick floating terminal popup"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b C-g" "🌿 Open LazyGit floating popup"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b C" "⚙️ Open quick Config edit menu (.zshrc, .tmux.conf, .nvim)"
    printf "\n"

    printf "\033[1;35m--- 📝 COPY & SELECTION MODE ---\033[0m\n"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b v" "📖 Enter Vi copy/scroll mode (also Ctrl+b [)"
    printf "\033[1;36m%-16s\033[0m %s\n" "v (in copy)" "✂️ Begin visual text selection"
    printf "\033[1;36m%-16s\033[0m %s\n" "y (in copy)" "📋 Copy selection to buffer/clipboard"
    printf "\n"

    printf "\033[1;35m--- 🛠️ UTILITIES & HELPERS ---\033[0m\n"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b ?" "❓ Open this interactive Tmux Cheatsheet"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b r" "🔄 Reload tmux.conf configuration file"
    printf "\033[1;36m%-16s\033[0m %s\n" "Ctrl+b C-l" "🧹 Clear screen / line (send C-l)"
}

generate_items | fzf --ansi \
    --height=100% \
    --reverse \
    --border=rounded \
    --border-label=" ⌨️ Tmux Keybindings Cheatsheet " \
    --prompt="🔍 Search: " \
    --header="Prefix Key: Ctrl+b | Press ESC or q to exit" \
    --color="border:#cba6f7,label:#f5e0dc,prompt:#89b4fa,pointer:#f5e0dc"
