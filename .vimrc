" plugins
call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
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
set undodir=~/.vim/undodir
set undofile
set hls is
set ic
set clipboard=unnamedplus
set nocompatible
set laststatus=2

" appearance

set t_Co=256
let g:gruvbox_italic=1
set background=dark
set showcmd
set showtabline=1

filetype plugin indent on

" keybindings
nmap <F3> :Goyo<CR>
nmap <F4> :Pandoc pdf --citeproc<CR>
nmap <C-S> <Plug>BujoAddnormal
imap <C-S> <Plug>BujoAddinsert
nmap <C-Q> <Plug>BujoChecknormal
imap <C-Q> <Plug>BujoCheckinsert

" macros
let @s = 'i---fontsize: 12ptindent: truegeometry: margin=1inheader-includes: |	\usepackage{fancyhdr}	\fancyhead[L]{Jose Alessandro Tababa}\fancyhead[R]{January 1, 2000}\fancyfoot[L]{FILM 100}€kb\usepackage{setspace}	\doublespacing€kb€kb---€ýa '

" plugin settings
colorscheme gruvbox
au BufRead,BufNewFile *.fountain set filetype=fountain
let g:todo_done_filename = 'done.txt'
let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|markdown|markdown.pandoc|pandoc|org|rst|tex|text'
