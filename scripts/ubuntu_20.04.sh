#!/bin/bash

echo "\t--------------------------------------------------------------------"
echo "\t| Boychaboy's dotfile installer for Ubuntu 20.04 LTS (Focal Fossa) |"
echo "\t--------------------------------------------------------------------"

# ----------------------------------------------------------------------
# | General                                                            |
# ----------------------------------------------------------------------
# tzdata 구성을 위한 비대화형 설치 설정
export DEBIAN_FRONTEND=noninteractive

# tzdata에 대한 사전 설정
ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime
echo "Asia/Seoul" | tee /etc/timezone

# tzdata 패키지 설치
apt-get update
apt-get install -y tzdata

# basic packages
apt-get install -y git wget zsh vim openssh-server sudo curl tmux exuberant-ctags
# python packages
apt-get install python3 python3-pip -y
# extra packages
apt-get install autojump net-tools

# ----------------------------------------------------------------------
# | Set up .zshrc                                                     |
# ----------------------------------------------------------------------

# ZSH 
apt-get -y install fonts-powerline
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ZSH-plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips

# ZSH-setting
chsh -s /bin/zsh

# ----------------------------------------------------------------------
# | Create symbolic links to new dotfiles                              |
# ----------------------------------------------------------------------
if [ -e $HOME/.vimrc ]; then
    mv $HOME/.vimrc $HOME/.vimrc.backup
fi
if [ -e $HOME/.zshrc ]; then
    mv $HOME/.zshrc $HOME/.zshrc.backup
fi
if [ -e $HOME/.tmux.conf ]; then
    mv $HOME/.tmux.conf $HOME/.tmux.conf.backup
fi

ln -sf ${HOME}/.dotfiles/.vimrc ${HOME}/.vimrc
ln -sf ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
ln -sf ${HOME}/.dotfiles/.tmux.conf ${HOME}/.tmux.conf
ln -sf ${HOME}/.dotfiles/.p10k.zsh ${HOME}/.p10k.zsh

echo "Symbolic links created to new dotfiles for [.vimrc, .zshrc, .tmux.conf]"

# ----------------------------------------------------------------------
# | Install miniconda                                                  |
# ----------------------------------------------------------------------
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init zsh

# ----------------------------------------------------------------------
# | Set up .vimrc                                                      |
# ----------------------------------------------------------------------
# Install vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "> Successfully installed Vundle.vim"
fi

# Install plugins
vim +PluginInstall +qall

# Build YCM
apt-get install -y build-essential cmake vim-nox python3-dev
apt-get install -y mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm
apt-get install -y vim-youcompleteme
python3 ~/.vim/bundle/YouCompleteMe/install.py --force-sudo --verbose

# Install required packages
pip install --upgrade pip
pip install ipdb black flake8 jsonlines numpy pandas tqdm scikit-learn requests

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
# Time & Location 
apt-get install -y language-pack-en && sudo update-locale

# 설치로 생성된 캐시 파일 삭제
apt-get clean && \
	apt-get autoclean && \
	apt-get autoremove -y && \
	rm -rf /var/lib/cache/* && \
	rm -rf /var/lib/log/* && \
    rm -rf /root/Dockerfile

printf "\n✨Done!"
