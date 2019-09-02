#!/bin/sh

cd
mkdir .config

# in alphabetical order
ln -s .cfg/bash/.bashrc
ln -s .cfg/git/.gitconfig
ln -s ../.cfg/mpv .config/mpv
ln -s ../.cfg/nvim .config/nvim
ln -s ../.cfg/ranger .config/ranger
ln -s ../.cfg/rofi .config/rofi
ln -s ../.cfg/sway .config/sway
ln -s ../.cfg/termite .config/termite
ln -s .cfg/tmux/.tmux.conf
ln -s .cfg/vim .vim
ln -s .cfg/zsh/.zshrc

