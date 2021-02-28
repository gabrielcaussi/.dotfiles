#!/usr/bin/env sh

if [ "$(playerctl --player=spotify metadata --format "{{ title }} - {{ artist }}" >>/dev/null 2>&1; echo $?)" == "1" ]; then
    echo ""
else
    playerctl --player=spotify metadata --format "{{ title }} - {{ artist }}"
fi

