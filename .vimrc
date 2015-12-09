"status Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" The mapleader has to be set before vundle starts loading all the plugins.
let mapleader = "\<Space>"

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle, required
Plug 'gmarik/Vundle.vim'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'terryma/vim-expand-region'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'thoughtbot/vim-rspec'
Plug 'albfan/ag.vim'
Plug 'tpope/vim-rails'
Plug 'keith/rspec.vim'
Plug 'tpope/vim-commentary'
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-endwise' " Auto add 'end' after 'if'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'ervandew/supertab'
Plug 'unblevable/quick-scope'
Plug 'nathanaelkane/vim-indent-guides' " Dam lost in my test
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'pbrisbin/vim-mkdir'
Plug 'stefanoverna/vim-i18n'
Plug 'Shutnik/jshint2.vim'

" Themes
Plug 'christophermca/meta5'
Plug 'NLKNguyen/papercolor-theme'

" Plug 'skwp/vim-iterm-rspec'
" Plug 'mattn/emmet-vim'

" ember
Plug 'scrooloose/nerdtree'
Plug 'mustache/vim-mustache-handlebars'

call plug#end()

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
set noeol "no new line at the end of the file

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
set undolevels=1000
"maximum number lines to save for undo on a buffer reload
set undoreload=1000
set hidden

set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
set guifont=Droid_Sans_Mono_for_Powerline:h11
let g:airline_powerline_fonts = 1

" vim markdown
au BufRead,BufNewFile *.md set filetype=markdown

" autosave when lost focus
au FocusLost * :wa
au FocusLost * silent! wa
set autowrite

"""""""""""""""""""""""""""""""""""""""""
" CTRLP settings
" more result with ctrlp
let g:ctrlp_match_window = 'min:4,max:40'

" ignore temp folder
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"""""""""""""""""""""""""""""""""""""""""

" disable the right scroll bar on macvim
set guioptions-=r

" disable the left scroll bar on macvim in NerdTree
set guioptions-=L

" Indent pasted text
nnoremap p pV`]=
nnoremap P PV`]=

" Be able to copy path to clipboard
let @+ = expand("%")

"""""" ruby specific
" call pry
abbreviate pry! require 'pry'; binding.pry
abbreviate rlog Rails::logger.info " \n"

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

" Avoid Escape key
imap jj <Esc>

" Avoid Escape key
imap jk <ESC>:w<RETURN>

" Remap ctags
nmap <C-T> <C-]>

" vim-expand
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" select matching bracket
noremap % v%

" buffer movements
map <up> <ESC>:ls<RETURN>
map <down> <ESC>:Bclose<RETURN>
map <left> <ESC>:bp<RETURN>
nnoremap <Leader>h :bp<CR>
map <right> <ESC>:bn<RETURN>
nnoremap <Leader>l :bn<CR>

" Save file with leader
nnoremap <Leader>w :w<CR>

" Comment line with leader
nnoremap <Leader>c :Commentary<CR>
vmap <Leader>c :Commentary<CR>

" Close buffer
nnoremap <Leader>d :bd<CR>

" Quit vim
nnoremap <Leader>q :wq<CR>

" Open buffer list
nnoremap <Leader>t :CtrlPTag<SPACE>

" Open tag list
nnoremap <Leader>v :CtrlPBuffer<CR><CR>

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

"lazy js. Append ; at the end of the line
nnoremap <Leader>; m`A;<Esc>``
nnoremap <Leader>, m`A,<Esc>``

" QuickScope toggle for highlighting current letter to jump
" from https://gist.github.com/cszentkiralyi/dc61ee28ab81d23a67aa

let g:qs_enable = 0
let g:qs_enable_char_list = [ 'f', 'F', 't', 'T' ]

function! Quick_scope_selective(movement)
    let needs_disabling = 0
    if !g:qs_enable
        QuickScopeToggle
        redraw
        let needs_disabling = 1
    endif
    let letter = nr2char(getchar())
    if needs_disabling
        QuickScopeToggle
    endif
    return a:movement . letter
endfunction

for i in g:qs_enable_char_list
	execute 'noremap <expr> <silent>' . i . " Quick_scope_selective('". i . "')"
endfor

" Add mapping to jump to sublime text for my co-workers
nnoremap <leader>st :! /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl % &<CR>

" Lint javascript when saved
let jshint2_save = 1
let jshint2_confirm = 0
