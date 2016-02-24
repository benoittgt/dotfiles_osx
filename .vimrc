"install VimPlug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/syntastic'
Plug 'thoughtbot/vim-rspec'
Plug 'rking/ag.vim'
Plug 'tpope/vim-rails'
Plug 'keith/rspec.vim'
Plug 'tpope/vim-commentary'
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-endwise' " Auto add 'end' after 'if'
Plug 'ervandew/supertab'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'pbrisbin/vim-mkdir'
Plug 'Shutnik/jshint2.vim', { 'for': 'javascript' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'janko-m/vim-test'
Plug 'ngmy/vim-rubocop'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'vim-airline/vim-airline-themes'

" Themes
" Plug 'christophermca/meta5'
" Plug 'NLKNguyen/papercolor-theme'

" ember
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'handlebars'}

" Quickscopes doesn't work properly with vim in iterm
if has('gui_running')
  Plug 'unblevable/quick-scope'
endif

call plug#end()

filetype plugin indent on

" Simple settings
syntax enable
set nocompatible
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
set incsearch

" Help me when I want to replace word surrounded by _
" set iskeyword-=_

" theme
set background=dark
colorscheme molokai
let g:airline_theme='molokai'

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

" I fail too often into Ex mode
nnoremap Q <nop>

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

" disable auto-opening of the NERDTree plugin at start
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" enable rainbowParenthese for ruby and js files
augroup rainbow_lisp
  autocmd!
  autocmd FileType ruby,javascript RainbowParentheses
augroup END
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" Indent pasted text
" nnoremap p pV`]=
" nnoremap P PV`]=

"""""" ruby specific
" call pry
abbreviate pry! binding.pry
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

" Define leader
let mapleader = "\<Space>"

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
nnoremap <Leader>t :CtrlPTag<CR><CR>

" Open tag list
nnoremap <Leader>v :CtrlPBuffer<CR><CR>

" Close current window
nnoremap <Leader>x :close<CR><CR>

" Search with Ag word under cursor
nnoremap <leader>k :exe 'Ag' expand('<cword>')<cr>

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

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Trigger a highlight only when pressing f and F.
let g:qs_highlight_on_keys = ['f', 'F']

" Add mapping to jump to sublime text for my co-workers
nnoremap <leader>st :! /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl % &<CR>

" Lint javascript when saved
let jshint2_save = 1
let jshint2_confirm = 0

" Rspec.vim mapping
map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>

" Rspec.vim run command
let g:rspec_command = "clear && rbr {spec}"
let g:rspec_runner = "os_x_iterm"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

" Convenient bindings for beginning and end of line.
nnoremap B ^
nnoremap E $

" Clear the search buffer.
nnoremap <leader><CR> :nohlsearch<CR>
