#!/bin/bash

options="󰌾  lock
󰤄  suspend
󰍃  logout
󰐥  shutdown
󰑓  reboot"

choice=$(echo "$options" | rofi -dmenu -p "Power Menu")

case $choice in
  *lock) killall Discord || true && hyprlock && sleep 1 && hyprctl dispatch dpms off ;;
  *suspend) hyprlock && systemctl suspend ;;
  *logout) hyprctl dispatch exit 0 ;;
  *shutdown) systemctl poweroff ;;
  *reboot) systemctl reboot ;;
esac
