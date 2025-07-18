#!/bin/bash

# Your network interface
IFACE="enp34s0"

# Get WOL status
WOL_STATE=$(ethtool "$IFACE" 2>/dev/null | awk '/Wake-on:/ {print $2}' | tail -n1)

# Use Nerd Font Ethernet icon:  (Unicode: `f6bf`)
ICON="  "

if [[ "$WOL_STATE" == "g" ]]; then
    echo "{\"text\": \"$ICON on\", \"tooltip\": \"Wake-on-LAN: Enabled\"}"
else
    echo "{\"text\": \"$ICON off\", \"tooltip\": \"Wake-on-LAN: Disabled\"}"
fi
