"status Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'terryma/vim-expand-region'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'thoughtbot/vim-rspec'
Plugin 'mbbill/undotree'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-rails'
Plugin 'keith/rspec.vim'
Plugin 'tpope/vim-commentary'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-endwise' " Auto add 'end' after 'if'
Plugin 'ecomba/vim-ruby-refactoring'

"ruby block select
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'

call vundle#end()      " required

filetype plugin indent on

" Simple settings
syntax enable
set number
set autoindent
set ruler
set expandtab
set tabstop=4
set showmatch
set smartcase
set ignorecase
set hlsearch
set t_vb=
set shiftwidth=2
set scrolloff=3
set showcmd
set ruler
set backspace=indent,eol,start
set cpoptions+=$
set tags+=.tags

" theme
set background=dark
colorscheme molokai

" History
set history=1000         " remember more commands and search history

" Keep 5 lines below and above the cursor
set scrolloff=5

" cursor line
set cursorline
hi CursorLine guibg=Grey15

"maximum number of changes that can be undone
set undolevels=10000
"maximum number lines to save for undo on a buffer reload
set undoreload=100000
set hidden

set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" vim markdown
au BufRead,BufNewFile *.md set filetype=markdown

" autosave when lost focus
au FocusLost * :wa
au FocusLost * silent! wa
set autowrite

" don't show warnings when saving go file
let g:go_fmt_fail_silently = 1

" undotree
set undofile
set undodir='~/.undodir/'

" more result with ctrlp
let g:ctrlp_match_window = 'min:4,max:40'

"""""" map
" window movements
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Proper indent when pasting
nnoremap p p==
nnoremap <S-p> <S-p>==

" search visual selected text
vnoremap // y/<C-R>"<CR>

" nnoremap <C-p> :bprevious<CR>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Remap ctags
nmap <C-T> <C-]>

" Map CtrlPTags
noremap <C-i> :CtrlPTag<CR>

" vim-expand
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" select matching bracket
noremap % v%

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" disable F1
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" buffer movements
map <up> <ESC>:ls<RETURN>
map <down> <ESC>:buffer<SPACE>
map <left> <ESC>:bp<RETURN>
map <right> <ESC>:bn<RETURN>

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" relativenumber line number
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-b> :call NumberToggle()<CR>
