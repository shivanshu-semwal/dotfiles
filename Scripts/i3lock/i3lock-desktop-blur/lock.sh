#!/usr/bin/env bash

# Tested on two monitors

# Set the paused status of dunst
dunstctl set-paused true

CWD="$HOME/Scripts/i3lock/i3lock-desktop-blur"
LIGHT_LOCK="$CWD/icons/lock.png"
DARK_LOCK="$CMD/icons/lockdark.png"
FONT="Iosevka-Nerd-Font-Complete"
TEXT="Type password to unlock"
IMG=$(mktemp --suffix=.png -t XXXXXXXXXX)
NO_OF_SCREENS=$(xrandr -q | grep -c " connected ")

i3lock_cmd=(i3lock -i "$IMG")
trap 'rm -f "$IMG"' EXIT
maim -d 0.3 "$IMG" # Take Screenshot of desktop

# decide which lock to use - white or black
VALUE="60" # brightness value to compare to
COLOR=$(
    convert "$IMG" \
        -gravity center \
        -crop 100x100+0+0 +repage \
        -colorspace hsb \
        -resize 1x1 txt:- |
        awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}'
)

BLACK="00000000"
WHITE="ffffff00"
RED="ff000000"

if [[ $COLOR -gt $VALUE ]]; then # white background image and black text
    TEXT_COLOR="black"
    LOCK_ICON="$DARK_LOCK"
    param=(
        "--inside-color=0000001c"
        "--ring-color=0000003e"
        "--line-color=$BLACK"
        "--keyhl-color=ffffff80"
        "--ringver-color=$WHITE"
        "--separator-color=22222260"
        "--insidever-color=ffffff1c"
        "--ringwrong-color=ffffff55"
        "--insidewrong-color=ffffff1c"
        "--verif-color=$WHITE"
        "--wrong-color=$RED"
        "--time-color=$WHITE"
        "--date-color=$WHITE"
        "--layout-color=$WHITE"
    )
else # black background image and white text
    TEXT_COLOR="white"
    LOCK_ICON="$LIGHT_LOCK"
    param=(
        "--inside-color=ffffff1c"
        "--ring-color=ffffff3e"
        "--line-color=$WHITE"
        "--keyhl-color=00000080"
        "--ringver-color=$BLACK"
        "--separator-color=22222260"
        "--insidever-color=0000001c"
        "--ringwrong-color=00000055"
        "--insidewrong-color=0000001c"
        "--verif-color=$BLACK"
        "--wrong-color=$RED"
        "--time-color=$BLACK"
        "--date-color=$BLACK"
        "--layout-color=$BLACK"
    )
fi

# blur screenshot and add text

if [ "$NO_OF_SCREENS" = "2" ]; then
    convert "$IMG" \
        -level "0%,100%,0.6" \
        -resize 20% \
        -blur 0x1.5 \
        -define "filter:sigma=1.5" \
        -resize 500.5% \
        -font "$FONT" -pointsize 26 -fill "$TEXT_COLOR" -annotate +817+700 "$TEXT" \
        "$LOCK_ICON" -geometry '+932+510' -composite \
        -font "$FONT" -pointsize 26 -fill "$TEXT_COLOR" -annotate +2737+700 "$TEXT" \
        "$LOCK_ICON" -geometry '+2851+510' -composite \
        "$IMG"
else
    convert "$IMG" \
        -level "0%,100%,0.6" \
        -resize 20% \
        -blur 0x1.5 \
        -define "filter:sigma=1.5" \
        -resize 500.5% \
        -font "$FONT" -pointsize 26 -fill "$TEXT_COLOR" -gravity center -annotate +0+160 "$TEXT" \
        "$LOCK_ICON" -gravity center -composite \
        "$IMG"
fi

# run lock
"${i3lock_cmd[@]}" "${param[@]}"

# Set the paused status of dunst
dunstctl set-paused false
