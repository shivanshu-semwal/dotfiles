#!/bin/bash

IMAGE="./image/1.png"
WIDTH=1920
HEIGHT=1080
IMAGE_WIDTH=$(identify -format "%[fx:w]" $IMAGE)
IMAGE_HEIGHT=$(identify -format "%[fx:h]" $IMAGE)

X=$(( WIDTH/2 - IMAGE_WIDTH/2 ))
Y=$(( HEIGHT/2 - IMAGE_HEIGHT/2 ))
XX=$(( IMAGE_WIDTH / 2 ))
YY=$(( IMAGE_HEIGHT / 2 ))

echo "<span size=\"xx-large\">$(date +'%I:%M %p')</span>"  | 
    xcowsay \
        --think \
        --debug \
        -f "Chilanka" \
        -l \
        --at=$X,$Y \
        --bubble-at=0,0 \
        --image $IMAGE
