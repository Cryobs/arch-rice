#!/bin/bash
pkill -x wofi
# Небольшая пауза, чтобы процессы успели завершиться
sleep 0.2
# Запускаем wofi в фоне
setsid wofi --show drun --style ~/.config/wofi/style.css > /dev/null 2>&1 &

