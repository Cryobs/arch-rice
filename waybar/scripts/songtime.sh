#!/bin/bash

SLEEP_BETWEEN=3
SCROLL_SPEED=0.1

print_line() {
    safe=$(echo "$1" | sed 's/"/\\"/g')
    echo "{\"text\": \"[ $safe ]\"}"
}

while true; do
    song=$(playerctl --player=naviterm metadata --format '{{ artist }} - {{ title }}' 2>/dev/null)
    status=$(playerctl --player=naviterm status 2>/dev/null)

    if [[ "$status" != "Playing" ]]; then
        print_line "$(date +"%A, %b %d, %H:%M:%S")"
        sleep 1
        continue
    fi

    current_time=$(date +"%A, %b %d, %H:%M:%S")
    len=${#current_time}

    for ((i=0; i<=len; i++)); do
        current_time=$(date +"%A, %b %d, %H:%M:%S")
        print_line "${current_time:i}"
        sleep $SCROLL_SPEED
    done

    len=${#song}
    for ((i=1; i<=len; i++)); do
        print_line "${song:0:i}"
        sleep $SCROLL_SPEED
    done

    for ((i=0; i<SLEEP_BETWEEN; i++)); do
        print_line "$song"
        sleep 1
    done

    for ((i=0; i<=len; i++)); do
        print_line "${song:i}"
        sleep $SCROLL_SPEED
    done

    len=${#current_time}
    for ((i=1; i<=len; i++)); do
        current_time=$(date +"%A, %b %d, %H:%M:%S")
        print_line "${current_time:0:i}"
        sleep $SCROLL_SPEED
    done

    for ((i=0; i<SLEEP_BETWEEN; i++)); do
        print_line "$(date +"%A, %b %d, %H:%M:%S")"
        sleep 1
    done
done

