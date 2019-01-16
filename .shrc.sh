
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias more='less'
alias pac='sudo pacman -S'
alias upd='sudo pacman -Syu'
alias aur=trizen
alias e=nvim
alias bc='bc -q'
alias optirun-nvidia-settings='optirun -b none nvidia-settings -c :8'
alias qemu-run-windows='qemu-system-x86_64 -enable-kvm -smp cores=2,threads=4 -m 2048 -soundhw hda  /mnt/hdd/vm/Windows7/Windows7.img'
alias ps-total-mem="ps aux --sort rss | awk '{sum += \$6} END {print sum}'"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

pg()
{
    ps aux | grep $1 | grep -v grep
}

# works the same way as dirname
# but does not return '.' if there is no directory in the path
# and returns an empty string in such case.
gd_dirname()
{
    D=`dirname $1`
    if [ $D == "." ]
    then
        D=""
    fi
    echo $D
}

#function gdrive-fetch
#{
#  rclone sync gdrive:/$1  ~/googledrive/`gd_dirname $1`
#}

#function gdrive-upload
#{
#  rclone  sync ~/googledrive/$1 gdrive:/`gd_dirname $1`
#}
#
# # ex - archive extractor
# # usage: ex <file>
ex()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

colors()
{
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo; echo
    done
}

