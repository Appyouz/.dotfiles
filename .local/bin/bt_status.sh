#!/bin/sh
#
# # Check if the bluetooth controller is powered on
# if bluetoothctl show | grep -q "Powered: yes"; then
#     # Bluetooth is ON. Now check if any audio device is connected (more specific)
#     # This checks for a connected device that has an A2DP (audio) profile.
#     if pactl list sinks | grep -q "bluetooth.protocol=a2dp"; then
#         echo ""  # Connected Icon (Unicode for a filled Bluetooth symbol)
#     else
#         echo ""  # Standby Icon (Unicode for an outline Bluetooth symbol)
#     fi
# else
#     echo " " # Bluetooth is OFF, show nothing or another icon if you prefer
# fi
#
# The UPower device path for a headset (this will contain the MAC address)
# We find it once by checking all UPower devices for the 'headset' type.


BT_DEVICE_PATH=$(upower -e 2>/dev/null | grep 'headset_dev_')

# 1. Check if a headset is detected by UPower
if [ -n "$BT_DEVICE_PATH" ]; then
    
    # 2. Extract the battery percentage from the device path
    # We use awk/grep to get the 'percentage:' line and then extract just the number and the percent sign.
    BATTERY_LEVEL=$(upower -i "$BT_DEVICE_PATH" 2>/dev/null | \
                    grep 'percentage:' | awk '{print $2}')
    
    # 3. Output the result
    # If the percentage is found, display it. Otherwise, display the 'connected' icon.
    if [ -n "$BATTERY_LEVEL" ]; then
        # Example output: " 85%"
        echo " $BATTERY_LEVEL"
    else
        # Connected, but battery level not yet available
        echo ""
    fi

else
    # Bluetooth is ON (from your old script logic), but no headset is connected/detected.
    # We keep your original logic for general BT status.
    if bluetoothctl show | grep -q "Powered: yes"; then
        echo ""  # Standby Icon (Bluetooth powered on, but idle)
    else
        echo " "  # Bluetooth is OFF
    fi
fi
