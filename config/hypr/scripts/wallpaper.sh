#!/bin/bash

# Random Wallpaper Script
# Cycles through wallpapers with smooth transitions
# Dependencies: swww

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"

# Initialize swww if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww init &
    sleep 2
fi

# Find all image files
PICS=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) 2>/dev/null))

if [ ${#PICS[@]} -eq 0 ]; then
    notify-send "Wallpaper" "No images found in $WALLPAPER_DIR"
    exit 1
fi

# Select random wallpaper
RANDOM_PIC="${PICS[$RANDOM % ${#PICS[@]}]}"

# Set wallpaper with cyberpunk transition
swww img "$RANDOM_PIC" \
    --transition-type grow \
    --transition-pos 0.9,0.9 \
    --transition-step 90 \
    --transition-fps 60 \
    --transition-duration 1

notify-send "Wallpaper" "$(basename "$RANDOM_PIC")"
