FROM ubuntu:latest
MAINTAINER Younghun Jeong <boychaboy@github.com>

# ----------------------------------------------------------------------
# | General                                                      |
# ----------------------------------------------------------------------
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
# basic packages
RUN apt-get -y update &&\
 apt-get install -y git wget zsh tzdata vim openssh-server sudo curl tmux exuberant-ctags
# python packages
RUN apt-get install python3 python3-pip -y
# extra packages
RUN apt-get install autojump net-tools

# ----------------------------------------------------------------------
# | Set up .zshrc                                                     |
# ----------------------------------------------------------------------

# ZSH 
RUN apt-get -y install fonts-powerline
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ZSH-plugins
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
RUN git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips

# ZSH-setting
COPY . /root/
RUN chsh -s /bin/zsh

# ----------------------------------------------------------------------
# | Install miniconda                                                  |
# ----------------------------------------------------------------------
RUN mkdir -p ~/miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
RUN bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
RUN rm -rf ~/miniconda3/miniconda.sh
RUN ~/miniconda3/bin/conda init zsh

# ----------------------------------------------------------------------
# | Set up .vimrc                                                      |
# ----------------------------------------------------------------------
# Install vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Build YCM
RUN apt-get install -y build-essential cmake vim-nox python3-dev
RUN apt-get install -y mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm
RUN apt-get install -y vim-youcompleteme

# Install plugins
RUN script -c 'vim +PluginInstall +qall' /dev/null

# Recomplie YCM
# - without c#, go, java, rust, support
RUN python3 ~/.vim/bundle/YouCompleteMe/install.py --force-sudo --verbose

# Install required packages
RUN pip install --upgrade pip
RUN pip install ipdb black flake8 jsonlines

# ----------------------------------------------------------------------
# | ETC                                                                |
# ----------------------------------------------------------------------

# Time & Location 
RUN sudo apt-get install -y language-pack-en && sudo update-locale

# 설치로 생성된 캐시 파일 삭제
RUN apt-get clean && \
	apt-get autoclean && \
	apt-get autoremove -y && \
	rm -rf /var/lib/cache/* && \
	rm -rf /var/lib/log/* && \
    rm -rf /root/Dockerfile

CMD ["zsh"]
