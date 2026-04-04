#!/bin/sh

DEVICE_PATH="/org/freedesktop/UPower/devices/headset_dev_54_84_50_9D_0D_64"
LOW_THRESHOLD=100 # Notify when battery is 20% or less

if [ -e "$DEVICE_PATH" ]; then
    BATTERY_LEVEL=$(upower -i "$DEVICE_PATH" | grep 'percentage' | awk '{print $2}' | tr -d '%')
    STATE=$(upower -i "$DEVICE_PATH" | grep 'state' | awk '{print $2}')

    if [ "$STATE" = "discharging" ] && [ "$BATTERY_LEVEL" -le "$LOW_THRESHOLD" ]; then
        # This will only notify if the level is low AND it's discharging
        notify-send -u critical "LOW EARBUD BATTERY" "Redmi Buds 6 Play is at ${BATTERY_LEVEL}%! Please charge soon." -i battery-low
    fi
fi
