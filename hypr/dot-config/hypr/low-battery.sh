#!/bin/bash

while true; do
	# Get battery status and capacity
	STATUS=$(cat /sys/class/power_supply/BAT0/status)
	CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)

	if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -lt 30 ]; then
		notify-send -u critical -i battery-caution "Low Battery" "Battery is at ${CAPACITY}%"

		sleep 300
	else
		sleep 60
	fi
done
