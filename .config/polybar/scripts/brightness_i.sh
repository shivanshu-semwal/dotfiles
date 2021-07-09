#!/usr/bin/env bash

# BRIG=$(xbacklight -get)

# symbols
ramp_0=""
ramp_1=""
ramp_2=""
ramp_3=""
ramp_4=""

BRIG=$($HOME/Scripts/brightness.sh -get)
if [ $BRIG -gt 100 ];then
    echo "?"
elif [ $BRIG -gt 80 ];then
    echo "$ramp_4 $BRIG%"
elif [ $BRIG -gt 60 ];then
    echo "$ramp_3 $BRIG%"
elif [ $BRIG -gt 40 ];then
    echo "$ramp_2 $BRIG%"
elif [ $BRIG -gt 30 ];then
    echo "$ramp_1 $BRIG%"
elif [ $BRIG -gt 0 ];then
    echo "$ramp_0 $BRIG%"
else
    echo "?"
fi