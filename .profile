
export PATH=$HOME/bin:~/.gem/ruby/2.5.0/bin:$PATH
export EDITOR=nvim

# 1 for normal ppi displays, >1 for retina-type displays
DPI_SCALE=1

export GDK_SCALE=$DPI_SCALE
export QT_SCALE_FACTOR=$DPI_SCALE

#export HISTFILESIZE=
#export HISTSIZE=
#export HISTTIMEFORMAT='[%F %T] '

# Repaint screen upon exiting less
#export LESS=R

# Highlight color for grep matches
export GREP_COLOR='1;32'

# Perform fzf searches using ag, with options
export FZF_DEFAULT_COMMAND='ag --hidden --depth=10 --ignore .git -f -g ""'

# Set true 256-color gruvbox colour palette for Vim theme
#if [ -d ~/.vim/plugged/colo-gruvbox ]; then
#    source ~/.vim/plugged/colo-gruvbox/gruvbox_256palette.sh
#fi
