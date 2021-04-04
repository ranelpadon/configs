let g:mapleader = "\<Space>"

let g:is_nvim = has('nvim')
let g:is_mvim = has('gui_running')
let g:is_vim = !g:is_nvim && !g:is_mvim

if g:is_nvim
    " `highlight.on_yank` is only in Nvim.
    au TextYankPost * silent! lua vim.highlight.on_yank {higroup='IncSearch', timeout=1000}

    " Substitution preview
    set inccommand=nosplit
endif

if g:is_mvim
    set guifont=Monaco\ Nerd\ Font:h12                                          " Include font icons
    set guioptions=                                                             " Hide the annoying scrollbars
endif

if g:is_vim
    " Inside Tmux, Vim/shell will use the `screen-256color`.
    set term=xterm-256color                                                     " 8-bit/256 colors in Vim's embedded terminal, error in Nvim
endif

if !g:is_nvim
    set nocompatible                                                            " Vim instead of vi
    syntax on                                                                   " Syntax highlighing
    set autoindent                                                              " Smart indention
    filetype on                                                                  " File type detection
    filetype plugin on                                                           " Load ftplugin hooks for the file type
    filetype indent on                                                           " Load indent hooks for the file type
    set autoread                                                                " Re-read files if modified outside Vim
    set background=dark                                                         " Dark mode
    set backspace=indent,eol,start                                              " Smart backspace
    set belloff=all                                                             " No event bells
    set encoding=utf-8                                                          " File encoding
    set hlsearch                                                                " Highlight search matches
    set incsearch                                                               " Highlight as you type your search.
    set laststatus=2                                                            " Always display the status line
    set ruler              			                                            " Show the cursor position
    set showcmd                                                                 " Show the run commands
    set smarttab                                                                " Smart tabbing based on tab settings
    set ttyfast                                                                 " Fast scroll
    set wildmenu                                                                " Command completion menu
endif

set shortmess+=I                                                                " Disable startup message
set t_Co=256                                                                    " 8-bit/256 colors in terminal
set termguicolors                                                               " 24-bit colors for in TUI, use `gui` instead of `cterm` attributes

set fileencoding=utf-8                                                           " The encoding written to file
set showtabline=2                                                               " Always show tabs, even if there's one file
set title                                                                       " Filename as window/tab name
set hidden                                                                      " Required to keep multiple buffers open multiple buffers

set mouse=a                                                                     " Enable mouse in all modes
set scrolloff=999                                                               " Cursor is always centered vertically
set number                                                                      " Line numbers
set relativenumber                                                              " Show the relative line number
set cursorline                                                                  " Highlight current line
set colorcolumn=80                                                              " Line wrap/column marker
set linebreak                                                                   " Break at word boundary
set iskeyword+=-                      	                                        " Treat dash-separated words as a word text object
set formatoptions-=cro                                                          " Stop newline continuation of comments
set whichwrap+=<,>,[,],h,l                                                      " Continue cursor to the start of new line when it reaches the edge
set nowrap                                                                      " Display long lines as just one line
set nofoldenable                                                                " Disable folding
set listchars=tab:▸\ ,eol:¬                                                     " Visualize tabs and newlines
set conceallevel=0                                                              " To see `` in markdown files

set tabstop=4                                                                   " Tab size in existing files
set expandtab                                                                   " Tab to spaces conversion in Insert mode
set softtabstop=4                                                               " Tab key/backspace stops
set shiftwidth=4                                                                " > indentation size
set smartindent                                                                 " Newline indention

set ignorecase                                                                  " Make searches case-insensitive
set smartcase                                                                   " Use /\C to force match capitalizations

set ttimeout                                                                    " Enable `ttimeout` so it could be overriden
set ttimeoutlen=500                                                             " Faster Esc/Ctrl key detection
set timeoutlen=500                                                              " Custom key sequences timeout, might affect Emmet if too low.
set updatetime=100                                                              " Faster auto-completion
set clipboard^=unnamed,unnamedplus                                              " Via Homebrew since the Mac version was compiled w/out clipboard integration

set cmdheight=2                                                                 " More space for displaying messages
set pumheight=10                                                                " Makes popup menu smaller
set helpheight=100                                                              " Display help files in 100 height
set wildmode=longest:full,full                                                  " Command mode popup

set noerrorbells
set visualbell                                                                  " Flash the screen instead of beeping on errors
set lazyredraw                                                                  " Avoid redrawing screen in macro since it's expensive

" SHADA (SHAred DAta) file of Nvim is in ~/.local/share/nvim/shada/main.shada
set directory=$HOME/.config/nvim/swp//
set nobackup
set nowritebackup
set undofile                                                                     " Save undo history across sessions
set undodir=$HOME/.config/nvim/undo