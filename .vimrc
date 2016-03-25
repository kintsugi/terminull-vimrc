set nocompatible    " be iMproved, required
filetype off        " required
syntax enable

colorscheme solarized      " See color schemes in ~/.vim/colors

" QoL Shortcuts
" Rolling fingers over jk resets to command mode
" leader is comma
let mapleader=","
inoremap jk <ESC>
" Efficiently go into command line mode
nnoremap ; :
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Use Enter to insert a line below
nmap <CR> o<Esc>
" User double enter to insert a line above
nmap <CR><CR> O<Esc>
" use ,/ to clear highlighted search
nmap <silent> ,/ :nohlsearch<CR>
" NERDTree toggle
map <C-n> :NERDTreeToggle<CR>
" Command to trim whitespace from end of lines
command Trim %s/\s\+$//e
" save session
nnoremap <leader>s :mksession<CR>

" Editor Settings
" A tab is 2 space characters with the size of two space characters
set tabstop=2       " Sets the visual appearance of a tab to 2 spaces
set shiftwidth=2    " Sets the # of tabs the << and >> operatorations indent
set softtabstop=2   " Sets the # of columns used when tab is pressed
set expandtab       " Turn all tabs into spaces
set smarttab        " insert tabs on the start of a line
set autoindent      " Better indenting, used with smart indent
set smartindent     " See :h autoindent and :h smartindent for details
set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'

set nowrap          " don't wrap lines
set hidden          " QoL Buffer. Popular but not 100% sure of the effect. See
                    " :h hidden
set showmatch       " set show matching parenthesis
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is all lowercase,
set incsearch       " show search matches as you type
set hlsearch        " highlight search terms
set wildignore=*.swp,*.bak,*.pyc,*.class
set title           " change the terminal's title
set visualbell      " don't beep
set noerrorbells    " don't beep
set mouse=a
set number          " Show line numbers.
set cursorline      " highlight current line
set wildmenu        " visual autocomplete for command menu
set laststatus=2    " vim-airline will not show when there is no split window
set ttimeoutlen=50  " without these two:  https://github.com/vim-airline/vim-airline/issues/130

"Place backups in a tmp folder
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

"Quit when quitting and NERDTree is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


let g:airline_section_d= '%{strftime("%c")}'  " vim-airline current time
let g:airline#extensions#tabline#enabled=1    " enable tabline
let g:airline#extensions#branch#enabled=1     " enable git branch info

" Vundle Plugin Manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'flazz/vim-colorschemes'         " Nice colorscheme repo
Plugin 'scrooloose/nerdtree'            " View directories
Plugin 'thinca/vim-localrc'             " vimrc for a specific directory
                                        " http://www.vim.org/scripts/script.php?script_id=3393
Plugin 'tpope/vim-fugitive'             " Git wrapper
Plugin 'vim-airline/vim-airline'        " status bar
Plugin 'vim-airline/vim-airline-themes' " color themes for status bar
Plugin 'tpope/vim-surround'             " surround words with characters
Plugin 'Raimondi/delimitMate'           " Better closing brackets etc.
Plugin 'scrooloose/nerdcommenter'       " Better commenting
Plugin 'Valloric/YouCompleteMe'         " Autocompletion Engine
Plugin 'rdnetto/YCM-Generator'          " Auto generates config file for C family autocompletion
Plugin 'jeaye/color_coded'              " Color coding

" Plugin HiCursorWords is used, but there is no git repo:
" http://www.vim.org/scripts/script.php?script_id=4306
" For highlighting exact matches of the variable under the cursor

call vundle#end()            " required
filetype plugin indent on    " required

" end of terminull's vimrc
" ******************************************************************************
" Default vimrc from vimtutor
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set t_Co=256
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif
