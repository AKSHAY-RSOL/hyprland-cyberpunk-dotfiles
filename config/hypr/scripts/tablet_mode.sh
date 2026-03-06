#!/bin/bash

# Tablet Mode Script
# Toggles external display connection for tablet/extended display usage

EXTERNAL=$(hyprctl monitors -j | jq -r '.[] | select(.name != "eDP-1") | .name' | head -1)

if [ -n "$EXTERNAL" ]; then
    # External display detected - configure it
    notify-send "Tablet Mode" "External display detected: $EXTERNAL"
    
    # Option 1: Mirror mode
    # hyprctl keyword monitor "$EXTERNAL,preferred,auto,1,mirror,eDP-1"
    
    # Option 2: Extend to the right (default)
    hyprctl keyword monitor "$EXTERNAL,preferred,auto-right,1"
    
    notify-send "Tablet Mode" "Display extended to $EXTERNAL"
else
    # No external display - reset to laptop only
    hyprctl keyword monitor "eDP-1,preferred,auto,1"
    notify-send "Tablet Mode" "Using laptop display only"
fi
