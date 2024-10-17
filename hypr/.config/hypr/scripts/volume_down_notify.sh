#!/bin/bash
pactl set-sink-volume @DEFAULT_SINK@ -5%
VOLUME=$(amixer get Master | grep -oP '\[\d+%\]' | head -1 | tr -d '[]')
notify-send -a "volume_notify" -u low "Volume Down  " "Volume decreased to $VOLUME"
