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

getmutestat(){
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'"$(getdefaultsinkname)"'>"}
            /^\s+muted: / && indefault {print $2; exit}'
        # sed 's/%//'
}

if ! pulseaudio --check; then
    echo "pa X"
else 
    MUTE=$(getmutestat)
    VOL=$(getdefaultsinkvol)

    #  
    vol0=""  
    vol1=""
    vol2=""
    vol3=""


    if [ "$MUTE" = "yes" ];then
        echo "$vol0 Mute"
    elif [ "$VOL" -gt 100 ];then
        echo "? $VOL%"
    elif [ "$VOL" -gt 65 ];then
        echo "$vol3 $VOL%"
    elif [ "$VOL" -gt 30 ];then
        echo "$vol2 $VOL%"
    elif [ "$VOL" -gt -1 ];then
        echo "$vol1 $VOL%"
    else
        echo "?"
    fi
fi