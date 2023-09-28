#!/bin/bash

# kill -9 $(pgrep -f ${BASH_SOURCE[0]} | grep -v $$)

WINID=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW)/ {print $NF}' | xargs printf "%#010x\n")

WM_CLASS=$(xprop -id $WINID | awk '/WM_CLASS/ {print $NF}')
WM_CLASS_=${WM_CLASS//\"/}

WM_NAME=$(xprop -id $WINID | awk -vFPAT='("[^"]+")' '/WM_NAME\(STRING)/ {print $NF}')
WM_NAME_=${WM_NAME//\"/}

TERM_PID=$(xprop -id $WINID | awk '/_NET_WM_PID/ {print $NF}')

# notify-send "WINDID: $WINID"
# notify-send "WM_CLASS: $WM_CLASS : $WM_CLASS_"
# notify-send "WM_NAME: $WM_NAME : $WM_NAME : $WM_NAME_"
# notify-send "TERM_PID: $TERM_PID"

choice=""

if [ "$WM_CLASS_" == "Alacritty" ]; then
    if pstree -a -p $TERM_PID | grep -q "nvim"; then
        choice="nvim"
    fi
elif [ "$WM_CLASS_" == "zathura" ] || [ "$WM_CLASS_" == "Zathura" ]; then
    choice="zathura"
elif [ "$WM_CLASS_" == "scrcpy" ] || [ "$WM_CLASS_" == "scrcpy" ]; then
    choice="scrcpy"
elif [ "$WM_CLASS_" == "feh" ] || [ "$WM_CLASS_" == "Feh" ]; then
    choice="feh"
elif [ "$WM_CLASS_" == "code" ] || [ "$WM_CLASS_" == "Code" ]; then
    choice="code"
elif [ "$WM_CLASS_" == "Google-chrome" ] || [ "$WM_CLASS_" == "google-chrome" ]; then
    choice="chrome"
fi

if [ "$choice" == "code" ] || [ "$choice" == "zathura" ]; then
    xdotool keydown ctrl
    n="4"
    xdotool click --repeat "$n" 5
    xdotool keyup ctrl
elif [ "$choice" == "chrome" ]; then
    xdotool keydown alt
    n="2"
    xdotool click --repeat "$n" 5
    xdotool keyup alt
fi
