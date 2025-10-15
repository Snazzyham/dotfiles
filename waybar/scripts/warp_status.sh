#!/usr/bin/env bash
# Minimal, one-line JSON. No tooltip/newlines to break Waybar.

export LC_ALL=C

ICON="󰖟"                # Nerd Font cloud (fallback below if needed)
GREEN="#4CAF50"
BLUE="#2196F3"
RED="#E53935"
YELLOW="#FDD835"
ORANGE_BG="rgba(244, 129, 32, 0.15)"  # not used here; just your CSS

# Read status/mode (silence errors)
STATUS="$(warp-cli status 2>/dev/null || true)"
MODE="$(warp-cli mode 2>/dev/null | tr -d '"' || true)"

CONNECTED=false
[[ "$STATUS" == *"Status update: Connected"* ]] && CONNECTED=true

# Fast HTTP reachability check (IPv4; 2s timeout)
REDDIT_OK=false
CODE="$(curl -4sI --max-time 2 -o /dev/null -w "%{http_code}" https://www.reddit.com || true)"
[[ "$CODE" =~ ^2..$ || "$CODE" =~ ^3..$ ]] && REDDIT_OK=true

LABEL="OFF"; COLOR="$RED"; CLASS="warp-off"
if $CONNECTED; then
  if [[ "$MODE" =~ warp ]]; then
    if $REDDIT_OK; then
      LABEL="WARP"; COLOR="$GREEN"; CLASS="warp-on"
    else
      LABEL="WARP?"; COLOR="$YELLOW"; CLASS="warp-suspect"
    fi
  else
    if $REDDIT_OK; then
      LABEL="DNS"; COLOR="$BLUE"; CLASS="warp-dns"
    else
      LABEL="DNS?"; COLOR="$YELLOW"; CLASS="warp-suspect"
    fi
  fi
fi

# If your font can't render the icon, uncomment the next line:
# ICON="☁"

printf '{"text":" %s %s ","class":"%s","color":"%s"}\n' "$ICON" "$LABEL" "$CLASS" "$COLOR"
