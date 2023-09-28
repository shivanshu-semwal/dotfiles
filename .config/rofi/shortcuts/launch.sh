#!/bin/bash

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
THEME=$DIR/theme.rasi
THEME_SHORTCUTS=$DIR/theme-shortcuts.rasi
SOURCES=$DIR/src

WINID=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW)/ {print $NF}' | xargs printf "%#010x\n")
WM_CLASS=$(xprop -id "$WINID" | awk '/WM_CLASS/ {print $NF}')
WM_CLASS_=${WM_CLASS//\"/}
WM_NAME=$(xprop -id "$WINID" | awk -vFPAT='("[^"]+")' '/WM_NAME\(STRING)/ {print $NF}')
WM_NAME_=${WM_NAME//\"/}
TERM_PID=$(xprop -id "$WINID" | awk '/_NET_WM_PID/ {print $NF}')

# echo "WINDID: $WINID"
# echo "WM_CLASS: $WM_CLASS : $WM_CLASS_"
# echo "WM_NAME: $WM_NAME : $WM_NAME : $WM_NAME_"
# echo "TERM_PID: $TERM_PID"

choice=""

# Detect the choice made

if [ "$WM_CLASS_" == "Alacritty" ]; then
    if pstree -a -p "$TERM_PID" | grep -q "nvim"; then
        choice="nvim"
    fi
elif [ "$WM_CLASS_" == "zathura" ] || [ "$WM_CLASS_" == "Zathura" ]; then
    choice="zathura"
elif [ "$WM_CLASS_" == "scrcpy" ] || [ "$WM_CLASS_" == "scrcpy" ]; then
    choice="scrcpy"
elif [ "$WM_CLASS_" == "feh" ] || [ "$WM_CLASS_" == "Feh" ]; then
    choice="feh"
fi

# Unable to detect chice

[ -z "$choice" ] && choice=$(ls -1 "$SOURCES" | rofi -theme "$THEME" -dmenu -i -p " ")
[ -z "$choice" ] && exit 1

# preprocessing for certaion apps
if [[ $choice == "i3" ]]; then
    [[ ! -f "$HOME/.config/i3/config" ]] && exit
    # grep ^bindsym "$HOME/.config/i3/config" |
    #     sed 's/\s/\x00/2' | sed ':a; N; $!ba; s/\n/\x0f/g' |  sed 's/\x00/\n/g' | sed 's/bindsym //' | sed 's/ --no-startup-id //' |
    #     sed 's/$mod/ /' | sed 's/exec//' | sed 's/--release //' | sed 's/  */ /g' | sed 's/+/ + /' |
    #     rofi -markup-rows -dmenu -p "i3" -i -eh 2 -sep '\x0f' -theme "$THEME"
    grep ^bindsym "$HOME/.config/i3/config" | sed 's/bindsym //' | sed 's/ --no-startup-id //' | sed 's/exec//' | sed 's/--release //' |
        sed 's/$mod_next/Alt/' | sed 's/$mod/Win/' |
        awk '{printf "%-25s :: ", $1}{for(i=2; i<=NF; ++i) printf "%s ", $i; print ""}' >"$SOURCES/i3"
fi

# displaying shortcuts
if [[ -d "$SOURCES/$choice" ]]; then
    # it will have more files
    ITEMS=$(ls -1 "$SOURCES/$choice")
    choice2=$(echo "$ITEMS" | rofi --markup-rows -theme "$THEME_SHORTCUTS" -dmenu -i -p "$choice")
    cat <"$SOURCES/$choice/$choice2" |
        awk -F '::' '{printf "%-40s %s", $1, $2; print ""}' |
        rofi -theme "$THEME_SHORTCUTS" -dmenu -i -p "$choice:$choice2"
elif [[ -f "$SOURCES/$choice" ]]; then
    cat <"$SOURCES/$choice" |
        awk -F '::' '{printf "%-40s %s", $1, $2; print ""}' |
        rofi -theme "$THEME_SHORTCUTS" -dmenu -i -p "$choice"
else
    exit
fi

# a try to style
# cat <"$SOURCES"/feh | sed 's|"|\"|g' | sed 's|<|\&lt;|g' | sed 's|>|\&gt;|g' |
# awk -F '::' '{printf "<span foreground=\"#e06c75\" font_weight=\"bold\">%-40s</span> %s", $1, $2; print ""}' |
# rofi -markup-rows -theme "$THEME" -dmenu -i -p "feh"
# ;;
# this will make the indentaion bad, as &lt; is only one character, and for marup rows you have to escape those
# better stick with plain text
