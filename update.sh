#!/bin/bash

# directory in which the repo is
CUR_DIR="$HOME/Programming/dotfiles"

update_app() {
    local APP_NAME="$1"
    shift
    local APP_DIR="$1"
    shift
    local app_dirs=("$@")

    echo "-> ${APP_NAME}, location: $CUR_DIR/$APP_DIR"

    mkdir -p "$CUR_DIR/$APP_DIR"
    for i in "${app_dirs[@]}"; do
        echo -e "\t$i"
        [ -e "${CUR_DIR}/$APP_DIR/$i" ] && rm "${CUR_DIR:?}/$APP_DIR/$i" -r
        [ -e "$HOME/$APP_DIR/$i" ] && cp "$HOME/$APP_DIR/$i" "$CUR_DIR/$APP_DIR/$i" -r
    done
}

declare -a config=( "alacritty" "dunst" "fontconfig" "i3" "libinput-gestures.conf"
    "mpv" "picom" "polybar" "rofi" "starship.toml" "zathura" 
)
declare -a code=("snippets" "keybindings.json" "settings.json")
declare -a codium=("snippets" "keybindings.json" "settings.json")
declare -a vim=("autoload" "bitmaps" "vimrc")
declare -a sublime=("User")
declare -a audacity=("Theme")

update_app "in config" ".config" "${config[@]}"
update_app "vim" ".vim" "${vim[@]}"
update_app "code" ".config/Code/User" "${code[@]}"
update_app "codium" ".config/VSCodium/User" "${codium[@]}"
update_app "sublime" ".config/sublime-text/Packages" "${sublime[@]}"
update_app "audacity" ".audacity-data" "${audacity[@]}"
