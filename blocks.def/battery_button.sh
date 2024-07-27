#!/bin/sh

read -r powerstatus </sys/class/power_supply/BAT0/status
[ "$powerstatus" = "Discharging" ] && notify-send "Discharging" && exit

remtime=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk -F: '/time\sto\sfull:/ {print $2}' | xargs)
notify-send "$remtime remaining"

