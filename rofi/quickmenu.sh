#!/bin/bash


cmd_lock="i3lock"
cmd_sleep="systemctl suspend"
cmd_hibernate="systemctl hibernate"

entries=(
    "Chromium               : chromium"
    "Keepass X2             : keepassx2"
    "gvim                   : gvim"
    "Qt Creator             : qtcreator"
    "Color Selector         : gcolor2"
    "Font Selector          : fontsel"
    "Font Preview           : waterfall"
    "VNC                    : remmina"
    "GIMP                   : gimp"
    "RAW photo converter    : rawtherapee"
    "Blender                : blender"
    "Tracktion 7            : Tracktion7"
    # "QJackCtl             : qjackctl"
    "QSynth                 : qsynth"
    "TuxGuitar              : tuxguitar"
    "MPD client Cantata     : cantata"
    "EasyTag                : easytag"
    "Sketchup 2016          : wine C:\\\\windows\\\\command\\\\start.exe /d \"C:\\\\Program Files\\\\SketchUp\\\\SketchUp 2016\" \"C:\\\\Program Files\\\\SketchUp\\\\SketchUp 2016\\\\SketchUp.exe\""
    "xzoom                  : xzoom"
    "----------- : "
    "LibreOffice Calc         : libreoffice --calc"
    "LibreOffice Writer       : libreoffice --writer"
    "----------- : "
    "GTK theme              : lxappearance"
    "Qt theme               : qt5ct"
    # "Compton              : compton-conf"
    "Configure Tint2        : tint2conf"
    "Select Wallpaper       : nitrogen"
    # "Random Wallpaper     : wallpaper-wallhaven-dl.sh -m random -c 101 -f 101 -r 1920x1080"
    "----------- : "
    "Lock                   : $cmd_lock"
    "Lock & Sleep           : $cmd_lock && $cmd_sleep"
    "Hibernate              : $cmd_hibernate"
)

    # join the list of entries with newline, extract portion before the ":" separator


selection=$( printf "%s\n" "${entries[@]}" \
    | sed -n "s/:.*$//p" \
    | sed -n "s/[[:space:]]*$//p" \
    | rofi -dmenu -i -format i -p 'quickmenu:' -columns 1 -width 13 -lines 30 -location 0)
#echo $selection

if [ "$selection" != "" ]
then
    command=${entries[$selection]}
    # extract portion after ":" as shell command
    command=$(echo $command | sed "s/^.*://")
    #echo $command
    exec $command
fi
