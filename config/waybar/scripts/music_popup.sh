#!/bin/bash

# Cyberpunk Music Popup v4
# Features: Persistent, Cached, Instant Click, robust Window Toggle

CACHE_DIR="/tmp/music_popup_cache"
mkdir -p "$CACHE_DIR"

while true; do
    STATUS=$(playerctl status 2>/dev/null)
    [ -z "$STATUS" ] && STATUS="Stopped"

    ARTIST=$(playerctl metadata xesam:artist 2>/dev/null)
    TITLE=$(playerctl metadata xesam:title 2>/dev/null)
    ALBUM=$(playerctl metadata xesam:album 2>/dev/null)
    ART_URL=$(playerctl metadata mpris:artUrl 2>/dev/null)
    
    [ -z "$ARTIST" ] && ARTIST="No Music"
    [ -z "$TITLE" ] && TITLE="Select a song..."

    SAFE_ALBUM=$(echo "$ALBUM" | sed 's/[^a-zA-Z0-9]/_/g')
    [ -z "$SAFE_ALBUM" ] && SAFE_ALBUM="default"
    ALBUM_ART="$CACHE_DIR/${SAFE_ALBUM}.jpg"

    if [ ! -f "$ALBUM_ART" ]; then
        if [ -n "$ART_URL" ]; then
            ART_URL=$(echo "$ART_URL" | sed 's|^open.spotify.com|https://i.scdn.co/image|')
             curl -s "$ART_URL" -o "$ALBUM_ART" & 
        else
            touch "$ALBUM_ART"
        fi
    fi

    PLAY_ICON="⏸️"
    [ "$STATUS" = "Paused" ] && PLAY_ICON="▶️"
    [ "$STATUS" = "Stopped" ] && PLAY_ICON="▶️"

    # Menu: Play | Prev | Next | Volume | Show/Hide
    # Removed Close button
    OPTIONS="$PLAY_ICON Play/Pause\n⏮️ Prev\n⏭️ Next\n🔊 Volume\n👁️ Show/Hide"

    CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu \
        -theme $HOME/.config/rofi/music-popup.rasi \
        -p "$ARTIST" \
        -mesg "$TITLE" \
        -selected-row 0 \
        -hover-select -me-select-entry '' -me-accept-entry 'MousePrimary')

    case "$CHOICE" in
        *"Play/Pause")
            playerctl play-pause
            sleep 0.1
            ;;
        *"Prev")
            playerctl previous
            sleep 0.5 # Wait for metadata update
            ;;
        *"Next")
            playerctl next
            sleep 0.5 # Wait for metadata update
            ;;
        *"Volume")
            # Toggle Pavucontrol
            if pgrep -x "pavucontrol" > /dev/null; then
                pkill pavucontrol
            else
                pavucontrol &
                exit 0
            fi
            ;;
        *"Show/Hide")
            # Logic to find Spotify client address
            # Uses initialTitle or class (LOWERCASE spotify)
            # Re-fetch address fresh every time to avoid stale handles
            ADDRESS=$(hyprctl clients -j | jq -r '.[] | select(.class == "spotify" or .initialClass == "spotify" or .title == "Spotify Free" or .class == "Spotify") | .address' | head -n 1)
            
            if [ -n "$ADDRESS" ]; then
                # Check workspace of this address
                WS=$(hyprctl clients -j | jq -r --arg addr "$ADDRESS" '.[] | select(.address == $addr) | .workspace.id')
                
                if [ "$WS" = "9" ]; then
                    # Hidden -> Show on Current
                    # Use standard move to bring it HERE and focus
                    hyprctl dispatch movetoworkspace current,address:$ADDRESS
                    hyprctl dispatch focuswindow address:$ADDRESS
                    notify-send "Spotify" "Showing window"
                    exit 0 # Exit popup so user can use Spotify
                else
                    # Visible -> Hide to 9
                    # Use SILENT move to stay here
                    hyprctl dispatch movetoworkspacesilent 9,address:$ADDRESS
                    notify-send "Spotify" "Hiding window"
                fi
            else
                notify-send "Spotify" "Window not found!"
            fi
            ;;
        *)
            # Esc or click outside
            exit 0
            ;;
    esac
    
    # Tiny delay to loop
    sleep 0.05
done
