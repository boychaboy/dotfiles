#!/bin/bash

printf "Welcome to boychaboy's dotfiles installer!\n\n"

# ----------------------------------------------------------------------
# | Clone dotfile repository                                           |
# ----------------------------------------------------------------------
printf "\033[33mCloning Repository...\033[0m\n"
if [ ! -d ${HOME}/.dotfiles ]; then
    echo "dotfiles doesn't exist in ${HOME}/.dotfiles"
    echo "Do you want to clone repository?"
    echo "  git@github.com:boychaboy/dotfiles.git >> ${HOME}/.dotfiles"
    echo ""
    read -p "Proceed (y/n [n])? " choice
    case "$choice" in 
        y|Y ) 
            git clone --recursive git@github.com:boychaboy/dotfiles.git ${HOME}/.dotfiles;;
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
if [[ "$os_type" == "linux-gnu" ]]; then
    printf "Linux OS\n"
    sh ./install_linux.sh
elif [[ "$os_type" == "darwin"* ]]; then
    printf "Mac OS\n"
    sh ./install_mac.sh
else
    printf "Unsupported os!
    Now aborting..."
    exit 1
fi

exit 0
