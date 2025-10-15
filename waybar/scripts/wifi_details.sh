#!/bin/sh

# This script will display network details in a popup window.
# It requires 'zenity' to be installed.

# Check if nmcli is available
if ! command -v nmcli &> /dev/null
then
    echo "nmcli could not be found. Please install NetworkManager."
    exit 1
fi

# Get the name of the active WiFi connection. This version is more robust.
connection_name=$(nmcli -t -f NAME,TYPE,ACTIVE connection show | grep '802-11-wireless:yes$' | cut -d':' -f1)

# If no active WiFi connection is found, exit
if [ -z "$connection_name" ]; then
    echo "Not connected to a WiFi network."
    exit 1
fi

# Get the SSID from the active connection's details
ssid=$(nmcli -t -f 802-11-wireless.ssid connection show "$connection_name" | cut -d':' -f2 | xargs)

# Get the signal strength of the active connection
# We use the connection name directly to get the signal.
signal_strength=$(nmcli -t -f signal device wifi list | grep "$connection_name" | awk '{print $9}' | head -n 1)

# Get the IP address
ip_address=$(nmcli -t -f ipv4.addresses connection show "$connection_name" | cut -d':' -f2 | xargs)

# Check if zenity is available
if command -v zenity &> /dev/null
then
    zenity --info --title="Wi-Fi Connection Details" --width=300 --text="\
    Network: <b>$ssid</b>
    IP Address: <b>$ip_address</b>
    Signal Strength: <b>$signal_strength%</b>
    "
else
    echo "zenity command not found. Please install it with 'sudo pacman -S zenity'."
    echo "--- Connection Details ---"
    echo "Network: $ssid"
    echo "IP Address: $ip_address"
    echo "Signal Strength: $signal_strength%"
fi
