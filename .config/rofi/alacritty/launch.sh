#!/usr/bin/env bash

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
THEME="$DIR/theme.rasi"
THEMES="$HOME/.config/alacritty/themes"

declare -a options=(
    "  Change padding"
    "  Change Font"
    "  Change Opacity"
    "  Change color scheme"
    "  Profile 1"
    "  Profile 2"
)

declare -a fonts=(
    "Hack"
    "Iosevka Nerd Font"
    "JetBrainsMono Nerd Font"
    "VictorMono Nerd Font"
)

declare -a paddings=(
    "0"
    "10"
    "20"
    "40"
    "60"
)

declare -a opacities=(
    "0.0"
    "0.2"
    "0.4"
    "0.5"
    "0.6"
    "0.8"
    "1.0"
)

font() {
    FONT=$(printf '%s\n' "${fonts[@]}" | rofi -theme "$THEME" -dmenu -p " ")
    if [ -n "$FONT" ]; then
        alacritty-conf -f "$FONT"
    fi
}

padding() {
    PADDING=$(printf '%s\n' "${paddings[@]}" | rofi -theme "$THEME" -dmenu -p " ")
    if [ -n "$PADDING" ]; then
        alacritty-conf -p "$PADDING"
    fi
}

opacity() {
    OPACITY=$(printf '%s\n' "${opacities[@]}" | rofi -theme "$THEME" -dmenu -p " ")
    if [ -n "$OPACITY" ]; then
        alacritty-conf -o "$OPACITY"
    fi
}

color-scheme() {
    COLOR_SCHEME=$('ls' -1 $THEMES | sed -e 's|.yml||' -e 's|.yaml||' | rofi -theme "$THEME" -dmenu -p " ")
    alacritty-conf -c "$COLOR_SCHEME"
}

main() {

    # Get choice from rofi
    choice=$(printf '%s\n' "${options[@]}" | rofi -fixed-num-lines 6 -dmenu -i -fuzzy -p " " -theme "$THEME")

    # If user has not picked anything, exit
    if [[ -z "${choice// /}" ]]; then
        exit 1
    fi

    # run the selected command
    case $choice in
    "${options[0]}")
        padding
        exit 0
        ;;
    "${options[1]}")
        font
        exit 0
        ;;
    "${options[2]}")
        opacity
        exit 0
        ;;
    "${options[3]}")
        color-scheme
        exit 0
        ;;
    "${options[4]}")
        alacritty-conf -f "Iosevka Nerd Font" -c "gruvbox_dark" -p 40 -o 1
        exit 0
        ;;
    "${options[5]}")
        alacritty-conf -f "JetBrainsMono Nerd Font" -c "one_dark" -p 40 -o 1
        exit 0
        ;;

    esac
}

main
exit 0
