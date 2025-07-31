#!/usr/bin/env bash

STATE_FILE="/tmp/polybar-wifi-full"

# Переключение режима отображения
if [[ "$1" == "--toggle" ]]; then
    if [[ -f "$STATE_FILE" ]]; then
        rm "$STATE_FILE"
    else
        touch "$STATE_FILE"
    fi
    exit 0
fi

# Получение данных
ESSID=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes:' | cut -d: -f2)
SIG=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^\*:' | cut -d: -f2)
SIG=${SIG:-0}

# Выбор иконки по уровню сигнала
if   (( SIG >= 80 )); then ICON="󰤨"
elif (( SIG >= 60 )); then ICON="󰤥"
elif (( SIG >= 40 )); then ICON="󰤢"
elif (( SIG >= 20 )); then ICON="󰤟"
else                       ICON="󰤯"
fi

# Вывод
if [[ -f "$STATE_FILE" ]]; then
    if [[ -n "$ESSID" ]]; then
        echo "$ICON $ESSID"
    else
        echo "$ICON (off)"
    fi
else
    echo "$ICON"
fi

