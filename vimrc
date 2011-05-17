
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
set grepprg=ack-grep\ -a

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

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

set wildignore=*.swp,*.bak,*.class

set noerrorbells
set nobackup
set noswapfile

" paste stuff by hitting f2 in insert. Don't forget to hit f2 after
set pastetoggle=<F2>

" just to the next row in the editor instead of actual line
nnoremap j gj
nnoremap k gk

" sudo a file write by doing :w!!
cmap w!! w !sudo tee % > /dev/null

let g:user_zen_settings = {
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \}

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'L9'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'skammer/vim-css-color'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'

filetype plugin indent on

" statusline

" Autosave when focus lost
autocmd BufLeave,FocusLost silent! wall
