"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                   BOYCHABOY'S                                                "
"                       __   _ _ _ __ ___  _ __ ___                            "
"                       \ \ / / | '_ ` _ \| '__/ __|                           "
"                        \ V /| | | | | | | | | (__                            "
"                         \_/ |_|_| |_| |_|_|  \___|                           "
"                                                                              "
"                                                                              "
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
 "<leader> key mod
let mapleader = ","

set mouse=a
set ignorecase  "검색시 검색어의 대소문자를 무시한다.

" Be iMproved
set nocompatible

"=====================================================
"" Vundle settings
"=====================================================
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'               " let Vundle manage Vundle, required

    "-------------------=== Code navigation ===-------------
    Plugin 'scrooloose/nerdtree'                " Project and file navigation
    Plugin 'preservim/nerdcommenter'            " Fast commenter
    Plugin 'majutsushi/tagbar'                  " Class/module browser
    " Plugin 'kien/ctrlp.vim'                     " Fast transitions on project files

    "-------------------=== Theme ===-------------------------------
    Plugin 'bling/vim-airline'                  " Lean & mean status/tabline for vim
    Plugin 'vim-airline/vim-airline-themes'     " Themes for airline
    Plugin 'Lokaltog/powerline'                 " Powerline fonts plugin
    Plugin 'tomasiser/vim-code-dark'            " VSCode Color Scheme
    Plugin 'tribela/vim-transparent'            

    "-------------------=== Languages support ===-------------------
    Plugin 'Valloric/YouCompleteMe'             " Autocomplete plugin

    "-------------------=== Python  ===-----------------------------
    Plugin 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
    Plugin 'dense-analysis/ale'                 " Lint and fix
    
    "-------------------=== Markdown ===-----------------------------
    Plugin 'plasticboy/vim-markdown'            " Syntax highlighting, matching rules and mappings for Markdown 
    Plugin 'iamcco/markdown-preview.nvim'       " Markdown preview via internet explorer

    "-------------------=== Tmux ===-----------------------------
    Plugin 'christoomey/vim-tmux-navigator'     " navigate seamlessly between vim and tmux splits 

    "-------------------=== Others ===-----------------------------
    Plugin 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more

    "-------------------=== Deactivated ===-----------------------------
    " Plugin 'fisadev/FixedTaskList.vim'          " Pending tasks list
    " Plugin 'rosenfeld/conque-term'              " Consoles as buffers
    " Plugin 'jupyter-vim/jupyter-vim'            " Jupyter-Vim


call vundle#end()                           " required
filetype on
filetype plugin on
filetype plugin indent on
syntax on                                       " To fix csv.vim error

"=====================================================
"" AirLine settings
"=====================================================
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1


"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=30
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap \ :NERDTreeToggle<CR>

"=====================================================
"" Tagbar settings
"=====================================================
let g:tagbar_autofocus=0
let g:tagbar_width=30
nmap ' :TagbarToggle<CR>

"=====================================================
"" vim-markdown settings
"=====================================================
let g:vim_markdown_folding_disabled = 1

"=====================================================
"" iamcco/markdown-preview settings
"=====================================================
let g:mkdp_auto_start = 0
nmap <leader>m <Plug>MarkdownPreview

"=====================================================
"" Nerdcommenter settings
"=====================================================
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting aregion)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

"=====================================================
"" Pymode settings
"=====================================================

" python executables for different plugins
let g:pymode = 1
let g:pymode_python='python3'
" let g:syntastic_python_python_exec='python3'

" rope
let g:pymode_rope=0
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0
let g:pymode_rope_auto_project=0
let g:pymode_rope_enable_autoimport=0
let g:pymode_rope_autoimport_generate=0
let g:pymode_rope_guess_project=0

" documentation
let g:pymode_doc=0
let g:pymode_doc_bind='K'

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'
let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace(context=10)  # fmt: skip'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

let g:pymode_options_max_line_length = 120
let g:pymode_options_colorcolumn = 1
hi ColorColumn ctermbg=0

" highlight 'long' lines (>= 80 symbols) in python files
" augroup vimrc_autocmds
"     autocmd!
"     autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
"     autocmd FileType python,rst,c,cpp match Excess /\%89v.*/
"     autocmd FileType python,rst,c,cpp set nowrap
"     autocmd FileType python,rst,c,cpp set colorcolumn=88
" augroup END

" code folding
let g:pymode_folding=0

" pep8 indents
let g:pymode_indent=1

" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'

" linting
let g:pymode_lint = 0

"=====================================================
"" YouCompleteMe settings
"=====================================================
" 
set completeopt-=preview

let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0

nmap <leader>g :YcmCompleter GoTo<CR>
nmap <leader>d :YcmCompleter GoToDefinition<CR>

"=====================================================
"" Ale settings
"=====================================================
" 
let g:ale_linters = {'python': ['flake8', 'isort']}     "Lint
let g:ale_fixers = {'python': ['black']}                "Fix errors
let g:ale_python_flake8_options = '--max-line-length=120'
let g:ale_python_flake8_options = '--ignore=E501,W503,E203,E702,E402'
let g:ale_lint_on_save = 1                              "Lint when saving a file
let g:ale_fix_on_save = 1
let g:ale_sign_error = '𝗫'                              "Lint error sign
let g:ale_sign_warning = '⚠'                            "Lint warning sign
let g:ale_statusline_format =[' %d E ', ' %d W ', '']   "Status line texts
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1



"=====================================================
"" General settings
"=====================================================
syntax enable                               " syntax highlight
set t_Co=256                                " set 256 colors
colorscheme codedark                        " set color scheme

set number                                  " show line numbers
set ruler
set ttyfast                                 " terminal acceleration

set tabstop=4                               " 4 whitespaces for tabs visual presentation
set shiftwidth=4                            " shift lines by 4 spaces
set smarttab                                " set tabs for a shifttabs logic
set expandtab                               " expand tabs into spaces
set autoindent                              " indent when moving to the next line while writing code

set cursorline                              " shows line under the cursor's line
set showmatch                               " shows matching part of bracket pairs (), [], {}

set enc=utf-8	                            " utf-8 by default

set nobackup 	                            " no backup files
set nowritebackup                           " only in case you don't want a backup file while editing
set noswapfile 	                            " no swap files

set backspace=indent,eol,start              " backspace removes all (indents, EOLs, start) What is start?

set scrolloff=10                            " let 10 lines before/after cursor during scroll

if has('macunix')
    set clipboard=unnamed                       " use system clipboard (macOS)
else
    set clipboard=unnamedplus                   " use system clipboard (linux)
endif

set exrc                                    " enable usage of additional .vimrc files from working directory
set secure                                  " prohibit .vimrc files to execute shell, create files, etc...

" Additional mappings for Esc (useful for MacBook with touch bar)
inoremap jj <Esc>
inoremap jk <Esc>

"=====================================================
"" Tabs / Buffers settings
"=====================================================
tab sball
set switchbuf=useopen
set laststatus=2
nmap <S-TAB> :bprev<CR>
nmap <TAB> :bnext<CR>
nmap <silent> <leader>q :SyntasticCheck # <CR> :bp <BAR> bd #<CR>

"=====================================================
"" Search settings
"=====================================================
set incsearch	                            " incremental search
set hlsearch	                            " highlight search results

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" save
nmap <leader>s :w<CR>
nmap <leader>q :q!<CR>
map <leader>w :bp<bar>sp<bar>bn<bar>bd<CR>

" terminal
tnoremap <Esc> <C-\><C-n>

" cursor shape
" Options (replace the number after '\e[')
"    Ps = 0  -> blinking block.
"    Ps = 1  -> blinking block (default).
"    Ps = 2  -> steady block.
"    Ps = 3  -> blinking underline.
"    Ps = 4  -> steady underline.
"    Ps = 5  -> blinking bar (xterm).
"    Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[5 q" " insert mode
let &t_EI = "\e[1 q" " normal mode
