" VROOM VROOM

" Load pathogen for sane plugin management.
filetype off
execute pathogen#infect()
filetype plugin indent on
syntax on
set nocompatible

" Basics
set history=100
set undolevels=100
set visualbell " shut up
set noerrorbells " shut up
set showmatch " highlight matching parenthesis and braces
set autoindent
set nobackup      " stop vim from creating ugly backup files
set nowritebackup " stop vim from creating ugly backup files
set noswapfile    " stop vim from creating ugly backup files
set autowrite " automatically save when changing buffers
set autoread " automatically update buffer if file changes
set nostartofline " do not change column when moving between lines
set encoding=utf-8
set showcmd " show incomplete commands
set ruler " always show cursor info
set backspace=indent,eol,start " deleting will work across lines like any normal app: http://vim.wikia.com/wiki/Backspace_and_delete_problems

" better tabs
set tabstop=2 shiftwidth=2
set expandtab

" better search
set hlsearch " highlights search terms
set incsearch " show search matches while typing
set ignorecase " ignore case when searching
set smartcase " ignore case if search pattern is all lowercase

" Themes and Colors
set background=dark
colorscheme spacegray
set guifont=Menlo\ Regular:h12 " (GUI-only)
set linespace=2 " (GUI-only)

" UI
set number " show line numbers
set linebreak
set cursorline
set showbreak=→
set nowrap
set textwidth=80 " make it obvious where 79 characters is
set colorcolumn=+1 " draw a line after 79 characters

" Special Things
let mapleader=" "

" highlight end-of-line whitespace: http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

" save on losing focus (GUI-only)
au FocusLost * :wa

" make it so you can use : commands without needing shift
nnoremap ; :

" quicker exit to normal
inoremap jj <ESC>

" switches between last two files
nnoremap <leader><leader> <c-^>

" LOLOLOL I blame @inconvergent for this.
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
