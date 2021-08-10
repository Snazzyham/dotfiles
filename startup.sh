#!/bin/bash

echo "setting natural scrolling on touchpad and mouse"
xinput set-prop "SYNA8004:00 06CB:CD8B Touchpad" 322 1
xinput set-prop "2.4G Mouse" 322 1
echo "increasing scroll speed"
killall imwheel
imwheel -b "45"
xset r rate 280 40
killall gpaste-daemon
killall gpaste-client
gpaste-client
