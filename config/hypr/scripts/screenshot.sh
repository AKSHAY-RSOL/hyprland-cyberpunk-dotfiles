#!/bin/bash

# Cyberpunk Screenshot Script
# Dependencies: grim, slurp, wl-copy, notify-send

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="screenshot_${TIMESTAMP}.png"
FILEPATH="$SCREENSHOT_DIR/$FILENAME"

notify_success() {
    notify-send -i "$FILEPATH" "Screenshot Saved" "$FILENAME\nCopied to clipboard!" -t 3000
}

notify_cancelled() {
    notify-send "Screenshot" "Cancelled" -t 2000
}

case "$1" in
    "region")
        # Select region with slurp
        GEOMETRY=$(slurp 2>/dev/null)
        if [ -n "$GEOMETRY" ]; then
            grim -g "$GEOMETRY" "$FILEPATH"
            wl-copy < "$FILEPATH"
            notify_success
        else
            notify_cancelled
        fi
        ;;
    "window")
        # Capture active window
        GEOMETRY=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        if [ -n "$GEOMETRY" ] && [ "$GEOMETRY" != "null,null nullxnull" ]; then
            grim -g "$GEOMETRY" "$FILEPATH"
            wl-copy < "$FILEPATH"
            notify_success
        else
            notify-send "Screenshot" "No active window found" -t 2000
        fi
        ;;
    "full"|*)
        # Full screen capture
        grim "$FILEPATH"
        wl-copy < "$FILEPATH"
        notify_success
        ;;
esac
