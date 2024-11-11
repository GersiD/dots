#!/bin/bash
printf 'Press Ctrl+C to stop the stopwatch\n'
printf 'Start: '
printf '%s' "$(date +%T.%N)"
printf '\n'
while true; do
	printf '%s' "$(date +%T.%N)"
	sleep 1
	printf '\r'
done
