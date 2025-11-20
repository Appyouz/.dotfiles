#!/bin/sh

# Check the current status of the Bluetooth controller power
STATUS=$(bluetoothctl show | grep "Powered: yes")

if [ -n "$STATUS" ]; then
    # Bluetooth is ON, so turn it OFF
    bluetoothctl power off
    notify-send -u normal "Bluetooth Power" "Turned OFF"
else
    # Bluetooth is OFF, so turn it ON
    bluetoothctl power on
    notify-send -u normal "Bluetooth Power" "Turned ON"
fi
