" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree' " File system explorer
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Syntax checking
Plug 'scrooloose/syntastic' " Check syntax asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'sheerun/vim-polyglot'
Plug 'fxn/vim-monochrome'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
call plug#end()

" Basics
set history=1000
set undolevels=1000
set visualbell	    " shut up
set noerrorbells    " shut up
set showmatch
set autoindent
set nobackup	    " stop vim from creating ugly backup files
set nowritebackup   " stop vim from creating ugly backup files
set noswapfile	    " stop vim from creating ugly backup files
set autowrite
set autoread	    " automatically update buffer if file changes
set nostartofline   " do not change column when moving between lines
set encoding=utf-8
set showcmd	    " show incomplete commands
set ruler	    " always show cursor info
set backspace=indent,eol,start  " deleting will work across lines like any normal app: http://vim.wikia.com/wiki/Backspace_and_delete_problems

" better tabs
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4

" better search
set hlsearch	    " highlights search terms
set incsearch	    " show search matches while typing
set ignorecase	    " ignore case when searching
set smartcase	    " ignore case if search pattern is all lowercase

" UI
colorscheme monochrome
set number	    " show line numbers
set linebreak
set cursorline
set showbreak=+++
set nowrap
set textwidth=79    " make it obvious where 79 characters is
set colorcolumn=+1  " draw a line after 79 characters
set termguicolors
set background=dark

" highlight end-of-line whitespace: http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=white guibg=white

" quicker exit to normal
inoremap jj <ESC>

" switches between last two files
nnoremap <leader><leader> <c-^>

" NERDTree settings
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" FZF settings

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
