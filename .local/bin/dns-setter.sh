#!/bin/bash

# Define the connection name and the DNS servers
CONNECTION_NAME="Home"
ADGUARD_DNS="94.140.14.14 94.140.15.15"

echo "Attempting to set persistent DNS for connection: ${CONNECTION_NAME}"

if sudo nmcli connection modify "${CONNECTION_NAME}" \
    ipv4.dns "${ADGUARD_DNS}" \
    ipv4.ignore-auto-dns yes; then
    
    echo " Successfully updated connection settings."
else
    echo " ERROR: Failed to modify connection settings. Check if the connection name '${CONNECTION_NAME}' is correct."
    exit 1
fi

# Re-activate the connection to apply the changes immediately
echo "Attempting to re-activate the connection..."

if sudo nmcli connection up "${CONNECTION_NAME}"; then
    echo " Connection re-activated successfully. AdGuard DNS should now be active."
else
    echo " ERROR: Failed to bring the connection back up. Network settings might be unstable."
    exit 1
fi

# Final verification
echo "----------------------------------------------------"
echo "Running quick check (resolvectl status) for confirmation:"
resolvectl status | grep -A 5 "Link ${CONNECTION_NAME}"

echo "----------------------------------------------------"
echo "Script finished."
