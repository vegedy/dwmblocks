#!/bin/sh
CHARGE_ICON=""
DISCHARGE_ICON0=""
DISCHARGE_ICON1=""
DISCHARGE_ICON2=""
DISCHARGE_ICON3=""
DISCHARGE_ICON4=""

read -r capacity </sys/class/power_supply/BAT0/capacity
read -r powerstatus </sys/class/power_supply/BAT0/status

if [ "$powerstatus" == "Charging" ]; then
  ICON=$CHARGE_ICON
elif [ "$capacity" -lt "20" ]; then
  ICON=$DISCHARGE_ICON0

  # Send warning
  notify-send "Battery low"
  mpv --no-video ~/Music/Sounds/warning.mp3
elif [ "$capacity" -lt "40" ]; then
  ICON=$DISCHARGE_ICON1
elif [ "$capacity" -lt "60" ]; then
  ICON=$DISCHARGE_ICON2
elif [ "$capacity" -lt "80" ]; then
  ICON=$DISCHARGE_ICON3
else
  ICON=$DISCHARGE_ICON4
fi

# Print output
printf "$ICON %s%%" "$capacity"

