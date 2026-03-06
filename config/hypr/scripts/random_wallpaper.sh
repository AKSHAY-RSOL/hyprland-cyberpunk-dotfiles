#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"

# Check if swww is running, if not start it
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww init &
    sleep 2
fi

# Select a random wallpaper
PICS=($(find "${WALLPAPER_DIR}" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
RANDOM_PIC=${PICS[ $RANDOM % ${#PICS[@]} ]}

# Set wallpaper with transition
echo "Setting wallpaper: $RANDOM_PIC"
swww img "$RANDOM_PIC" --transition-type grow --transition-pos 0.9,0.9 --transition-step 90 --transition-fps 60
