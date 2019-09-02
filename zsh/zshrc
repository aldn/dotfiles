##################
# antibody
##################
source <(antibody init)
antibody bundle < ~/.cfg/zsh/bundle.txt
#source ~/.cfg/zsh/bundle.sh

##################
# completion
##################
zstyle ':completion:*' rehash true
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit; compinit

# zstyle ':completion::complete:*' gain-privileges 1
setopt COMPLETE_ALIASES

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search


##################
# prompt
##################
autoload -U promptinit; promptinit
PURE_CMD_MAX_EXEC_TIME=10
# change the path color
zstyle :prompt:pure:path color white
# change the color for both `prompt:success` and `prompt:error`
zstyle ':prompt:pure:prompt:*' color cyan
prompt pure


##################
# extra conf
##################
source_env_file() {
    [[ -e ~/.cfg/env/$1 ]] && emulate sh -c 'source ~/.cfg/env/$1'
}

source_env_file vars
source_env_file aliases
source_env_file subs

