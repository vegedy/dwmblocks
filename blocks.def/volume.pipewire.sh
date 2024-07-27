#!/bin/bash
#!/bin/bash

# Ermitteln des Standard-Sinks
sink=$(pactl info | awk '$1 == "Default" && $2 == "Sink:" {print $3}')

# Lautstärke extrahieren
volume=$(pactl list sinks | grep "Name: $sink" -A 7 | awk -F/ '/Volume:/ {gsub("%", ""); print $2}' | xargs)

# Mute-Status extrahieren
mute=$(pactl list sinks | grep "Name: $sink" -A 7 | awk -F: '/Mute:/ {print $2}' | xargs)

# Ausgabe basierend auf Mute-Status und Lautstärke
if [ "$mute" == "yes" ]; then
    echo "🔇 Mute"
else
    if [ "$volume" -ge 66 ]; then
        echo "🔊 $volume%"
    elif [ "$volume" -ge 33 ]; then
        echo "🔉 $volume%"
    else
        echo "🔈 $volume%"
    fi
fi

