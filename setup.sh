#!/bin/sh

# remove defaults dotfiles
cd ~
rm ./.bashrc
rm ./.git-completion.bash
rm ./.tmux.conf
rm ./.vimrc
rm -rf .vim
# link to new dotfiles
ln -s dotfiles/.bashrc 
ln -s dotfiles/.git-completion.bash
ln -s dotfiles/.tcshrc 
ln -s dotfiles/.tmux.conf 
ln -s dotfiles/.vim
ln -s dotfiles/.vimrc
# setting for neobundle
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
