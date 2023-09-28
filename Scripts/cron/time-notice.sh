#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/$(id -u)
notify-send "Time: $(date +'%I:%M %p')" "$(fortune -a computers -a linux -s)" -i clock
echo "$(date +'%I:%M %p')" | flite
