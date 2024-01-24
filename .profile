# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# display
export DISPLAY1=$(xrandr -q | grep -oE "^HDMI.* connected" | cut -d' ' -f1)
export DISPLAY2=$(xrandr -q | grep -oE "^eDP.* connected" | cut -d' ' -f1)

# xdg dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# binary files
export PATH=$PATH:~/Scripts/basic
export PATH=$PATH:~/Scripts/tools
export PATH=$PATH$( find $HOME/Scripts/tools -type d -printf ":%p" )
export PATH=$PATH:~/Scripts/dmenu
export PATH=$PATH:~/Scripts/i3

# setting qt-theme provider
export QT_QPA_PLATFORMTHEME=qt5ct
# if [ "$DESKTOP_SESSION" == "i3" ];then
# fi

# swap esc and caps-lock
setxkbmap -option "caps:swapescape"
