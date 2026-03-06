#!/bin/bash

# Lock Screen Script
# Optionally play video before locking

VIDEO="$HOME/.config/hypr/wallpapers/lockvideo.mp4"

# Check if video exists and mpv is available
if [ -f "$VIDEO" ] && command -v mpv &> /dev/null; then
    # Play video transition then lock
    mpv --fullscreen \
        --no-terminal \
        --ontop \
        --no-border \
        --keep-open=no \
        --osd-level=0 \
        "$VIDEO" 2>/dev/null
fi

# Lock screen
hyprlock
