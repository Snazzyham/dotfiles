#!/bin/bash

# wal -f sexy-gotham -o $HOME/theme_scripts/done.sh
wal -f base16-materialer -o $HOME/theme_scripts/done.sh
pywalfox update
pywalfox dark
sed -i 's/0/1/g' $HOME/.mozilla/firefox/n35tejjh.default-release/user.js
sed -i 's/Orchis-light/Orchis-dark/g' $HOME/.config/gtk-3.0/settings.ini
feh --bg-scale $HOME/Pictures/wallpapers/ios15dark.jpg

