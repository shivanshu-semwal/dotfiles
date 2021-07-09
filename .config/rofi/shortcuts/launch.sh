#!/bin/bash

THEME=$HOME/.config/rofi/shortcuts/themes/onedark.rasi
THEME1=$HOME/.config/rofi/shortcuts/themes/onedark_small.rasi
# THEME="$HOME/.config/rofi/rofi-themes/User Themes/onedark.rasi"
SOURCES=$HOME/.config/rofi/shortcuts/src

# add more programs
declare -a options=(
    "nvim"
    "i3"
    "zathura"
    "feh"
)

choice=$(printf '%s\n' "${options[@]}" |
    sed 's/^/* /' |
    rofi -theme "$THEME1" -dmenu -p "select")


if [ "$choice" == "* i3" ]; then
    if [ ! -f "$HOME/.config/i3/config" ]; then
        exit
    fi
    grep ^bindsym "$HOME/.config/i3/config" |
        sed 's/\s/\t\t\t/2' |
        sed 's/bindsym //' |
        sed 's/ --no-startup-id //' |
        sed 's/$mod//' |
        sed 's/exec//' |
        sed 's/--release //' |
        sed 's/+/ + /' |
        rofi -theme "$THEME" -dmenu -p "i3"

elif [ "$choice" == "* zathura" ]; then
    cat <"$SOURCES"/zathura | sed 's/^/* /' | sed 's/->/ /' |
        rofi -theme "$THEME" -dmenu -p "zathura"
elif [ "$choice" == "* feh" ]; then
    cat <"$SOURCES"/feh |
        rofi -theme "$THEME" -dmenu -p "feh"
elif [ "$choice" == "* nvim" ]; then
    cat <"$SOURCES"/nvim |
        rofi -theme "$THEME" -dmenu -p "feh"
fi
