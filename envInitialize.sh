#!/bin/sh
DOTFILE_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

ln -sf $DOTFILE_DIR/.vimrc ~/.vimrc
