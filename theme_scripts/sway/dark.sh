#!/bin/bash
wal -f $HOME/.colorschemes/nord.json -o $HOME/theme_scripts/done.sh
sed -i 's/Orchis-light/Orchis-dark/g' $HOME/.config/gtk-3.0/settings.ini
sed -i 's/false/true/g' $HOME/.config/gtk-3.0/settings.ini

