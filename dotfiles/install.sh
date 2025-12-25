#!/bin/bash
set -me

usr=~/../usr

if [ ! -d ${usr} ];then
    exit 1
fi

if [ ! -d ~/dotfiles ];then
    exit 1
fi

ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/npmrc ~/.npmrc

[ -L ~/.vim ] || ln -sf ~/dotfiles/vim ~/.vim
[ -L ~/.config ] || ln -sf ~/dotfiles/config ~/.config
[ -L ~/.termux ] || ln -sf ~/dotfiles/termux ~/.termux

relink() {
    if [ -z $1 ];then
        return
    fi
    if [ -e ${usr}/$1.bak ];then
        #echo "Backup file found: usr/$1.bak"
        #echo "Skipping dotfiles/$1"
        return
    fi
    if [ -f ${usr}/$1 ];then
        mv ${usr}/$1{,.bak}
    fi
    if [ ! -d ${usr}/${1%/*} ];then
        mkdir -p ${usr}/${1%/*}
    fi
    ln -sf ~/dotfiles/$1 ${usr}/$1
}

relink etc/resolv.conf
#relink etc/inputrc
#relink etc/my.cnf
#relink etc/redis.conf

relink etc/apt/sources.list
#relink etc/nginx/nginx.conf

