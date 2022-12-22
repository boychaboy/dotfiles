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
mkdir -p ~/.dotfiles.backup
mv ~/.[^.]* ~/.dotfiles.backup/

# get new dotfiles
git clone git@github.com:boychaboy/dotfiles.git
mv dotfiles/* $HOME/

# install zsh
sudo yum install zsh # irteamsu
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh # irteam
mv ~/.oh-my-zsh/ $HOME/
mv ~/.zshrc $HOME/

# install tmux
sudo yum install epel-release
sudo yum install -y tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm  # tmux plugin manager
tmux source ~/.tmux.conf
```
