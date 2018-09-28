#!/bin/sh

# VIMのバージョン確認
VIM_VERSION=$(vi --version | head -n 1 )
# VIMバージョン情報からVerNumだけ抜き出す
set ${VIM_VERSION}
VIM_VERSION=${5} 
VIM_VERSION=${VIM_VERSION:0:1}
OLD_VIM_VERSION=7
if [ $VIM_VERSION = $OLD_VIM_VERSION ] ; then
    echo "start install vim8"
    eval ./installVim8.sh
fi

echo $VIM_VERSION
DOTFILE_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

ln -sf $DOTFILE_DIR/.vimrc ~/.vimrc
ln -sf $DOTFILE_DIR/plugins.toml ~/.vim/plugins.toml
ln -sf $DOTFILE_DIR/plugins_lazy.toml ~/.vim/plugins_lazy.toml
ln -sf $DOTFILE_DIR/.bash_profile ~/.bash_proflie
