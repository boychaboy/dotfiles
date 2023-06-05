#!/bin/bash

printf "Welcome to boychaboy's dotfiles installer!\n\n"

# ----------------------------------------------------------------------
# | Clone dotfile repository                                           |
# ----------------------------------------------------------------------
printf "\033[33mCloning Repository...\033[0m\n"
echo "  git@github.com:boychaboy/dotfiles.git >> ${HOME}/.dotfiles"
git clone -b ubuntu-22.04 https://github.com/boychaboy/dotfiles.git ${HOME}/.dotfiles

# ----------------------------------------------------------------------
# | Clone dotfile repository                                           |
# ----------------------------------------------------------------------
echo "Create symbolic links to new dotfiles"
ln -sf ${HOME}/.dotfiles/.vimrc ${HOME}/.vimrc
ln -sf ${HOME}/.dotfiles/.tmux.conf ${HOME}/.tmux.conf

echo ""
echo "Setting up .vimrc..."

# Install vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "> Successfully installed Vundle.vim"
fi

# Install plugins
vim +PluginInstall +qall

source ${HOME}/.zshrc
