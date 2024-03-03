#!/bin/bash

# directory in which the repo is
CUR_DIR="$HOME/Programming/dotfiles"

update_app() {
    local APP_NAME="$1"
    shift
    local APP_DIR="$1"
    shift
    local app_dirs=("$@")

    if [ -z "$app_dirs" ];then
        echo "-> ${APP_NAME}, location: $CUR_DIR/$APP_DIR, whole folder"
        [ -e "${CUR_DIR}/$APP_DIR" ] && rm "${CUR_DIR:?}/$APP_DIR" -r
        [ -e "$HOME/$APP_DIR" ] && cp "$HOME/$APP_DIR" "$CUR_DIR/$APP_DIR" -r
    else
        echo "-> ${APP_NAME}, location: $CUR_DIR/$APP_DIR, folders: ${app_dirs[@]}"
        mkdir -p "$CUR_DIR/$APP_DIR"
        for i in "${app_dirs[@]}"; do
            echo -e "\t$i"
            [ -e "${CUR_DIR}/$APP_DIR/$i" ] && rm "${CUR_DIR:?}/$APP_DIR/$i" -r
            [ -e "$HOME/$APP_DIR/$i" ] && cp "$HOME/$APP_DIR/$i" "$CUR_DIR/$APP_DIR/$i" -r
        done
    fi
}

declare -a config=("fontconfig" "libinput-gestures.conf" "mpv" "starship.toml" "zathura")
declare -a i3=("i3" "dunst" "rofi" "polybar" "picom")
declare -a code=("snippets" "keybindings.json" "settings.json" "profiles")
declare -a codium=("snippets" "keybindings.json" "settings.json")
declare -a vim=("autoload" "bitmaps" "vimrc")
declare -a sublime=("User")
declare -a audacity=("Theme")
declare -a scripts=("apt" "basic" "colors" "cp" "dmenu" "i3" "shell" "tools")
declare -a shell=(".zshrc" ".profile" ".bashrc" ".zprofile")

update_app "alacritty" ".config/alacritty"
update_app "config files" ".config" "${config[@]}"
update_app "vim" ".vim" "${vim[@]}"
update_app "code" ".config/Code/User" "${code[@]}"
# update_app "codium" ".config/VSCodium/User" "${codium[@]}"
# update_app "sublime" ".config/sublime-text/Packages" "${sublime[@]}"
update_app "audacity" ".audacity-data" "${audacity[@]}"
update_app "scripts" "Scripts" "${scripts[@]}"
update_app "shell" "." "${shell[@]}"
