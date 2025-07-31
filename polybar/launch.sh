#!/bin/bash

# Убиваем все запущенные экземпляры
killall -q polybar

# Ждём завершения
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.5; done

# Запускаем панели на каждом экране



polybar --reload first-bar  &
polybar --reload second-bar &

