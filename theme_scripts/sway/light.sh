#!/bin/bash

wal -f $HOME/.colorschemes/nord-light.json -o $HOME/theme_scripts/done.sh
sed -i 's/Orchis-dark/Orchis-light/g' $HOME/.config/gtk-3.0/settings.ini
sed -i 's/true/false/g' $HOME/.config/gtk-3.0/settings.ini
