#!/usr/bin/env bash
# volume.sh — portable script (uses pamixer) with tagging and notifications

TAG="volume"
STEP=5          # percent step

case "$1" in
  up)
    pamixer --unmute
    pamixer --increase $STEP
    ;;
  down)
    pamixer --unmute
    pamixer --decrease $STEP
    ;;
  toggle)
    pamixer --toggle-mute
    ;;
  *)
    echo "Usage: $0 up|down|toggle"
    exit 1
    ;;
esac

# Pause slightly to stabilize
sleep 0.05

# Get values
VOLUME=$(pamixer --get-volume)          # returns an integer percentage
MUTED=$(pamixer --get-mute)             # returns "true" or "false"

# Determine icon
if [ "$MUTED" = "true" ] || [ "$VOLUME" -eq 0 ]; then
  ICON="audio-volume-muted"
  TEXT="Muted"
else
  if [ "$VOLUME" -lt 30 ]; then
    ICON="audio-volume-low"
  elif [ "$VOLUME" -lt 70 ]; then
    ICON="audio-volume-medium"
  else
    ICON="audio-volume-high"
  fi
  TEXT="Volume: ${VOLUME}%"
fi

# Send notification (replace previous)
dunstify -i "$ICON" -r 2593 -u normal \
  -t 1000 \
  -h string:x-dunst-stack-tag:$TAG \
  -h int:value:$VOLUME \
  "$TEXT"