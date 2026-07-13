#!/usr/bin/env bash
# mic_toggle.sh — Toggle microphone mute with notification
TAG="mic"

# Toggle mute
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

# Small delay so wpctl updates state
sleep 0.05

# Read state
STATE=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)

if echo "$STATE" | grep -qi "MUTED"; then
    ICON="microphone-sensitivity-muted"
    TEXT="Mic Muted"
    VALUE=0
else
    ICON="microphone-sensitivity-high"
    TEXT="Mic Active"
    VALUE=100
fi

# Notify (replace previous mic notif)
dunstify -i "$ICON" -r 9992 -u normal \
  -t 1300 \
  -h string:x-dunst-stack-tag:$TAG \
  -h int:value:$VALUE \
  "$TEXT"
