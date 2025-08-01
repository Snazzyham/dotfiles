#!/usr/bin/env bash

# 1. Build dynamic list: custom entries + installed apps
choices=$(printf "fsearch\nem\ntz\ncurr\nclip\n")
apps=$(fd . /usr/share/applications ~/.local/share/applications \
  --extension desktop \
  --exec basename {} .desktop 2>/dev/null | sort | uniq)

# 2. Combine into one list for Fuzzel
selection=$(printf "%s\n%s" "$choices" "$apps" | fuzzel --dmenu -p "Launcher:")

# 3. Dispatch
case "$selection" in
  fsearch)
    kitty -e bash -c 'selected=$(fd . ~ | fzf --prompt="Find file: "); [[ -n "$selected" ]] && xdg-open "$selected"'
    ;;

  em)
    rofimoji --selector fuzzel --action copy
    ;;

  tz)
    xdg-open "https://everytimezone.com/" & disown
    ;;

  curr)
    xdg-open "https://www.xe.com/currencyconverter/" & disown
    ;;

  clip)
    cliphist list | fuzzel --dmenu | cliphist decode | wl-copy
    ;;

  "")
    # user hit escape
    ;;

  *)
    # Try launching it as a .desktop app
    gtk-launch "$selection"
    ;;
esac
