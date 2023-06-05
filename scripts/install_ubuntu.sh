#!/bin/bash

printf "-----------------------------------------------------------------"
printf "|      Boychaboy's dotfile installer for Ubuntu 22.04 lts       |"
printf "-----------------------------------------------------------------"

# ----------------------------------------------------------------------
# | Clone dotfile repository                                           |
# ----------------------------------------------------------------------
git clone -b ubuntu-22.04 https://github.com/boychaboy/dotfiles.git ${HOME}/.dotfiles

# ----------------------------------------------------------------------
# | Create symbolic links to new dotfiles                              |
# ----------------------------------------------------------------------
ln -sf ${HOME}/.dotfiles/.vimrc ${HOME}/.vimrc
ln -sf ${HOME}/.dotfiles/.tmux.conf ${HOME}/.tmux.conf
echo "Symbolic links created to new dotfiles for [.vimrc, .tmux.conf]"


# ----------------------------------------------------------------------
# | Set up .vimrc                                                      |
# ----------------------------------------------------------------------
#   a. Install vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "> Successfully installed Vundle.vim"
fi

#   b. Install plugins
vim +PluginInstall +qall

#   c. Build YCM
apt install -y build-essential cmake vim-nox python3-dev
apt install -y mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm
python3 ~/.vim/bundle/YouCompleteMe/install.py --all --force-sudo


# ----------------------------------------------------------------------
# | Install miniconda                                                  |
# ----------------------------------------------------------------------
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init zsh

# ----------------------------------------------------------------------
# | Set up .zshrc                                                     |
# ----------------------------------------------------------------------
# alias
echo 'alias ca="conda activate"\nalias da="conda deactivate"\nalias envs="conda info --envs"\nalias py="python"\nalias cat="bat"\ntmux="tmux -u"' >> ~/.    zshrc
export TERM=xterm-256color
source ${HOME}/.zshrc

# ----------------------------------------------------------------------
# | ETC                                                                |
# ----------------------------------------------------------------------
# python packages for base
pip3 install black flake8 numpy pandas tqdm ipdb scikit-learn requests

# github config
git config --global user.email "hoon2j@gmail.com"
git config --global user.name "boychaboy"

printf "\n✨Done!"
