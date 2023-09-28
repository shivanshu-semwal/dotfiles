#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar according to the wm you are using
DISPLAY_COUNT=$(xrandr -q | grep -c " connected ")
STYLE="$1"

if [ "$DISPLAY_COUNT" = "2" ]; then
    if [ "$DESKTOP_SESSION" = "i3" ]; then
        case "$STYLE" in
            "compact")
                polybar -q main -c "$DIR"/compact.ini &
                polybar -q main2 -c "$DIR"/compact.ini &
                ;;
            "round")
                polybar -q main -c "$DIR"/round.ini &
                polybar -q main2 -c "$DIR"/round.ini &
                ;;
            *)
                echo "Select a style."
                ;;
        esac
    fi
else
    if [ "$DESKTOP_SESSION" = "i3" ]; then
        case "$STYLE" in
            "compact")
                polybar -q main -c "$DIR"/compact.ini &
                ;;
            "round")
                polybar -q main -c "$DIR"/round.ini &
                ;;
            *)
                echo "Select a style."
                ;;
        esac
    fi
fi
