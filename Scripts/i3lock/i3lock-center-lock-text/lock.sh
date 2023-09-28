#!/bin/bash

image=$(mktemp --suffix=.png -t XXXXXXXXXX)
trap 'rm -f "$image"' EXIT

maim -d 0.3 "$image"

convert -filter Gaussian \
    -resize 20% \
    -define "filter:sigma=1.5" \
    -resize 500% \
    "$image" \
    "$image"

convert "$image" \
    -gravity Center \
    -family "Iosevka" \
    -style normal \
    -pointsize 250 \
    -fill White \
    -draw "translate -0,-800 text +0,+700 ''" \
    "$image"

convert "$image" \
    -gravity Center \
    -family "Iosevka" \
    -style normal \
    -pointsize 50 \
    -fill White \
    -draw "translate -0,-800 text +0,+900 'Type password to unlock...'" \
    "$image"

i3lock -i "$image" \
    --inside-color=ffffff1c \
    --ring-color=ffffff3e \
    --line-color=ffffff00 \
    --keyhl-color=00000080 \
    --ringver-color=00000000 \
    --separator-color=22222260 \
    --insidever-color=0000001c \
    --ringwrong-color=00000055 \
    --insidewrong-color=0000001c \
    --verif-color=00000000 \
    --wrong-color=ff000000 \
    --time-color=00000000 \
    --date-color=00000000 \
    --layout-color=00000000
