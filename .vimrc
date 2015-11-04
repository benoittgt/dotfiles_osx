"status Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" The mapleader has to be set before vundle starts loading all the plugins.
let mapleader = "\<Space>"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'terryma/vim-expand-region'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'thoughtbot/vim-rspec'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-rails'
Plugin 'keith/rspec.vim'
Plugin 'tpope/vim-commentary'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-endwise' " Auto add 'end' after 'if'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'ervandew/supertab'
Plugin 'unblevable/quick-scope'
Plugin 'nathanaelkane/vim-indent-guides' " Dam lost in my test
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'

" Themes
Plugin 'christophermca/meta5'
Plugin 'NLKNguyen/papercolor-theme'

" Plugin 'skwp/vim-iterm-rspec'
" Plugin 'mattn/emmet-vim'

" ember
Plugin 'scrooloose/nerdtree'
Plugin 'mustache/vim-mustache-handlebars'

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

" don't show warnings when saving go file
let g:go_fmt_fail_silently = 1

"""""""""""""""""""""""""""""""""""""""""
" CTRLP settings
" more result with ctrlp
let g:ctrlp_match_window = 'min:4,max:40'

" ignore temp folder
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"""""""""""""""""""""""""""""""""""""""""

" disable the right scroll bar on macvim
set guioptions-=r

" Indent pasted text
nnoremap p pV`]=
nnoremap P PV`]=

" Be able to copy-past path to clipboard
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

" Avoid typing error when saving or leaving
cnoreabbrev W w
cnoreabbrev Wq wq

" search visual selected text
vnoremap // y/<C-R>"<CR>

" Avoid Escape key
imap jj <Esc>

" Avoid Escape key
imap jk <ESC>:w<RETURN>

" nnoremap <C-p> :bprevious<CR>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Remap ctags
nmap <C-T> <C-]>

" vim-expand
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" select matching bracket
noremap % v%

" disable F1
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" buffer movements
map <up> <ESC>:ls<RETURN>
map <down> <ESC>:bd<RETURN>
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

" Relativenumber line disable
" function! DisableRelativeLineNumber()
"   if(&relativenumber == 1)
"     set norelativenumber
"     set number
"   endif
" endfunc

" Disable relative number when losing focus
" au FocusLost * :call DisableRelativeLineNumber()

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

" Close nerdtree if the only remaining window is a nerdtree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
