#!/bin/bash

# Path to the video
VIDEO="$HOME/.config/hypr/wallpapers/lockvideo.mp4"

# Play the video fullscreen, on top of everything, and exit when done.
# --fullscreen: Fullscreen
# --no-terminal: No output
# --ontop: Force on top
# --no-border: No window borders
# --input-ipc-server: Optional, good for control
# --on-all-workspaces: Ensures it covers everything (Hyprland rule might be needed, but fullscreen usually works)
mpv --fullscreen --no-terminal --ontop --no-border --keep-open=no "$VIDEO"

# Immediately lock screen after video ends
hyprlock
