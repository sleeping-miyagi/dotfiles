" plugin
call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/goyo.vim'
    Plug 'vim-scripts/fountain.vim'
    Plug 'dbeniamine/todo.txt-vim'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
call plug#end()

" general settings
syntax on
set autoread
set wildmenu
set number relativenumber
set nu rnu
set spelllang=en_us
set spell
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set confirm
set undofile
set undodir=~/.vim/undo
set hls is
set ic
set clipboard=unnamedplus
set nocompatible
set laststatus=2

" appearance
set t_Co=256
set background=dark
set showcmd
set showtabline=1
colorscheme gruvbox
let g:gruvbox_italic=1

filetype plugin indent on

" keybindings
nmap <space> za
nmap <F3> :Goyo<CR>
nmap <F4> :Pandoc pdf --citeproc<CR>
nmap <C-S> <Plug>BujoAddnormal
imap <C-S> <Plug>BujoAddinsert
nmap <C-Q> <Plug>BujoChecknormal
imap <C-Q> <Plug>BujoCheckinsert

" forget using 'sudo vim'
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" plugin settings
au BufRead,BufNewFile *.fountain set filetype=fountain
let g:todo_done_filename = 'done.txt'

" FIX VIM COLORS "
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
