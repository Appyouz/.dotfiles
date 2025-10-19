#!/bin/bash

state=$(nmcli radio wifi)

if [ "$state" = "enabled" ]; then
    nmcli radio wifi off
    notify-send "Wi-Fi disabled" -i network-wireless-offline-symbolic
else
    nmcli radio wifi on
    notify-send "Wi-Fi enabled" -i network-wireless-signal-excellent-symbolic
fi
