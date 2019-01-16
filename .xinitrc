#!/bin/bash

sdir=~/scripts

# runs script from $sdir if there is no process with same name already
run_once
{

    if [[ $(pgrep $1) == "" ]]; then
        $sdir/$1 &
    fi
}

# Run dwm in a loop
# This allows to relaunch dwm if it is killed with SIGUSR1 (soft reload)
run_dwm
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

#termite&
~/.fehbg&

run_dwm
