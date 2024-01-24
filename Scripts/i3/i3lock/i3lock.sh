#!/usr/bin/env bash

#---------------
# i3lock-color
#---------------

# colors used

B='#00000000' # center background
C='#ffffff22' # center background verif
T='#5E81ACff' # center text
D='#88C0D0ff' # default ring
I='#5E81ACff' # indicator
W='#EBCB8Bff' # wrong ring + indicator
V='#88C0D0ff' # verif ring

#----------------
# how to change fonts
# --{time, date, layout, verif, wrong, greeter}-font=sans-serif
#----------------

# font to use
# FONT="VictorMono Nerd Font"
# FONT="monofur"
FONT="IosevkaTerm Nerd Font"

i3lock \
    -c 2E3440 \
    --insidever-color=$C \
    --ringver-color=$V \
    \
    --insidewrong-color=$C \
    --ringwrong-color=$W \
    \
    --ring-color=$D \
    --line-color=$T \
    --separator-color=$D \
    \
    --inside-color=$B \
    --verif-color=$T \
    --wrong-color=$T \
    --time-color=$T \
    --date-color=$T \
    --layout-color=$T \
    --keyhl-color=$I \
    --bshl-color=$I \
    \
    --clock \
    --indicator \
    --time-str="%I:%M %p" \
    --date-str="%A, %m %Y" \
    \
    --verif-text="Verifying..." \
    --wrong-text="Nope!" \
    \
    --date-font="$FONT" \
    --time-font="$FONT" \
    --layout-font="$FONT" \
    --verif-font="$FONT" \
    --wrong-font="$FONT" \
    --greeter-font="$FONT" \
    \
    --date-size=30 \
    --time-size=40 \
    --layout-size=40 \
    --verif-size=40--wrongsize=40 \
    --greeter-size=40 \
    \
    --radius=200
