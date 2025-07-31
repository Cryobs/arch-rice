#!/bin/bash

cava -p ~/.config/polybar/scripts/cava-config | \
while read -r line; do
    # Заменяем ; на пробел и убираем последнюю ;
    line="${line//;/ }"
    bars=($line)

    output=""
    for value in "${bars[@]}"; do
        # Проверка, что это число
        if [[ "$value" =~ ^[0-9]+$ ]]; then
            if [ "$value" -lt 50 ]; then
                char=" "  # Новый уровень
            elif [ "$value" -lt 100 ]; then
                char="▁"
            elif [ "$value" -lt 200 ]; then
                char="▂"
            elif [ "$value" -lt 250 ]; then
                char="▃"
            elif [ "$value" -lt 300 ]; then
                char="▄"
            elif [ "$value" -lt 350 ]; then
                char="▅"
            elif [ "$value" -lt 400 ]; then
                char="▆"
            elif [ "$value" -lt 600 ]; then
                char="▇"
            elif [ "$value" -lt 800 ]; then
                char="█"
            else
                char="█"  # Самый высокий уровень
            fi
            output+="$char"
        fi
    done

    if playerctl --player=naviterm status &>/dev/null && playerctl --player=naviterm status | grep -q Playing; then
        echo "[ $output ]"
    else
        echo ""
    fi
done
