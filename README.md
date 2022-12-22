# dotfiles
### Requirements  
```shell
zsh
oh-my-zsh
vim>=8.2
Vundle
tmux
tmux-plugin-manager
````
**tmux**  
```shell
# apt-get
sudo apt-get install -y tmux
sudo apt install tmux-plugin-manager
# yum
sudo yum install tmux 
```
**python3**
```shell
sudo yum update -y
sudo yum install -y python3
```
**vundle**
```shell
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "Successfully installed Vundle.vim"
fi
```

## Installation

:warning: Before you begin, set `${HOME}` !

```shell
# check ${HOME}
export HOME=""
```

### CentOS

```shell
# backup previous dotfiles
mkdir -p $HOME/.dotfiles.backup
mv ~/.[^.]* $HOME/.dotfiles.backup/

# get new dotfiles
git clone git@github.com:boychaboy/dotfiles.git
mv dotfiles/* $HOME/

# install zsh
sudo yum install zsh # irteamsu
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh # irteam

# set zsh as default shell
if [ ! $SHELL = "/usr/bin/zsh" ]; then
  echo "Setting your default shell as zsh"
  sudo chsh -s /usr/bin/zsh
fi 
# install oh-my-zsh & themes
if [ ! -d $HOME/.oh-my-zsh ]; then
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# install tmux
sudo yum install epel-release
sudo yum install -y tmux
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm  # tmux plugin manager
tmux source $HOME/.tmux.conf
```
