#!/bin/sh

MUTE_ICON=""
VOL_LOW_ICON="\U1F508"
VOL_MID_ICON="\U1F509"
VOL_HIGH_ICON="\U1F50A"
VOL_OFF_ICON=""

MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}')
VOL=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i ~ /%/) {gsub(/%/,"",$i); print $i; exit}}')

if [ "$MUTE" = "yes" ] || [ "$MUTE" = "ja" ]; then
    printf "%b Mute" "$MUTE_ICON"
else
    if [ -z "$VOL" ]; then
        printf "%b 0%%" "$VOL_OFF_ICON"
    elif [ "$VOL" -ge 66 ]; then
        printf "%b %s%%" "$VOL_HIGH_ICON" "$VOL"
    elif [ "$VOL" -ge 33 ]; then
        printf "%b %s%%" "$VOL_MID_ICON" "$VOL"
    elif [ "$VOL" -ge 5 ]; then
        printf "%b %s%%" "$VOL_LOW_ICON" "$VOL"
    else
        printf "%b 0%%" "$VOL_OFF_ICON"
    fi
fi
