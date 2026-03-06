#!/usr/bin/env bash

# Get all connected device names
mapfile -t devices < <(echo -e "devices Connected\nquit" | bluetoothctl 2>/dev/null | grep "^Device" | cut -d ' ' -f3-)

count=${#devices[@]}

if [ "$count" -eq 0 ]; then
  echo '{"text": "󰂲 Off"}'
elif [ "$count" -eq 1 ]; then
  echo "{\"text\": \"󰂯 ${devices[0]}\"}"
else
  tooltip=$(IFS=', '; echo "${devices[*]}")
  echo "{\"text\": \"󰂯 ${count} Devices\", \"tooltip\": \"${tooltip}\"}"
fi
