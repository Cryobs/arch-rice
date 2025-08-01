#!/bin/bash

INTERFACE="proton"

if ip link show "$INTERFACE" &>/dev/null; then
    sudo /usr/bin/wg-quick down "$INTERFACE"
else
    sudo /usr/bin/wg-quick up "$INTERFACE"
fi

