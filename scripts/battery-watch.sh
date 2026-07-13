#!/bin/bash

LOW_THRESHOLD=19
FULL_THRESHOLD=79       # I use 79 here because I personally user a 80% battery cap.
CHECK_INTERVAL=60

ICON_LOW="/usr/share/icons/char-white/status/48/battery-caution.svg"
ICON_FULL="=/usr/share/icons/hicolor/128x128/status/battery-full.png"

while true; do
    PERC=$(cat /sys/class/power_supply/BAT*/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT*/status)

    # Low battery warning
    if [ "$STATUS" != "Charging" ] && [ $PERC -le $LOW_THRESHOLD ]; then
        notify-send -u critical -i "$ICON_LOW" \
        "Low Battery" "Battery is at ${PERC}%. Plug in now."
    fi

    # Battery full reminder when charging
    if [ "$STATUS" == "Charging" ] && [ $PERC -ge $FULL_THRESHOLD ]; then
        notify-send -u normal -i "$ICON_FULL" \
        "Battery Charged" "Battery is at ${PERC}%. You can unplug."
    fi

    sleep $CHECK_INTERVAL
done
