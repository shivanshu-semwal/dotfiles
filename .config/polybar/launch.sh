#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar according to the wm you are using
t=$(xrandr -q | grep -c " connected ")
if [ "$t" = "2" ] && [ "$DESKTOP_SESSION" = "i3" ]; then
    # launch two bars
    echo "Launching two Polybar for i3 dual monitor."
    polybar -q main -c "$DIR"/config.ini &
    polybar -q main2 -c "$DIR"/config2.ini &
elif [ "$DESKTOP_SESSION" = "i3" ];then
    echo "Launching Polybar for i3."
    polybar -q main -c "$DIR"/config.ini &
elif [ "$DESKTOP_SESSION" = "openbox" ];then
    echo "Launching Polybar for openbox single monitor."
    polybar -q main -c "$DIR"/config_openbox.ini &
elif [ "$DESKTOP_SESSION" = "bspwm" ];then
    echo "Launching Ppolybar for bspwm single mpnitor"
    polybar -q main -c "$DIR"/config_bspwm.ini &
fi