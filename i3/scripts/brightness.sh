#!/usr/bin/env bash
# i3wm Brightness control script (hardware brightnessctl with xrandr fallback)

# Try brightnessctl first
if command -v brightnessctl >/dev/null 2>&1; then
    case "$1" in
        up)
            if brightnessctl set +10% >/dev/null 2>&1; then
                exit 0
            fi
            ;;
        down)
            if brightnessctl set 10%- >/dev/null 2>&1; then
                exit 0
            fi
            ;;
    esac
fi

# Fallback: xrandr software brightness
MONITOR=$(xrandr --current | grep " connected primary" | awk '{print $1}')
if [ -z "$MONITOR" ]; then
    MONITOR=$(xrandr --current | grep " connected" | head -n1 | awk '{print $1}')
fi

CACHE_FILE="$HOME/.cache/xrandr_brightness"
if [ ! -f "$CACHE_FILE" ]; then
    echo "1.0" > "$CACHE_FILE"
fi

CURRENT=$(cat "$CACHE_FILE" 2>/dev/null || echo "1.0")

case "$1" in
    up)
        NEW=$(python3 -c "print(min(1.0, round($CURRENT + 0.1, 2)))")
        ;;
    down)
        NEW=$(python3 -c "print(max(0.2, round($CURRENT - 0.1, 2)))")
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

echo "$NEW" > "$CACHE_FILE"
xrandr --output "$MONITOR" --brightness "$NEW"
