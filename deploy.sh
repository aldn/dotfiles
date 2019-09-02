#!/bin/sh


case "$(uname)" in
    Darwin)
        os="macos"
        ;;
    Linux)
        os="linux"
        ;;
    *)
        echo "error: platform not supported"
        ;;
esac

cd
mkdir .config

# in alphabetical order

[ "$os" != "macos" ] && ln -s .cfg/bash/bashrc .bashrc
ln -s .cfg/git/gitconfig .gitconfig

mkdir -p .config/mpv
if [ "$os" == "macos" ]; then
    ln -s ../../.cfg/mpv/mpv.conf.macos .config/mpv/mpv.conf
else
    ln -s ../../.cfg/mpv/mpv.conf .config/mpv/mpv.conf
fi

ln -s ../.cfg/nvim .config
ln -s ../.cfg/ranger .config
ln -s ../.cfg/rofi .config
ln -s ../.cfg/sway .config
ln -s ../.cfg/termite .config
ln -s .cfg/tmux/tmux.conf .tmux.conf
if [ ! -d .vim ]; then
    ln -s .cfg/vim .vim
else
    echo "ln: .vim: directory exists"
fi
ln -s .cfg/zsh/zshrc .zshrc

