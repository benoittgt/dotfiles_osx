"install VimPlug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'thoughtbot/vim-rspec'
Plug 'rking/ag.vim'
Plug 'tpope/vim-rails'
Plug 'keith/rspec.vim'
Plug 'tpope/vim-commentary'
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise' " Auto add 'end' after 'if'
Plug 'ervandew/supertab'
Plug 'pbrisbin/vim-mkdir'
Plug 'scrooloose/syntastic', { 'for': 'javascript' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'janko-m/vim-test'
Plug 'ngmy/vim-rubocop'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'shime/vim-livedown', { 'for': 'markdown' }
Plug 'miyakogi/conoline.vim'
Plug 'AndrewRadev/writable_search.vim'
Plug 'aliou/sql-heredoc.vim'
Plug 'othree/yajs.vim'
Plug 'junegunn/vim-easy-align'
" Theme
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'rhysd/vim-color-spring-night'
Plug 'chriskempson/vim-tomorrow-theme'

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
set relativenumber
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

""" Theme
set background=dark
set laststatus=2
set guifont=Droid_Sans_Mono_for_Powerline:h11
let g:conoline_use_colorscheme_default_insert=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme selection
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Night()
  colorscheme spring-night
  hi! BufTabLineActive cterm=underline ctermfg=233 ctermbg=132 gui=underline guifg=#334152 guibg=#a9667a
  hi! BufTabLineCurrent ctermfg=233 ctermbg=132 guifg=#334152 guibg=#a9667a
  hi! BufTabLineHidden ctermfg=230 ctermbg=238 guifg=#fffeeb guibg=#536273
  let g:conoline_color_normal_dark = 'guibg=#435060 gui=None '
                           \. 'ctermbg=235'
  let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
:command! Night :call Night()

function! Dark()
  colorscheme Tomorrow-Night-Bright
  hi! BufTabLineFill guibg=Black
  hi! BufTabLineActive guibg=#424242
  hi! BufTabLineCurrent guifg=#262626 guibg=#afdf00
  hi! BufTabLineHidden guifg=#eaeaea
  let g:conoline_color_normal_dark = 'guibg=#2a2a2a gui=None '
        \. 'ctermbg=234'
  let g:lightline = { 'colorscheme': 'powerline', }
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
:command! Dark :call Dark()

Dark
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

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
abbreviate descrive describe
let ruby_space_errors = 1
let ruby_no_expensive = 1

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
imap jk <ESC>:w<CR>

" Remap ctags
nmap <C-T> <C-]>

" Select matching bracket
noremap % v%

" Defineleader
let mapleader = "\<Space>"

" Buffer movements
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

" Search where the rails partial have been called
nnoremap <leader>j :exe "Ag! " . substitute(expand("%:t:r:r"), "^_", "", "") . " app/views"

" Close the quickfix window. Don't need more for the moment
noremap <Leader>e :ccl <bar> lcl<CR>

" Lazy js. Append ; or , at the end of the line
nnoremap <Leader>; m`A;<Esc>``
nnoremap <Leader>, m`A,<Esc>``

" Ctags the project silently
nnoremap <leader>ct :silent ! ctags -R --languages=ruby --exclude=.git --exclude=log -f .tags<CR>

" Add mapping to jump to sublime text for my co-workers
nnoremap <leader>st :! /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl % &<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Relativenumber line number
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-b> :call NumberToggle()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Split long lines with dots
command! SplitDot let _s=@/ <bar> s/\v\.\w+%(\([^)]+\)|\{[^}]+})*/\r\0/g <bar> let @/=_s <bar> keepjumps normal! ``=']']
nnoremap <Leader>s :SplitDot<CR>

" Rspec.vim run command
let g:rspec_command = "clear && bin/rspec {spec}"
let g:rspec_runner = "os_x_iterm"

" Yank current line and file path
" let @+=join([expand('%'),  line(".")], ':')

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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE .. Thanks Gary Bernhardt
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
:command! RenameFile :call RenameFile()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_jshint_args = '--config ~/.jshintrc'

" jump in listings (syntastic failure list)
nnoremap <Leader>n :lnext<CR>
nnoremap <Leader>p :lprevious<CR>

" Reload vimrc when saving
augroup reload_vimrc " {
  autocmd!
  autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END " }

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
