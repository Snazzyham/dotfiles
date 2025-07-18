#!/bin/bash

STATEFILE="$HOME/.cache/gammastep_state"
TEMP_ON=5500
ICON_ON="󰖔 " 
ICON_OFF="󱣖 " 

# Toggle logic
if [[ -f "$STATEFILE" && $(<"$STATEFILE") == "on" ]]; then
    gammastep -x
    echo "off" > "$STATEFILE"
    echo "{\"text\": \"$ICON_OFF\", \"tooltip\": \"Blue light filter off\"}"
else
    gammastep -O "$TEMP_ON"
    echo "on" > "$STATEFILE"
    echo "{\"text\": \"$ICON_ON\", \"tooltip\": \"Blue light filter set to ${TEMP_ON}K\"}"
fi
