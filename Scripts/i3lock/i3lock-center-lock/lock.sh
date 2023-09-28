#!/bin/bash

# Set the paused status of dunst
dunstctl set-paused true

# set this to the location where the script is
CUR_DIR="$HOME/Scripts/i3lock/i3-center-lock"

image1="$CUR_DIR/wallpaper.png"
image="$CUR_DIR/blurred.png"

# INITIAL OPTIONS
font="VictorMono Nerd Font"
hue=(-level "0%,100%,0.6")
effect=(-filter Gaussian -resize 20% -define "filter:sigma=1.5" -resize 500.5%)
bw="white"
resol="1920x1080"
icon="$CUR_DIR/icons/lock.png"
font_color="#000000"

# choose the lock color
value="60" #brightness value to compare to
# take some part of image and process it to check it's contrast so that we can use either
# black lock or white lock
color=$(convert "$image1" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
    -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}')
if [[ $color -gt $value ]]; then #white background image and black text
    bw="black"
    icon="$CUR_DIR/icons/lockdark.png"
    param=("--insidecolor=0000001c" "--ringcolor=0000003e"
        "--linecolor=00000000" "--keyhlcolor=ffffff80" "--ringvercolor=ffffff00"
        "--separatorcolor=22222260" "--insidevercolor=ffffff1c"
        "--ringwrongcolor=ffffff55" "--insidewrongcolor=ffffff1c"
        "--verifcolor=ffffff00" "--wrongcolor=ff000000" "--timecolor=ffffff00"
        "--datecolor=ffffff00" "--layoutcolor=ffffff00")
    font_color="#000000"
else #black background image and white text
    bw="white"
    icon="$CUR_DIR/icons/lock.png"
    param=("--insidecolor=ffffff1c" "--ringcolor=ffffff3e"
        "--linecolor=ffffff00" "--keyhlcolor=00000080" "--ringvercolor=00000000"
        "--separatorcolor=22222260" "--insidevercolor=0000001c"
        "--ringwrongcolor=00000055" "--insidewrongcolor=0000001c"
        "--verifcolor=00000000" "--wrongcolor=ff000000" "--timecolor=00000000"
        "--datecolor=00000000" "--layoutcolor=00000000")
    font_color="#ffffff"
fi

if [ ! -f "$image" ] || [[ "$1" == "-gen" ]]; then
    echo "Generating the blurred image..."
    convert "$image1" -resize "$resol" "${hue[@]}" "${effect[@]}" -pointsize 26 -fill "$bw" -gravity center \
        "$icon" -gravity center -composite "$image"
fi

i3lock -i "$image" "${param[@]}" --ignore-empty-password \
    --clock \
    --time-color=$font_color \
    --time-str="Type password to unlock" \
    --time-font="$font" \
    --time-size=30 \
    --time-pos="953:700" \
    --verif-font="$font" \
    --verif-size=30 \
    --verif-text="Verifying..." \
    --verif-pos="953:700" \
    --verif-color=$font_color \
    --wrong-font="$font" \
    --wrong-size=30 \
    --wrong-text="Invalid Password" \
    --wrong-pos="953:700" \
    --wrong-color=$font_color \
    --no-modkeytext

# Set the paused status of dunst
dunstctl set-paused false