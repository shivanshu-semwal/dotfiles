#!/bin/bash

# THEME=$HOME/.config/rofi/shortcuts/themes/onedark.rasi
THEME="$HOME/.config/rofi/rofi-themes/User Themes/onedark.rasi"

declare -a options=(
    "time table"
    "dunst - restart"
    "dunst - toggle visibility"
    "picom - kill"
    "picom - restart"
)

choice=$(printf '%s\n' "${options[@]}" |
    rofi -theme "$THEME" -dmenu -p "select")

case $choice in
"dunst - restart")
    notify-send 'restart dunst'
    # ~/Scripts/wallpaper.sh
    ;;
"notify-send 'DUNST_COMMAND_TOGGLE'")
    ~/Scripts/firefox/tabs.sh -save
    ;;
"picom - kill")
    pkill picom
    ;;
"picom - restart")
    killall -qw picom
    picom -b
    ;;
"time table")
    feh ~/Pictures/time_table.jpeg --title timetable
    ;;
*)
    exit 1
    ;;
esac
