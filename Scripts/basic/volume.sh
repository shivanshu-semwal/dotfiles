#!/bin/bash

getdefaultsinkname() {
    pacmd stat | awk -F": " '/^Default sink name: /{print $2}'
}

getdefaultsinkvol() {
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'"$(getdefaultsinkname)"'>"}
            /^\s+volume: / && indefault {print $5; exit}' |
        sed 's/%//'
}

getmutestat() {
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'"$(getdefaultsinkname)"'>"}
            /^\s+muted: / && indefault {print $2; exit}'
}

setdefaulsinkvol() {
    pactl set-sink-volume "$(getdefaultsinkname)" $1
}

if ! pulseaudio --check; then
    echo "Puseaudio Inactive"
    exit
fi

MUTE=$(getmutestat)
VOL=$(getdefaultsinkvol)
DIR="$HOME/Scripts/basic/icons"

case "$1" in
-inc)
    if [ "$MUTE" = "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    fi
    if [ $VOL -lt 100 ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +1%
        ((NEWVOL = $VOL + 1))
        if [ $VOL -gt 70 ]; then
            notify-send "Increase " "Volume: " \
                -h int:value:$NEWVOL \
                -h string:synchronous:volume \
                -i $DIR/volume_up.svg
        elif [ $VOL -gt 40 ]; then
            notify-send "Increase " "Volume: " \
                -h int:value:$NEWVOL \
                -h string:synchronous:volume \
                -i $DIR/volume_down.svg
        else
            notify-send "Increase " "Volume: " \
                -h int:value:$NEWVOL \
                -h string:synchronous:volume \
                -i $DIR/volume_mute.svg
        fi
    fi
    ;;
-dec)
    if [ "$MUTE" = "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    fi
    pactl set-sink-volume @DEFAULT_SINK@ -1%
    ((NEWVOL = $VOL + 1))
    if [ $VOL -gt 70 ]; then
        notify-send "Decrease " "Volume: " \
            -h int:value:$NEWVOL \
            -h string:synchronous:volume \
            -i $DIR/volume_up.svg
    elif [ $VOL -gt 40 ]; then
        notify-send "Decrease " "Volume: " \
            -h int:value:$NEWVOL \
            -h string:synchronous:volume \
            -i $DIR/volume_down.svg
    else
        notify-send "Decrease " "Volume: " \
            -h int:value:$NEWVOL \
            -h string:synchronous:volume \
            -i $DIR/volume_mute.svg
    fi
    ;;
-mute)
    if [ "$MUTE" = "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        if [ $VOL -gt 70 ]; then
            notify-send "Unmute " "Volume: " \
                -h int:value:$VOL \
                -h string:synchronous:volume \
                -i $DIR/volume_up.svg
        elif [ $VOL -gt 40 ]; then
            notify-send "Unmute " "Volume: " \
                -h int:value:$VOL \
                -h string:synchronous:volume \
                -i $DIR/volume_down.svg
        else
            notify-send "Unmute " "Volume: " \
                -h int:value:$VOL \
                -h string:synchronous:volume \
                -i $DIR/volume_mute.svg
        fi
    else 
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        notify-send "Mute " "Volume: " \
                -h int:value:0 \
                -h string:synchronous:volume \
                -i $DIR/volume_off.svg
    fi
    ;;
*)
    exit 1
    ;;
esac
