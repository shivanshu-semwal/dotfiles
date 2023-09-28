#!/bin/bash
[ -f "$HOME/.dmenurc" ] && . $HOME/.dmenurc || DMENU='dmenu -i'
DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
THEME="$DIR/theme.rasi"

DUNST_RESTART="  Restart"
DUNST_TOGGLE_VISIBILITY="  Toggle visibility"
PICOM_KILL="  Stop"
PICOM_RESTART="  Restart"
FIREFOX_SAVE_TABS="  Save tabs"
GET_FONTS_LIST="  Get fonts list"
FEH_SLIDESHOW="  Slideshow"

print_options() {
    echo "$DUNST_RESTART"
    echo "$DUNST_TOGGLE_VISIBILITY"
    echo "$PICOM_RESTART"
    echo "$PICOM_KILL"
    echo "$FIREFOX_SAVE_TABS"
    echo "$GET_FONTS_LIST"
    echo "$FEH_SLIDESHOW"
}

DUNST_STATUS=""
if pgrep "dunst" >/dev/null; then
    case $(dunstctl is-paused) in
    false)
        DUNST_STATUS="RUNNING"
        ;;
    true)
        DUNST_STATUS="PAUSED"
        ;;
    esac
else
    DUNST_STATUS="DEAD"
fi

PICOM_STATUS=""
if pgrep "dunst" >/dev/null; then
    PICOM_STATUS="RUNNING"
else
    PICOM_STATUS="DEAD"
fi

MESSAGE="  $DUNST_STATUS |   $PICOM_STATUS"
choice=$(print_options | rofi -dmenu -p " " -theme "$THEME" -mesg "$MESSAGE")
[ -z "$choice" ] && exit

case $choice in
"$FIREFOX_SAVE_TABS")
    FILE="/media/totoro/Data/Documents/notes/open-tabs.md"
    firefox-open-tabs >>"$FILE"
    ;;
"$GET_FONTS_LIST")
    font_get=$(fc-list | cut -d':' -f2- | cut -c 2- | eval "$DMENU -p ' '")
    echo "$font_get" | tr -d '\n' | xclip -sel clip
    ;;
"$DUNST_RESTART")
    if pgrep -x "dunst" >/dev/null; then
        pkill dunst
        dunst
    else
        dunst
    fi
    ;;
"$DUNST_TOGGLE_VISIBILITY")
    if pgrep -x "dunst" >/dev/null; then
        dunstctl set-paused toggle
    else
        dunst
    fi
    ;;
"$PICOM_KILL")
    pkill picom
    ;;
"$PICOM_RESTART")
    killall -qw picomDUNST_TOGGLE_VISIBILTIY
    picom -b
    ;;
"$FEH_SLIDESHOW")
    DIRC="$HOME/Pictures/Wallpapers"
    feh -r "$DIRC" \
        -z \
        -D 4 \
        --class wallpaper \
        -g 1000x562 -. \
        -B "#282c33" \
        --zoom fill
    ;;
*)
    exit 1
    ;;
esac
