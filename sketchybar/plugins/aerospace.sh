#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

LOG_FILE="$HOME/.config/sketchybar/plugins/aerospace.log"

echo "Running aerospace.sh with arguments: $@" >> $LOG_FILE

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME background.drawing=off
fi