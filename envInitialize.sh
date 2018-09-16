#!/bin/sh
DOTFILE_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

ln -sf $DOTFILE_DIR/.vimrc ~/.vimrc
ln -sf $DOTFILE_DIR/plugins.toml ~/.vim/plugins.toml
ln -sf $DOTFILE_DIR/plugins_lazy.toml ~/.vim/plugins_lazy.toml
