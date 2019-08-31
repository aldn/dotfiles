source_env_file() {
    [[ -f ~/.cfg/env/$1 ]] && . ~/.cfg/env/$1
}

source_env_file vars

# Execute the rest of the script only if interactive shell
[[ $- != *i* ]] && return

source_env_file aliases
source_env_file subs


# Always check for window size updates
#shopt -s checkwinsize

Green='\e[0;32m'
BBlue='\e[1;34m'
BGreen='\e[1;32m'
ColorReset='\e[0m'
#PS1="\[$Green\]\u\[$ColorReset\] \[$BBlue\]\w\[$ColorReset\] \[$BGreen\]\$\[$ColorReset\] "
#PS1='[\u@\h \W]\$ '

# spawn tmux and replace shell with it
#[[ -z "$TMUX" ]] && exec tmux

