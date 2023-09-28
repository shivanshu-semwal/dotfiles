#!/usr/bin/env bash

# get the location of dir where script is in
DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
THEME="$DIR/theme.rasi"
THEME_MSG="$DIR/theme-msg.rasi"

# Options
SHUTDOWN="⏻  Shutdown"
REBOOT="  Reboot"
LOCK="  Lock"
SUSPEND="  Susped"
LOGOUT="󰗽  Logout"
yes='󰄲 Yes'
no='  No'

# Ask for confirmation
confirm_exit() {
    echo -e "$yes\n$no" | rofi -dmenu -p 'Confirmation' -mesg 'Are you Sure?' -theme "$THEME_MSG"
}

uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)
user=$(whoami)

# Variable passed to rofi
options="$SHUTDOWN\n$REBOOT\n$LOCK\n$SUSPEND\n$LOGOUT"
chosen="$(echo -e "$options" | rofi -theme "$THEME" -p "$user@$host" -dmenu -selected-row 2 -mesg "Uptime: $uptime")"

case $chosen in
"$SHUTDOWN")
    ans=$(confirm_exit &)
    [[ $ans == "$yes" ]] && systemctl poweroff
    ;;
"$REBOOT")
    ans=$(confirm_exit &)
    [[ $ans == "$yes" ]] && systemctl reboot
    ;;
"$LOCK")
    if [[ -f $HOME/Scripts/i3lock/launch.sh ]]; then
        "$HOME/Scripts/i3lock/launch.sh"
        if [ $? -ne 0 ]; then
            i3lock
        fi
    elif [[ -f /usr/bin/i3lock ]]; then
        i3lock
    elif [[ -f /usr/bin/betterlockscreen ]]; then
        betterlockscreen -l
    fi
    ;;
"$SUSPEND")
    ans=$(confirm_exit &)
    if [[ $ans == "$yes" ]]; then
        mpc -q pause
        amixer set Master mute
        systemctl suspend
    fi
    ;;
"$LOGOUT")
    ans=$(confirm_exit &)
    if [[ $ans == "$yes" ]]; then
        loginctl terminate-session "$(loginctl session-status | awk 'NR==1{print $1}')"
    fi
    ;;
esac
