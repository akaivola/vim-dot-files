" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" backups directory to /tmp
set backupdir=/tmp

" Tabs are 2 spaces
set tabstop=2
set shiftwidth=2

set nowrapscan
set ignorecase
set smartcase
set autoread

set clipboard=unnamed

" Display tabs and trailing spaces visually
" set list listchars=tab:\ \ ,trail:·

" Syntax highlighting
syntax on

" hide mouse while typing
set mousehide

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=1000	" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set wildmenu " file/command completion
set wildmode=list:longest
set title
set scrolloff=3 " Scrolling offset
set number " line numbers
" Grep with ack-grep
set grepprg=ack\ -a

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" single character insert
nmap <Space> i_<Esc>r

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Expand tabs to spaces
set expandtab

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " filetype plugin indent on
  " vundle requires filetype off
  filetype off

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  au FileType python setl sw=2 sts=2 et

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent		" always set autoindenting on

endif " has("autocmd")

set autoindent " ^ above seems to not work with f.ex. groovy.
colorscheme wombat

" neocompletecache
let g:neocomplcache_enable_at_startup = 1

" matching parenthesis
set showmatch

set undolevels=1000
set undofile
set undodir=~/.undo

set wildignore=*.swp,*.bak,*.class,node_modules/*

set noerrorbells
set nobackup
set noswapfile

set rnu

" paste stuff by hitting f2 in insert. Don't forget to hit f2 after
set pastetoggle=<F2>

" disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" just go to the next row in the editor instead of actual line
nnoremap j gj
nnoremap k gk

" arrows do Esc first
inoremap  <Up>     <Esc><Up>
inoremap  <Down>   <Esc><Down>
inoremap  <Left>   <Esc><Left>
inoremap  <Right>  <Esc><Right>

nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" sudo a file write by doing :w!!
cmap w!! w !sudo tee % > /dev/null

" sbt is scala syntax
au BufNewFile,BufRead *.sbt set filetype=scala

" gradle is groovy syntax
au BufNewFile,BufRead *.gradle set filetype=groovy

" wisp is lisp syntax
au BufNewFile,BufRead *.wisp set filetype=clojure

" jst is html
au BufNewFile,BufRead *.jst set filetype=html

let g:user_zen_settings = {
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \}

augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
augroup END

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'
Plugin 'L9'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'skammer/vim-css-color'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'gregsexton/gitv'
Plugin 'vim-coffee-script'
Plugin 'neocomplcache'
Plugin 'vim-scala'
Plugin 'SuperTab-continued.'
Plugin 'extradite.vim'
Plugin 'EasyMotion'
" After hitting p to paste, use ctrl-p or ctrl-n to cycle through paste options
Plugin 'YankRing.vim'
let g:yankring_manual_clipboard_check = 0
Plugin 'LargeFile'
Plugin 'vim-indent-object'
Plugin 'sjl/vitality.vim'
Plugin 'ctrlp.vim'
Plugin 'VimClojure'
Plugin 'gkz/vim-ls'
Plugin 'benmills/vimux'
Plugin 'xterm-color-table.vim'
Plugin 'mbbill/undotree'
Plugin 'vim-ipython'
Plugin 'amdt/vim-niji'
Plugin 'Arduino-syntax-file'

" ctrlp ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\node_modules$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Niji (rainbow parens filetypes)
let g:niji_matching_filetypes = ['lisp', 'clojure', 'wisp', 'scheme']

" Paredit
au FileType *.wisp call PareditInitBuffer()


filetype plugin indent on

" statusline
set statusline=\ "
set statusline+=%1*%-25.80f%*\ " file name minimum 25, maxiumum 80 (right justified)
set statusline+=%2*
set statusline+=%h "help file flag
set statusline+=%r "read only flag
set statusline+=%m "modified flag
set statusline+=%w "preview flag
set statusline+=%*\ "
set statusline+=%3*[
set statusline+=%{strlen(&ft)?&ft:'none'} " filetype
set statusline+=]%*\ "
set statusline+=%4*%{fugitive#statusline()}%*\ " Fugitive
set statusline+=%6*%{SyntasticStatuslineFlag()}%* " Syntastic Syntax Checking
set statusline+=%= " right align
set statusline+=%8*%-14.(%l,%c%V%)\ %<%P%* " offset
set laststatus=2

" Autosave when focus lost
autocmd BufLeave,FocusLost * silent! wall

" Auto compile coffeescript upon save
" autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow

" Remove all trailing whitespace upon save
autocmd BufWritePre * :%s/\s\+$//e

" Compile LiveScript
" nmap <C-K> :LiveScriptCompile<CR><C-W>k


" -------- vimux bindings ------------
" Run the current file with rspec
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>

" Prompt for a command to run
map <Leader>rp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>rl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>ri :VimuxInspectRunner<CR>

" Prompt for a command to run
map <LocalLeader>vp :VimuxPromptCommand<CR>

" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <LocalLeader>vs "vy:call VimuxRunCommand(@v . "\n", 0)<CR>

" Select current paragraph and send it to tmux
nmap <LocalLeader>vs vip<LocalLeader>vs<CR>

"--------- custom bindings"
map <Leader>t :tabnext<CR>
