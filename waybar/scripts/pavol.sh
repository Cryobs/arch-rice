#!/bin/bash

vol=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

icon=" "
if [[ "$vol" -gt 30 ]]; then icon=" "; fi
if [[ "$vol" -gt 70 ]]; then icon=" "; fi

bar=""
filled=$((vol / 10))
empty=$((10 - filled))

for ((i=0; i<filled; i++)); do bar+="▓"; done
for ((i=0; i<empty; i++)); do bar+="▒"; done

if [[ "$mute" == "true" ]]; then
  echo "[    muted ]"
else
  echo "[  $icon [$bar] ${vol}% ]"
fi

