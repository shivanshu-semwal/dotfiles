#!/bin/bash

image1="$HOME/Scripts/i3lock/i3-blur/s.jpg"

# font="VictorMono Nerd Font"
# font=$(convert -list font | awk "{ a[NR] = \$2 } /family: $(fc-match sans -f "%{family}\n")/ { print a[NR-1]; exit }")
hue=(-level "0%,100%,0.6")
effect=(-filter Gaussian -resize 20% -define "filter:sigma=1.5" -resize 500.5%)
bw="white"
resol="1920x1080"
icon="$HOME/Scripts/i3lock/i3-blur/icons/lock.png"
font_color="#000000"

image="$HOME/Scripts/i3lock/i3-blur/ss.jpg"

# choose the lock color
value="60" #brightness value to compare to
color=$(convert "$image" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
    -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}')
if [[ $color -gt $value ]]; then #white background image and black text
    bw="black"
    icon="$HOME/Scripts/i3lock/i3-blur/icons/lockdark.png"
    param=("--insidecolor=0000001c" "--ringcolor=0000003e"
        "--linecolor=00000000" "--keyhlcolor=ffffff80" "--ringvercolor=ffffff00"
        "--separatorcolor=22222260" "--insidevercolor=ffffff1c"
        "--ringwrongcolor=ffffff55" "--insidewrongcolor=ffffff1c"
        "--verifcolor=ffffff00" "--wrongcolor=ff000000" "--timecolor=ffffff00"
        "--datecolor=ffffff00" "--layoutcolor=ffffff00")
    font_color="#000000"
else #black
    bw="white"
    icon="$HOME/Scripts/i3lock/i3-blur/icons/lock.png"
    param=("--insidecolor=ffffff1c" "--ringcolor=ffffff3e"
        "--linecolor=ffffff00" "--keyhlcolor=00000080" "--ringvercolor=00000000"
        "--separatorcolor=22222260" "--insidevercolor=0000001c"
        "--ringwrongcolor=00000055" "--insidewrongcolor=0000001c"
        "--verifcolor=00000000" "--wrongcolor=ff000000" "--timecolor=00000000"
        "--datecolor=00000000" "--layoutcolor=00000000")
    font_color="#ffffff"
fi

# convert "$image1" -resize "$resol" "${hue[@]}" "${effect[@]}" -font "$font" -pointsize 26 -fill "$bw" -gravity center \
# -annotate +0+160 "$text" "$icon" -gravity center -composite "$image"

convert "$image1" -resize "$resol" "${hue[@]}" "${effect[@]}" -pointsize 26 -fill "$bw" -gravity center \
    "$icon" -gravity center -composite "$image"

i3lock -i "$image" "${param[@]}" --ignore-empty-password \
    --clock \
    --timecolor=$font_color \
    --timestr="Type password to unlock" \
    --time-font="VictorMono Nerd Font" \
    --timesize=30 \
    --timepos="953:700" \
    --verif-font="VictorMono Nerd Font" \
    --verifsize=30 \
    --veriftext="Verifying..." \
    --verifpos="953:700" \
    --verifcolor=$font_color \
    --wrong-font="VictorMono Nerd Font" \
    --wrongsize=30 \
    --wrongtext="Invalid Password" \
    --wrongpos="953:700" \
    --wrongcolor=$font_color \
    --no-modkeytext
