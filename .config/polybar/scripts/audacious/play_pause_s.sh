#!/usr/bin/env bash

if pgrep -x "audacious" >/dev/null; then
    vol=$(audtool --get-volume)
    if [ "$(audtool playback-status)" = "playing" ]; then
        echo " $vol%"
    elif [ "$(audtool playback-status)" = "paused" ]; then
        echo "ﱙ NP"
    fi
elif pgrep -x "cmus" >/dev/null; then
    vol=$(cmus-remote -Q | grep "^set vol_left" | cut -d' ' -f3)
    if [ "$(cmus-remote -Q | grep ^status | cut -d' ' -f2)" = "playing" ]; then
        echo " $vol%"
    else
        echo "ﱙ NP"
    fi
else
    echo "ﱙ NA"
fi