# 🍵 boychaboy's dotfiles 
## Description
개발 환경 세팅을 위한 config 파일 및 설치 스크립트
- [miniconda](https://docs.anaconda.com/miniconda/)
- [oh-my-zsh](https://ohmyz.sh)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [vim](https://www.vim.org)
  - [ycm](https://github.com/ycm-core/YouCompleteMe)

## Supported OS
**Linux**
- [Ubuntu 22.04.2 LTS](https://releases.ubuntu.com/jammy/)

**MacOS**
- 13.4 (with Apple Silicon)

## Install
### Linux
**Ubuntu 22.04**
```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/boychaboy/dotfiles/main/scripts/ubuntu_22.04.sh)"
```
### MacOS
```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/boychaboy/dotfiles/main/scripts/mac.sh)"
```

## How to use
**Default key bindings**  
- Checkout [cheatsheet/vim]()

**Custom key bindings**
```vim
# General
nmap <leader>m <Plug>MarkdownPreview " Markdown preview with browser
nmap \ :NERDTreeToggle<CR> " Open Nerdtree
nmap <leader>s :w<CR> " Save
nmap <leader>q :q!<CR> " Quit

# Python
" Add/Remove breakpoint
let g:pymode_breakpoint_key='<leader>b'
let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace(context=10)  # fmt: skip'


```
