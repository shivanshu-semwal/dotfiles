#!/bin/bash

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
THEME="$DIR/theme"

rofi \
    -show calc -modi calc \
    -no-show-match -no-sort \
    -theme "$THEME" \
    -hint-welcome "..." \
    -no-sort -calc-command "echo -n '{result}' | xclip -selection clipboard"
