#/usr/bin/bash

# compgen -c \
#     | sort -u \
#     | grep '[_\-\+0-9a-zA-Z]' \
#     | fzf --no-extended --print-query --color=bw --reverse --border \
#     | tail -n1  \
#     | xargs -r swaymsg -t command exec
dmenu_path \
    | fzf --no-extended --print-query --color=bw --reverse --border \
    | tail -n1  \
    | xargs -r swaymsg -t command exec
