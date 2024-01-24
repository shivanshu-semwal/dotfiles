#!/bin/bash

CONFIG="$HOME/Scripts/dmenu/config"
[ -f "$CONFIG" ] && . $CONFIG || DMENU='dmenu -i'

SONG_DIR="/media/totoro/Data/Music/SoundTracks/"

LOCATION="/media/totoro/Data/eBooks/formal-science/computer-science/cheat-sheets"

var1=$(find $LOCATION -type f)
var1=$(echo -e "$random_song\n$var1" | sed "s+$SONG_DIR++" | eval "$DMENU -p ' '")

[ -n "$var1" ] && audacious "$SONG_DIR/$var1"
