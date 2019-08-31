#!/bin/bash

sdir=~/scripts

# runs script from $sdir if there is no process with same name already
run_once()
{

    if [[ $(pgrep $1) == "" ]]; then
        $sdir/$1 &
    fi
}

# Run dwm in a loop
# This allows to relaunch dwm if it is killed with SIGUSR1 (soft reload)
run_dwm()
{
    run_once statusbar.sh

    while true; do
        dwm 2> ~/.dwm.log
        if [[ $? -ne 138 ]]; then
            break
        fi
    done
}

####################
# startup sequence
####################
#xrandr --setprovideroutputsource radeon Intel
#xrandr --setprovideroffloadsink radeon Intel
#xrandr --output HDMI1 --auto --primary --output DisplayPort-1-2   --auto --left-of HDMI1
#xiccd
#compton
#tint2
#chromium
#virt-manager
#uzbl-tabbed
#gvim
#steam
#conky -c ~/.config/conky/sidebar.lua -x 4 -y 4
#nm-applet
#blueberry-tray
#volumeicon
#transmission-qt
#termite&
#~/.fehbg&
dbus-update-activation-environment --systemd DISPLAY
setxkbmap -layout "us,ru" -option "grp:ctr_shift_toggle"
xset dpms 600
#xrdb -m ~/.Xresources
nitrogen --restore &

#run_dwm
exec i3
