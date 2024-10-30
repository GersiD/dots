#!/bin/bash
# Set default audio device
# Usage: audio.sh [device name]
# Either based on the device name given as argument or by selecting from a list
if [ $# -eq 0 ]; then
	num=$(wpctl status | grep -A 5 "Sinks:" | fzf | awk -F'[^0-9]*' '{print $2}')
else
	num=$(wpctl status | grep "$1" | grep "vol" | tail -1 | awk -F'[^0-9]*' '{print $2}')
fi
if [ -z "$num" ]; then
	echo "No such device"
else
	echo "Setting default audio device to num $num"
	wpctl set-default $num
fi
