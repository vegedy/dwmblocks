#!/bin/sh
ICON=""
read -r capacity </sys/class/power_supply/BAT0/capacity
printf "$ICON %s%%" "$capacity"
if [ "$capacity" -lt "16" ]
then
  notify-send "Battery low"
  mpv --no-video ~/Music/Sounds/warning.mp3
fi

