#!/bin/bash

INTERFACE="proton"

if ip link show "$INTERFACE" &>/dev/null; then
    echo "  "
else
    echo "  󰅛  "
fi

