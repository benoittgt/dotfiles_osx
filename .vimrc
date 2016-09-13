"install VimPlug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ap/vim-buftabline'
Plug 'ntpeters/vim-better-whitespace'
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
Plug 'pbrisbin/vim-mkdir'
Plug 'Shutnik/jshint2.vim', { 'for': 'javascript' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'janko-m/vim-test'
Plug 'ngmy/vim-rubocop'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'itchyny/lightline.vim'
Plug 'shime/vim-livedown', { 'for': 'markdown' }
Plug 'miyakogi/conoline.vim'
Plug 'elentok/replace-all.vim'
" Plug 'airblade/vim-gitgutter'


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

" Theme
set background=dark
colorscheme Tomorrow-Night-Bright
" Buftabline colors
hi! BufTabLineFill guibg=Black
hi! BufTabLineActive guibg=DarkMagenta
hi! BufTabLineCurrent guifg=#262626 guibg=#afdf00
hi! BufTabLineHidden guifg=#eaeaea

" History
" Remember more commands and search history
set history=1000

" Keep 5 lines below and above the cursor
set scrolloff=5

" Cursor line
" set cursorline
" hi CursorLine guibg=#0d0d0d

" Maximum number of changes that can be undone
set undolevels=1000
" Maximum number lines to save for undo on a buffer reload
set undoreload=1000
set hidden

set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
set guifont=Droid_Sans_Mono_for_Powerline:h11
let g:airline_powerline_fonts = 1

" Vim markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Autosave when lost focus
au FocusLost * :wa
au FocusLost * silent! wa
set autowrite

"""""""""""""""""""""""""""""""""""""""""
" CTRLP settings
" More result with ctrlp
let g:ctrlp_match_window = 'min:4,max:40'
" Max MRU entries to remember
let g:ctrlp_mruf_max = 25

" Ignore temp folder
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"""""""""""""""""""""""""""""""""""""""""

" Disable the right scroll bar on macvim
set guioptions-=r

" Disable the left scroll bar on macvim in NerdTree
set guioptions-=L

" Disable auto-opening of the NERDTree plugin at start
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" # to surround with ruby string interpolation
let g:surround_35 = "#{\r}"

" Enable rainbowParenthese for ruby and js files
" augroup rainbow_lisp
"   autocmd!
"   autocmd FileType ruby,javascript RainbowParentheses
" augroup END
" let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" Indent pasted text
nnoremap p p`[v`]=
nnoremap P P`[v`]=

" Quickly select the text that was just pasted. This allows you to, e.g.,		
" indent it after pasting.		
noremap gV `[v`]

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

"""""" ruby specific
" Call pry
abbreviate p! binding.pry
abbreviate rlog Rails::logger.info " \n"
let ruby_space_errors = 1
let ruby_no_expensive = 1
" let ruby_operators = 1
" let ruby_spellcheck_strings = 1

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

" I fail too often into Ex mode
nnoremap Q <nop>

" Avoid Escape key
imap jj <Esc>

" Avoid Escape key
imap jk <ESC>:w<RETURN>

" Remap ctags
nmap <C-T> <C-]>

" Select matching bracket
noremap % v%

" Define leader
let mapleader = "\<Space>"

" Buffer movements
" map <up> <ESC>:ls<RETURN>
" map <down> <ESC>:Bclose<RETURN>
" map <left> <ESC>:bp<RETURN>
" map <right> <ESC>:bn<RETURN>
nnoremap <Leader>h :bp<CR>
nnoremap <Leader>l :bn<CR>

" Show next jshint error
nnoremap <leader>m :lnext<CR>

" Quick Ag access. Thanks Thoughtbot
nnoremap \ :Ag!<SPACE>

" Split properly to the alternate file with rails.vim
nnoremap <leader>u :execute 'AS' <bar> wincmd J<CR>
command! ASB :execute 'AS' | wincmd J

" Save file with leader
nnoremap <Leader>w :w<CR>

" Close buffer
nnoremap <Leader>d :Bclose<CR>

" Closse all buffers
nnoremap <Leader>D :bufdo bd<CR>

" Quit vim
nnoremap <Leader>q :wq<CR>

" Open buffer list
nnoremap <Leader>t :CtrlPTag<CR><CR>

" Open tag list
nnoremap <Leader>v :CtrlPBuffer<CR><CR>

" Open Most Recent Used files
nnoremap <Leader>b :CtrlPMRU<CR><CR>

" Close current window
nnoremap <Leader>x :close<CR><CR>

" Search with Ag word under cursor in all the project
nnoremap <leader>K :exe 'Ag!' expand('<cword>')<cr>

" Search with Ag word under cursor file under app
nnoremap <leader>k :exe 'Ag!' expand('<cword>') 'app lib'<cr>

" Close the quickfix window. Don't need more for the moment
noremap <Leader>e :ccl <bar> lcl<CR>

" Lazy js. Append ; or , at the end of the line
nnoremap <Leader>; m`A;<Esc>``
nnoremap <Leader>, m`A,<Esc>``

" Ctags the project silently
nnoremap <leader>ct :silent ! ctags -R --languages=ruby --exclude=.git --exclude=log -f .tags<CR>

" Add mapping to jump to sublime text for my co-workers
nnoremap <leader>st :! /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl % &<CR>

" Relativenumber line number
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-b> :call NumberToggle()<CR>

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Trigger a highlight only when pressing f and F.
let g:qs_highlight_on_keys = ['f', 'F']

" Lint javascript when saved
let jshint2_save = 1
let jshint2_confirm = 0

" Rspec.vim mapping
map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rn :call RunNearestSpec()<CR>
" map <Leader>rl :call RunLastSpec()<CR>

" Split long lines with dots
" nnoremap <Leader>s :s/^  // <Bar> s/\v\ze%(\(\w+%(\.\w+)*)@<!\./\="\n " . matchstr(getline('.'), '^\s*')/g<CR>
command! SplitDot let _s=@/ <bar> s/\v\.\w+%(\([^)]+\)|\{[^}]+})*/\r\0/g <bar> let @/=_s <bar> keepjumps normal! ``=']']
nnoremap <Leader>s :SplitDot<CR>

" Rspec.vim run command
let g:rspec_command = "clear && bin/rspec {spec}"
let g:rspec_runner = "os_x_iterm"

" Yank current line and file path
let @+=join([expand('%'),  line(".")], ':')

" Git commit message warp
autocmd Filetype gitcommit setlocal spell textwidth=72

" yml files spell
autocmd BufRead,BufNewFile *.fr.yml setlocal spelllang=fr spell
autocmd BufRead,BufNewFile *.en.yml setlocal spell

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

" Clear the search buffer.
nnoremap <leader><CR> :nohlsearch<CR>

" Remove Ruby syntax 1.9
:command! RubyHashSyntaxUpdate :%s/:\([a-z_]*\) =>/\1:/g

" Prefere *_spec.rb rather than *_test.rb with :A
let g:rails_projections = {
      \  'app/*.rb': {
      \     'alternate': 'spec/{}_spec.rb'
      \   },
      \  'spec/*_spec.rb': {
      \     'alternate': 'app/{}.rb'
      \   }
      \}

" Avoid laging with matchparen plugin
let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20
