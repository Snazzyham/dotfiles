#!/usr/bin/env bash
# ~/.config/waybar/scripts/warp_toggle.sh


if warp-cli status 2>/dev/null | grep -q "Status update: Connected"; then
  warp-cli disconnect >/dev/null 2>&1
  exit 0
fi

# Turn ON
warp-cli mode warp+doh >/dev/null 2>&1
warp-cli tunnel protocol set MASQUE >/dev/null 2>&1 || true
warp-cli connect >/dev/null 2>&1
