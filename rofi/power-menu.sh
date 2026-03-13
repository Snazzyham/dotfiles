#!/bin/bash

options="󰌾  lock
󰤄  suspend
󰍃  logout
󰐥  shutdown
󰑓  reboot"

choice=$(echo "$options" | rofi -dmenu -p "Power Menu")

case $choice in
  *lock) 
    # Kill Discord first, then lock with screen off
    killall Discord 2>/dev/null || true
    # Start hyprlock in background, wait for it to render, then turn off displays
    hyprlock &
    sleep 0.5
    hyprctl dispatch dpms off
    ;;
  *suspend) 
    # Lock and suspend - hypridle handles the lock before sleep
    loginctl lock-session
    sleep 0.5
    systemctl suspend 
    ;;
  *logout) hyprctl dispatch exit 0 ;;
  *shutdown) systemctl poweroff ;;
  *reboot) systemctl reboot ;;
esac
