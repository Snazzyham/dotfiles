#!/usr/bin/env bash

mode=$1

if [[ $mode == "clipboard" ]]; then
    hyprshot --freeze --mode=region --clipboard && notify-send "Screenshot saved to clipboard"
elif [[ $mode == "swappy" ]]; then
    # hyprshot --freeze --mode=region --raw | magick - png:- | swappy -f -
    hyprshot --freeze --mode=region --raw | satty --filename - --copy-command wl-copy --early-exit
fi
