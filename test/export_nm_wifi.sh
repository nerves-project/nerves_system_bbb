#!/bin/sh
###
### Print wifi networks config as a list of colon-separated base64 encoded strings
###

if test "$(id -u)" -ne "0"; then
    echo "E: You must run this as root"
    exit 1
fi

networks=
for conn in /etc/NetworkManager/system-connections/*; do
    network=$(awk 'match($0, /^\[(.*)\]$/) { section=substr($0, RSTART+1, RLENGTH-2) }; /^[^\[]/ { print section "." $0 }' < "${conn}")
    encoded=$(echo "${network}" | base64 -w0)
    networks="${encoded}:${networks}"
done

echo "${networks}"
