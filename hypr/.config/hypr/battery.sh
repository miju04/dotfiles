#!/bin/bash

# Get battery status and capacity
STATUS=$(cat /sys/class/power_supply/BAT0/status)
CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)

# Define icons
CHARGING_ICON=""
PLUGGED_ICON=""
BATTERY_ICONS=("" "" "" "" "")

# Choose icon based on status and capacity
if [ "$STATUS" = "Charging" ]; then
  ICON=$CHARGING_ICON
elif [ "$STATUS" = "Full" ] || [ "$STATUS" = "Not charging" ]; then
  ICON=$PLUGGED_ICON
else
  if [ "$CAPACITY" -ge 90 ]; then
    ICON=${BATTERY_ICONS[4]}
  elif [ "$CAPACITY" -ge 70 ]; then
    ICON=${BATTERY_ICONS[3]}
  elif [ "$CAPACITY" -ge 50 ]; then
    ICON=${BATTERY_ICONS[2]}
  elif [ "$CAPACITY" -ge 30 ]; then
    ICON=${BATTERY_ICONS[1]}
  else
    ICON=${BATTERY_ICONS[0]}
  fi
fi

echo "$ICON  $CAPACITY%"

