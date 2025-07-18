#!/bin/bash

STATEFILE="$HOME/.cache/gammastep_state"
ICON_ON="󰖔"
ICON_OFF="󱣖"

if [[ -f "$STATEFILE" && $(<"$STATEFILE") == "on" ]]; then
    echo "{\"text\": \"$ICON_ON\", \"tooltip\": \"Blue light filter on (5500K)\"}"
else
    echo "{\"text\": \"$ICON_OFF\", \"tooltip\": \"Blue light filter off\"}"
fi
