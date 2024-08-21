get-tabs(){
    strings $HOME/.config/google-chrome/Default/Sessions/Session_* | grep -E '^https?://' | sed 's|/$||g' | sort | uniq | grep -v 'google.com'
}

bookmarks(){
    grep -i "$1" $HOME/Documents/todo/bookmarks/*.md
}

rlatex(){
    rm *.aux *.fdb_latexmk *.fls *.log *.out *.toc
}

# clipboard examples
_copy(){
    cat | xclip -selection clipboard
}

_paste(){
    xclip -selection clipboard -o
}

_pastei(){
    xclip -selection c -o -t image/png > $1
}

cdd(){
    VAR=$('ls' -1 | fzf)
    if [ ! -z "$VAR" ];then
        # echo "$VAR"
        cd "$VAR"
    fi
}

new_terminal(){
    alacritty --working-directory `xcwd` & disown
}

## utilities
camera_close(){
    # Cameras are controlled by the uvcvideo kernel module
    sudo modprobe -r uvcvideo
    # force removal
    # sudo rmmod -f uvcvideo
}

camera_open(){
    sudo modprobe uvcvideo
}

o(){
    if [[ "$1" == *".pdf" ]]; then
        zathura "$1" & disown
    fi
}

vimwiki(){
    if [ $# -eq 0 ]; then return 1; fi
    DIR="/media/totoro/Data/Programming/vim-wiki"
    NO="7"  # no of level the DIR is deep +1, to use with cut, awk takes more time so 
    if [ ! -d "$DIR" ]; then return 1; fi 
    CHOICE=$(grep -rnw "$DIR" -e "$1" | cut -d'/' -f$NO | fzf --border | cut -d':' -f1)
    if [ -z "$CHOICE" ]; then return 1; fi
    vim "$DIR/$CHOICE"
}

c(){
    ARG=$(echo "$@" | sed 's/ /+/g')
    curl http://cht.sh/"$ARG"
}

fix_monitor(){
    xrandr --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output eDP-1-1 --mode 1920x1080 --pos 1920x0 --rotate normal
}

ytdlsmall(){
    youtube-dl "$1" --external-downloader aria2c --external-downloader-args "-j 8 -s 8 -x 8 -k 5M"
}

ytdlaudio(){
    youtube-dl "$1" -f bestaudio --external-downloader aria2c --external-downloader-args "-j 8 -s 8 -x 8 -k 5M"
}

ytdlpaudio(){
    yt-dlp "$1" -f bestaudio --external-downloader aria2c --external-downloader-args "-j 8 -s 8 -x 8 -k 5M"
}

ytdlbig(){
    youtube-dl "$1" --external-downloader aria2c --external-downloader-args "-j 12 -s 12 -x 12 -k 5M"
}

pro(){
    DIR="/media/totoro/Data/Programming/"
    if [ ! -d "$DIR" ]; then
        return 1
    else
        VAR=$(find "$DIR" -maxdepth 2 \( ! -regex '.*/\..*' \) -type d |
            sed 's|'"$DIR"'||g' | fzf --border)
        if [ "$VAR" == "$DIR" ]; then
            cd "$DIR"
        elif [ ! -z "$VAR" ]; then
            cd "$DIR""$VAR"
        fi
    fi
}

tech(){
    DIR="/media/totoro/Data/BTECH/"
    if [ ! -d "$DIR" ]; then
        return 1
    else
        DIR=${DIR}"$1/"
        VAR=$(find "$DIR" -maxdepth 2 \( ! -regex '.*/\..*' \) -type d | 
            sed 's|'"$DIR"'||g' | fzf --border)
        if [ ! -z "$VAR" ];then
            cd "$DIR""$VAR"
        fi
    fi
}

btech(){
    DIR="/media/totoro/Data/BTECH/"
    if [ ! -d "$DIR" ]; then
        return 1
    else
        if [[ ! -z $1 ]]; then
            DIR=${DIR}"$1/"
            VAR=$(find "$DIR" -maxdepth 2 \( ! -regex '.*/\..*' \) -type d | 
                sed 's|'"$DIR"'||g' | fzf --border)
            if [ ! -z "$VAR" ];then
                cd "$DIR""$VAR"
            fi
        else
            VAR=$(find "$DIR/6" -maxdepth 2 \( ! -regex '.*/\..*' \) -type d | 
                sed 's|'"$DIR"'/6||g' | fzf --border)
            if [ ! -z "$VAR" ];then
                cd "$DIR/6""$VAR"
            fi
        fi
    fi
}

ww(){
    if [ ! -z "$@" ]; then
        sdcv "$@"
    else
        local WORD_MEANING
        local WORD
        local MEANING
        D=$RANDOM
        WORD_MEANING=$(sed -n $((1 + $RANDOM % 36667))p $HOME/.dictonary/oxford_english_dict.txt)
        WORD=$(echo $WORD_MEANING | awk -F'  ' '{print $1}')
        MEANING=$(echo $WORD_MEANING | awk -F'  ' '{print $2}')
        echo "\033[4;31m$WORD"
        echo "\033[0;34m$MEANING"
    fi
}

lfcd () {
    # Use lf to switch directories and bind it to ctrl-o
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
