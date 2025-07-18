#!/bin/bash

# Options with icons matching your Waybar
options="󰌾  Lock
󰤄  Suspend
󰍃  Logout
󰐥  Shutdown
󰑓  Reboot"

# Display wofi menu
choice=$(echo -e "$options" | wofi --show dmenu --conf ~/.config/wofi/power.rasi --style ~/.config/wofi/power-theme.css --prompt "Power" --cache-file /dev/null)

case $choice in
  *Lock) 
    killall Discord || true && swaylock -f && sleep 1 && hyprctl dispatch dpms off ;;
  *Suspend)
    swaylock -f && systemctl suspend ;;
  *Logout)
    hyprctl dispatch exit 0 ;;
  *Shutdown)
    systemctl poweroff ;;
  *Reboot)
    systemctl reboot ;;
  *Audio)
    hyprctl dispatch dpms off && hyprctl dispatch dpms on ;;
esac
