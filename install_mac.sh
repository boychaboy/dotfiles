#!/bin/bash

# ----------------------------------------------------------------------
# | 0. Clone and create symbolic link                                  |
# ----------------------------------------------------------------------
echo "Clone dotfile repository"
echo "  git@github.com:boychaboy/dotfiles.git >> ${HOME}/.dotfiles"
echo ""
read -p "Proceed (y/n [n])? " choice
case "$choice" in 
    y|Y ) 
        if [ ! -d ${HOME}/.dotfiles ]; then
            git clone --recursive git@github.com:boychaboy/dotfiles.git ${HOME}/.dotfiles
        else
            echo "${HOME}/.dotfiles already exists"
            read -p "Overwrite (y/n [n])? " choice
                case "$choice" in 
                    y|Y )
                        rm -rf ${HOME}/.dotfiles
                        git clone --recursive git@github.com:boychaboy/dotfiles.git ${HOME}/.dotfiles;;
                    n|N|"" );;
                esac
        fi;;
    n|N|"" )
esac
echo ""

echo "Backup existing dotfiles"
OLD_DOTFILES=""
# .zshrc
if [ -f ${HOME}/.zshrc ]; then
    OLD_DOTFILES+="     ${HOME}/.zshrc
    "
fi
# .vimrc
if [ -f ${HOME}/.vimrc ]; then
    OLD_DOTFILES+=" ${HOME}/.vimrc
    "
fi
# .tmux.conf
if [ -f ${HOME}/.tmux.conf ]; then
    OLD_DOTFILES+=" ${HOME}/.tmux.conf
    "
fi
# .brewfile
if [ -f ${HOME}/.brewfile ]; then
    OLD_DOTFILES+=" ${HOME}/.brewfile
    "
fi

echo "  Files to backup:
${OLD_DOTFILES}"
read -p "Proceed (y/n [n])? " choice

case "$choice" in 
    y|Y ) 
        # .zshrc
        if [ -f ${HOME}/.zshrc ]; then
            mv ${HOME}/.zshrc ${HOME}/.zshrc.old
            echo "  ${HOME}/.zshrc >> ${HOME}/.zshrc.old"
        fi
        # .vimrc
        if [ -f ${HOME}/.vimrc ]; then
            mv ${HOME}/.vimrc ${HOME}/.vimrc.old
            echo "  ${HOME}/.vimrc >> ${HOME}/.vimrc.old"
        fi
        # .tmux.conf
        if [ -f ${HOME}/.tmux.conf ]; then
            mv ${HOME}/.tmux.conf ${HOME}/.tmux.conf.old
            echo "  ${HOME}/.tmux.conf >> ${HOME}/.tmux.conf.old"
        fi
        # .brewfile
        if [ -f ${HOME}/.brewfile ]; then
            mv ${HOME}/.brewfile ${HOME}/.brewfile
            echo "  ${HOME}/.brewfile >> ${HOME}/.brewfile.old"
        fi;;
    n|N|"" )
esac
echo ""
echo "Create symbolic links to new dotfiles"
read -p "Proceed (y/n [n])? " choice

case "$choice" in 
    y|Y ) 
        ln -sf ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
        ln -sf ${HOME}/.dotfiles/.vimrc ${HOME}/.vimrc
        ln -sf ${HOME}/.dotfiles/.tmux.conf ${HOME}/.tmux.conf
        ln -sf ${HOME}/.dotfiles/.brewfile ${HOME}/.brewfile;;
    n|N|"" )
esac

# ----------------------------------------------------------------------
# | 1. Homebrew                                                        |
# ----------------------------------------------------------------------

echo ""
echo "Install homebrew and tap all packages"
read -p "Proceed (y/n [n])? " choice

case "$choice" in 
    y|Y ) 
        if test ! $(which brew); then
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
          echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zshrc
          eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        brew doctor
        brew update
        brew bundle --file=${HOME}/.dotfiles/.brewfile;;
    n|N|"" )
esac

# ----------------------------------------------------------------------
# | 2. oh-my-zsh                                                       |
# ----------------------------------------------------------------------

echo ""
echo "Installing oh-my-zsh and plugins..."
if [ ! -d ${HOME}/.oh-my-zsh ]; then
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi
if [ ! -d ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if [ ! -d ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d ${HOME}/.oh-my-zsh/custom/themes/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
fi
echo "> Successfully installed oh-my-zsh, zsh-syntax-highlighting, zsh-autosuggestions, powerlevel10k"

# ----------------------------------------------------------------------
# | 3. vim                                                             |
# ----------------------------------------------------------------------

echo ""
echo "Setting up .vimrc..."

# Install vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "> Successfully installed Vundle.vim"
fi

# Install plugins
vim +PluginInstall +qall

# Setup for YCM
echo ""
echo "Recompile vim for YCM python 3.8.0+ support"
read -p "Proceed (y/n [n])? " choice

case "$choice" in 
    y|Y ) 
        brew install cmake python go nodejs
        brew install java
        brew install vim
        source ${HOME}/.zshrc
        sudo ln -sfn $(brew --prefix java)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
        python3 ${HOME}/.vim/bundle/YouCompleteMe/install.py --all;;
    n|N|"" )
esac

# ----------------------------------------------------------------------
# | 4. Conda                                                           |
# ----------------------------------------------------------------------

# Install miniconda
echo ""
echo "Install Miniconda"
read -p "Proceed (y/n [n])? " choice

case "$choice" in
    y|Y )
        mkdir -p ~/miniconda3
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda3/miniconda.sh
        bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
        rm -rf ~/miniconda3/miniconda.sh
        echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.zshrc
        # ~/miniconda3/bin/conda init bash
        # ~/miniconda3/bin/conda init zsh
        source ${HOME}/.zshrc;;
    n|N|"" )
esac

