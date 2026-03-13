#!/bin/bash

# Focus mode toggle script for Hyprland
# Toggles a window between floating (60% width, centered, full height) and tiled mode

# Check if active window is floating
IS_FLOATING=$(hyprctl activewindow -j | jq -r '.floating')

if [ "$IS_FLOATING" = "true" ]; then
    # Window is floating, toggle back to tiled
    hyprctl dispatch togglefloating
else
    # Window is tiled, make it floating with focus mode dimensions
    hyprctl dispatch togglefloating
    sleep 0.1  # Small delay to ensure toggle completes
    hyprctl dispatch resizeactive exact 60% 100%
    hyprctl dispatch centerwindow
fi
