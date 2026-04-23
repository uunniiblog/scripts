#!/bin/bash

# Look for screen:
# ls /tmp/.X11-unix/
# DISPLAY=:2 xdotool search --name "World of Warcraft"
# Launch with: sh ~/Desktop/wow_key_gamescope.sh :2


# Use the first argument as the display, or default to :1
TARGET_DISPLAY=${1:-":1"}
export DISPLAY=$TARGET_DISPLAY

echo "Targeting Display $DISPLAY..."

# Wait for the window to appear (loop until found)
WIN=""
while [ -z "$WIN" ]; do
    WIN=$(xdotool search --name "World of Warcraft" | tail -1)
    if [ -z "$WIN" ]; then
        echo "WoW not found on $DISPLAY yet... retrying in 5s"
        sleep 5
    fi
done

echo "Found WoW (ID: $WIN) on $DISPLAY. Starting loop..."

while true; do
    # Randomized wait between 1 and 1.5 seconds
    WAIT=$(awk -v min=0.1 -v max=0.5 'BEGIN{srand(); printf "%.2f", min+rand()*(max-min)}')
    echo "Wait ${WAIT}s -> Sending '8'"
    sleep "$WAIT"

    # Send key directly to the window ID
    xdotool key --window "$WIN" "8"

    # Second randomized wait
    WAIT2=$(awk -v min=0.5 -v max=1.5 'BEGIN{srand(); printf "%.2f", min+rand()*(max-min)}')
    sleep "$WAIT2"

    xdotool key --window "$WIN" "8"
done
