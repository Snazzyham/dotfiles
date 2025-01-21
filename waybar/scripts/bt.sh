#!/usr/bin/env bash

# Example: Show connected device name or 'Off' if none
device=$(bluetoothctl info | grep "Name:" | cut -d ' ' -f2-)
if [ -z "$device" ]; then
  echo "  Off"  # or whatever icon you like
else
  echo "  $device"
fi
