#!/bin/bash

# Get the window ID of the currently focused window
WINDOW_ID=$(xdotool getwindowfocus)
# zenity --info --text="$WINDOW_ID"
# Get the class name of the window
WINDOW_CLASS=$(xprop -id $WINDOW_ID | grep "WM_CLASS" | awk -F '"' '{print $4}')

# Check if the window class name is 'google-chrome'
if [ "$WINDOW_CLASS" == "Google-chrome" ]; then
  xdotool key ctrl+Tab
  # xdotool windowactivate --sync $WINDOW_ID 
  # sleep 0.2
  # xdotool key ctrl+shift+a
  # xdotool key Return
  # xdotool  --window $WINDOW_ID keydown ctrl
  # xdotool  --window $WINDOW_ID keydown shift
  # xdotool  --window $WINDOW_ID key a
  # xdotool  --window $WINDOW_ID keyup shift
  # xdotool  --window $WINDOW_ID keyup ctrl
  # zenity --info --text="shivanshu"
else
  xdotool key ctrl+Tab
fi

