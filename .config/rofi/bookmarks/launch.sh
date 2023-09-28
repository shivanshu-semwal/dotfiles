#!/bin/bash

THEME="$HOME/.config/rofi/bookmarks/theme.rasi"
MODE="bookmarks: $HOME/.config/rofi/bookmarks/rofi-bookmarks \"unfiled\" -s \" - \""
rofi \
    -show bookmarks \
    -modi "$MODE" \
    -theme "$THEME" \
    -show-icons
