#!/bin/sh

MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}')
VOL=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i ~ /%/) {gsub(/%/,"",$i); print $i; exit}}')

if [ "$MUTE" = "yes" ] || [ "$MUTE" = "ja" ]; then
    printf " Mute"
else
    if [ -z "$VOL" ]; then
        printf " 0%%"
    elif [ "$VOL" -ge 66 ]; then
        printf " %s%%" "$VOL"
    elif [ "$VOL" -ge 33 ]; then
        printf " %s%%" "$VOL"
    elif [ "$VOL" -ge 5 ]; then
        printf " %s%%" "$VOL"
    else
        printf " 0%%"
    fi
fi
