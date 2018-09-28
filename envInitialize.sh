#!/bin/sh

# VIMのバージョン確認
VIM_VERSION=$(/usr/local/bin/vim --version | head -n 1 )
# VIMバージョン情報からVerNumだけ抜き出す
set ${VIM_VERSION}
VIM_VERSION=${5} 
VIM_VERSION=${VIM_VERSION:0:1}
OLD_VIM_VERSION=7
if [ $VIM_VERSION = $OLD_VIM_VERSION ] ; then
    echo "start install vim8"
    eval ./installVim8.sh
fi


DOTFILE_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)

for f in .??*
do
    [ "$f" = ".git" ] && continue
    ln -snfv $DOTFILE_DIR/"$f" ~/"$f"
done

ln -sf $DOTFILE_DIR/plugins.toml "$HOME"/.vim/plugins.toml
ln -sf $DOTFILE_DIR/plugins_lazy.toml "$HOME"/.vim/plugins_lazy.toml
