# dotfiles
> 개발 환경 세팅 자동화를 위한 dotfiles 및 shell scripts

## Supported OS
**Linux**
- [Ubuntu 22.04.2 LTS](https://releases.ubuntu.com/jammy/)
  - [dockerfile](https://github.com/boychaboy/dockerfiles)

**MacOS**
- 13.4 (with Apple Silicon)

## Install
**Linux**
```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/boychaboy/dotfiles/main/scripts/install_ubuntu.sh)"
```
**Mac**
```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/boychaboy/dotfiles/main/scripts/install_mac.sh)"
```

## Key bindings 
**Default key bindings**  
Checkout [cheatsheet/vim]()
```vim
```
**Custom key bindings**
```vim
# General
nmap <leader>m <Plug>MarkdownPreview " Markdown preview with browser
nmap ' :NERDTreeToggle<CR> " Open Nerdtree
nmap <leader>s :w<CR> " Save
nmap <leader>q :q!<CR> " Quit

# Python
" Add/Remove breakpoint
let g:pymode_breakpoint_key='<leader>b'
let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace(context=10)  # fmt: skip'


```






## Misc 
#### Homebrew for MacOS
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
brew doctor
brew update
brew bundle --file=dotfiles/.brewfile
```
#### Oh-my-zsh
```bash
# oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
# chsh -s $(which zsh)
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM1:-$ZSH/custom}/plugins/alias-tips
# export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias tip: "
```

#### CentOS
```shell
# backup previous dotfiles
mkdir -p $HOME/.dotfiles.backup
mv ~/.[^.]* $HOME/.dotfiles.backup/

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

# get new dotfiles
git clone git@github.com:boychaboy/dotfiles.git
mv dotfiles/* $HOME/

tmux source $HOME/.tmux.conf
source ~/.zshrc
source ~/.vimrc

wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
zsh ~/miniconda.sh -b -p
rm ~/miniconda.sh
echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.zshrc

```
**issues**
- [How to Install Vim 8.2 on CentOS 7](https://phoenixnap.com/kb/how-to-install-vim-centos-7)
- [How to install the latest stable tmux on CentOS 7](https://liyang85.wordpress.com/2017/07/28/how-to-install-the-latest-stable-tmux-on-centos-7/)
- [How to Compile VIM with python3.6++](https://dev.to/huang06/compiling-vim-with-python3-support-8jh)
    ```shell
    # 1. remove installed VIM
    sudo rm -rf /lib/bin/vim
    # 2. clone & configure vim
    git clone https://github.com/vim/vim.git
    cd vim/src
    # 3. configure and install
    ./configure --enable-cscope --enable-multibyte  --enable-rubyinterp --enable-pythoninterp --enable-python3interp --with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu --enable-fail-if-missing
    make
    sudo make install
    ```
- `The ycmd server SHUT DOWN (restart with :YcmRestartServer)` error
    - `CMake 3.14 or higher is required`: [[Linux] CentOS7 Cmake version update or install](https://codinghero.tistory.com/174)
    - `Your C++ compiler does NOT fully support C++17.`: [Your C++ compiler does NOT fully support C++17](https://stackoverflow.com/questions/65284572/your-c-compiler-does-not-fully-support-c17)
    - 


#### YMC for MacOS
```
YouCompleteMe unavailable: requires Vim compiled with Python (3.8.0+) support.
```
- 해결: https://gist.github.com/SofijaErkin/d428dcbf6a651673af63f45e851783cf
- ```
  brew reinstall python3
  brew uninstall vim
  brew install vim
  ```
```
The ycmd server SHUT DOWN (restart with :YcmRestartServer)
```
- 필요한 패키지 설치 후 수동으로 build
  ```
  brew install cmake go npm openjdk@17
  cd ~/vim/bundle/YouCompleteMe/
  python3 install.py --all --verbose
  ```
