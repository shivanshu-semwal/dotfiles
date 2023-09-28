#!/usr/bin/env bash

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
THEME="$DIR/theme.rasi"
THEME_DRAWER="$DIR/drawer-theme.rasi"

case "$1" in
"drun")
    rofi -matching regex -show drun -theme "$THEME_DRAWER" -show-icons
    ;;
"window")
    rofi -matching regex -show window -theme "$THEME" -show-icons
    ;;
*)
    rofi -matching regex -show drun -theme "$THEME" -show-icons
    ;;
esac
# rofi -matching regex -show drun -modi drun -show-icons
# rofi -no-lazy-grab \
#     -show drun \
#     -modi drun \
#     -disable-history \
#     -drun-display-format "{name} {generic} {exec} {categories} {keywords}" \
#     -drun-match-fields name\
#     -sort
