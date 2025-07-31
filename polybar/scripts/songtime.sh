#!/bin/bash

SLEEP_BETWEEN=3     # Сколько секунд показывать полностью
SCROLL_SPEED=0.1   # Скорость анимации

print_line() {
    echo "[ $1 ]"
}

while true; do
    song=$(playerctl --player=naviterm metadata --format '{{ artist }} - {{ title }}' 2>/dev/null)
    status=$(playerctl --player=naviterm status 2>/dev/null)

    if [[ "$status" != "Playing" ]]; then
        # Музыка не играет — живое время
        print_line "$(date +"%A, %b %d, %H:%M:%S")"
        sleep 1
        continue
    fi

    # Фаза 1: Уход времени влево
    current_time=$(date +"%A, %b %d, %H:%M:%S")
    len=${#current_time}
    for ((i=0; i<=len; i++)); do
        current_time=$(date +"%A, %b %d, %H:%M:%S")  # Обновляем каждый шаг
        print_line "${current_time:i}"
        sleep $SCROLL_SPEED
    done

    # Фаза 2: Появление песни
    len=${#song}
    for ((i=1; i<=len; i++)); do
        print_line "${song:0:i}"
        sleep $SCROLL_SPEED
    done

    # Показать песню немного
    for ((i=0; i<SLEEP_BETWEEN; i++)); do
        print_line "$song"
        sleep 1
    done

    # Фаза 3: Уход песни влево
    len=${#song}
    for ((i=0; i<=len; i++)); do
        print_line "${song:i}"
        sleep $SCROLL_SPEED
    done

    # Фаза 4: Появление времени
    current_time=$(date +"%A, %b %d, %H:%M:%S")
    len=${#current_time}
    for ((i=1; i<=len; i++)); do
        current_time=$(date +"%A, %b %d, %H:%M:%S")  # Обновляем каждый шаг
        print_line "${current_time:0:i}"
        sleep $SCROLL_SPEED
    done

    # Показать время немного
    for ((i=0; i<SLEEP_BETWEEN; i++)); do
        print_line "$(date +"%A, %b %d, %H:%M:%S")"
        sleep 1
    done
done

