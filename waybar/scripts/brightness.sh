#!/bin/bash

# Get the current brightness percentage and round it to the nearest integer
BRIGHTNESS=$(brightnessctl -m | awk -F, '{print int($4)}')

# Use a sun icon from a Nerd Font
ICON="" 

# Print the icon and brightness percentage
echo "$ICON $BRIGHTNESS"
