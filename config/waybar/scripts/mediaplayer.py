#!/usr/bin/env python3
import sys
import json
import subprocess

def get_player_status():
    try:
        # Get player status
        status = subprocess.check_output(['playerctl', 'status'], stderr=subprocess.STDOUT).decode('utf-8').strip()
        
        # Get metadata
        artist = subprocess.check_output(['playerctl', 'metadata', 'xesam:artist'], stderr=subprocess.STDOUT).decode('utf-8').strip()
        title = subprocess.check_output(['playerctl', 'metadata', 'xesam:title'], stderr=subprocess.STDOUT).decode('utf-8').strip()
        
        # Truncate if too long
        text = f"{artist} - {title}"
        if len(text) > 40:
            text = text[:37] + "..."
        
        # Determine player class (spotify, firefox, etc.)
        player_class = "spotify"  # Default to spotify for styling
        
        output = {
            "text": text,
            "tooltip": f"{artist} - {title}",
            "class": player_class,
            "alt": status.lower()
        }
        
        print(json.dumps(output))
        
    except subprocess.CalledProcessError:
        # No player running
        print(json.dumps({"text": "", "class": "stopped"}))
    except Exception as e:
        # Debug: print error to stderr
        print(json.dumps({"text": "", "class": "error"}))

if __name__ == "__main__":
    get_player_status()
