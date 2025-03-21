#!/bin/bash

COUNTER_FILE="/tmp/screenshot_counter.txt"

if [ -f "$COUNTER_FILE" ]; then
    COUNTER=$(cat "$COUNTER_FILE")
else
    COUNTER=1
fi

maim --select "$HOME/Pictures/Screenshot/$(date +%Y%m%d_%H%M)$COUNTER.png"

xclip -selection clipboard -t image/png -i "$HOME/Pictures/Screenshot/$(date +%Y%m%d_%H%M)$COUNTER.png"

echo $((COUNTER + 1)) > "$COUNTER_FILE"

