#!/bin/bash

wal -f base16-cupertino -l -o $HOME/theme_scripts/done.sh
sed -i 's/1/0/g' $HOME/.mozilla/firefox/n35tejjh.default-release/user.js
pywalfox light
pywalfox update
sed -i 's/Orchis-dark/Orchis-light/g' $HOME/.config/gtk-3.0/settings.ini
sed -i 's/true/false/g' $HOME/.config/gtk-3.0/settings.ini
feh --bg-scale $HOME/Pictures/wallpapers/ios15light.jpg
