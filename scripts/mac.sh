#!/bin/bash

printf "-----------------------------------------------------------------"
printf "|      Boychaboy's dotfile installer for Mac OS                 |"
printf "-----------------------------------------------------------------"

# ----------------------------------------------------------------------
# | Clone dotfile repository                                           |
# ----------------------------------------------------------------------
printf "\033[33mCloning Repository...\033[0m\n"
if [ ! -d ${HOME}/.dotfiles ]; then
    echo "dotfiles doesn't exist in ${HOME}/.dotfiles"
    echo "Do you want to clone repository?"
    echo "  https://github.com/boychaboy/dotfiles.git >> ${HOME}/.dotfiles"
    echo ""
    read -p "Proceed (y/n [n])? " choice
    case "$choice" in 
        y|Y ) 
            git clone --recursive https://github.com/boychaboy/dotfiles.git ${HOME}/.dotfiles;;
        n|N|"" )
            echo ""
    esac
else
    printf ".dotfile already esists in ${HOME}/.dotfiles
    TIP: if you already installed dotfiles in your system, run 'update.sh' to update dotfiles"
    echo ""
    read -p "Do you want to overwrite? (y/n [n])?" choice
    case "$choice" in
        y|Y )
            rm -rf ${HOME}/.dotfiles
            git clone --recursive git@github.com:boychaboy/dotfiles.git ${HOME}/.dotfiles;;
        n|N|"" )
    esac
    exit 0
fi

# ----------------------------------------------------------------------
# |  Check OS type                                                     |
# ----------------------------------------------------------------------
printf "\033[33mCheck os type...\033[0m\n"

os_type=$OSTYPE
if [[ "$os_type" == "darwin"* ]]; then
    printf "Mac OS\n"

else
    printf "Unsupported os!
    Now aborting..."
    exit 1
fi

# ----------------------------------------------------------------------
# | Backup & Link                                                      |
# ----------------------------------------------------------------------
printf "\033[33mBackup existing dotfiles and link new files...\033[0m\n"
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
# | Homebrew                                                        |
# ----------------------------------------------------------------------

echo ""
printf "\033[33mInstalling homebrew and tap all packages...\033[0m\n"
echo ""
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
        brew bundle --file=${HOME}/.dotfiles/.brewfile
        brew install fzf
        brew install ctags
        brew install bat
        brew install wget;;
    n|N|"" )
esac

# ----------------------------------------------------------------------
# | oh-my-zsh                                                       |
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
if [ ! -d ${HOME}/.oh-my-zsh/custom/plugins/alias-tips ]; then
  git clone https://github.com/zsh-users/alias-tips ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
fi
if [ ! -d ${HOME}/.oh-my-zsh/custom/themes/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
fi
echo "> Successfully installed oh-my-zsh, zsh-syntax-highlighting, zsh-autosuggestions, alias-tips, and powerlevel10k"

# ----------------------------------------------------------------------
# | vim                                                             |
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
# | Conda                                                           |
# ----------------------------------------------------------------------

# Install miniconda
echo ""
echo "Install Miniconda"
read -p "Proceed (y/n [n])? " choice

case "$choice" in
    y|Y )
        mkdir -p ${HOME}/miniconda3
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -O ${HOME}/miniconda3/miniconda.sh
        bash ${HOME}/miniconda3/miniconda.sh -b -u -p ${HOME}/miniconda3
        rm -rf ${HOME}/miniconda3/miniconda.sh
        source ${HOME}/.zshrc;;
    n|N|"" )
esac

