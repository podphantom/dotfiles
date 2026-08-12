#!/usr/bin/env bash

# Rofi Power Menu Script for MinhChien Theme

lock="󰌾  Lock"
logout="󰍃  Logout"
reboot="󰜉  Reboot"
shutdown="󰐥  Shutdown"

options="$lock\n$logout\n$reboot\n$shutdown"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "󰐥 Power Menu:" -theme-str '
window {
    width: 320px;
    border-radius: 16px;
}
listview {
    lines: 4;
}
element {
    padding: 10px 16px;
}
')

case "$chosen" in
    "$lock")
        if command -v i3lock &> /dev/null; then
            i3lock -c 1e1e2e
        elif command -v betterlockscreen &> /dev/null; then
            betterlockscreen -l
        fi
        ;;
    "$logout")
        i3-msg exit
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
esac
