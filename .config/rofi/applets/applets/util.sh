#!/usr/bin/env bash

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/apps.rasi"

# Links
todo=""
calendar=""
mail=""
journal=""
telegram=""

# Error msg
msg() {
  rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "$1"
}

# Variable passed to rofi
options="$todo\n$calendar\n$mail\n$journal\n$telegram"

chosen="$(echo -e "$options" | $rofi_command -p "Time Utils" -dmenu -selected-row 0)"
case $chosen in
$todo)
  gnome-todo &
  ;;
$calendar)
  gnome-calendar &
  ;;
$mail)
  firefox --new-tab "https://mail.google.com/mail/u/0/"
  ;;
$journal)
  code ~/Documents/Journal &
  ;;
$telegram)
  telegram-desktop &
  ;;
esac
