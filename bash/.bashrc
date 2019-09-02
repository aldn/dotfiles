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

shopt -s autocd
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

Green='\033[0;32m'
BoldBlue='\033[1;34m'
BoldGreen='\033[1;32m'
Def='\033[0m'
#PS1='[\u@\h \W]\$ '
#PS1="\[$Green\]\u\[$ColorReset\] \[$BBlue\]\w\[$ColorReset\] \[$BGreen\]\$\[$ColorReset\] "
PS1="\[$BoldGreen\]\u@\h\[$Def\]:\[$BoldBlue\]\w\[$Def\]\$ "
unset Green BoldBlue BoldGreen Def

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# spawn tmux and replace shell with it
#[[ -z "$TMUX" ]] && exec tmux

