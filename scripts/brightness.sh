#!/usr/bin/env bash
# brightness.sh — portable script for brightness control + notification via dunst

TAG="brightness"
STEP=5

if command -v brightnessctl >/dev/null 2>&1; then
    # Get current percentage
    CUR=$(brightnessctl g)
    MAX=$(brightnessctl m)
    PCT=$(( CUR * 100 / MAX ))
    case "$1" in
        up)
            if [ "$PCT" -lt 10 ]; then
                brightnessctl s +1%
            else
                brightnessctl s +${STEP}%
            fi
            ;;
        down)
            if [ "$PCT" -le 10 ]; then
                brightnessctl s 1%-
            else
                brightnessctl s ${STEP}%- 
            fi
            ;;
        *)
            echo "Usage: $0 up|down"
            exit 1
            ;;
    esac

    # Re-read after change
    CUR=$(brightnessctl g)
    MAX=$(brightnessctl m)
    PERCENT=$(( CUR * 100 / MAX ))
else
    # fallback to xbacklight
    case "$1" in
        up)
            xbacklight -inc $STEP ;;
        down)
            xbacklight -dec $STEP ;;
        *)
            echo "Usage: $0 up|down"
            exit 1 ;;
    esac
    PERCENT=$(xbacklight -get | cut -d '.' -f1)
fi

ICON="display-brightness"
TEXT="Brightness: ${PERCENT}%"

dunstify -i "$ICON" -r 2594 -u normal \
    -t 1000 \
    -h string:x-dunst-stack-tag:$TAG \
    -h int:value:$PERCENT \
    "$TEXT"
