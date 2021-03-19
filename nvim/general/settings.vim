let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set whichwrap+=<,>,[,],h,l              " Continue cursor to the start of new line when it reaches the edge
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                   " The encoding written to file
set ruler              			        " Show the cursor position all the time
set cc=120
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse, allow scroll/resizing in iTerm2 with mouse 
set t_Co=256                            " Support 256 colors
set t_ut=
set conceallevel=0                      " So that I can see `` in markdown files
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set backspace=indent,eol,start
set smartindent                         " Makes indenting smart
set showtabline=2                       " Always show tabs
set laststatus=2                        " Always display the status line
set guioptions-=e                       " Don't use GUI tabline
set showcmd                             " show incomplete commands at the bottom
set number                              " Line numbers
set relativenumber                      " show the relative line number
set background=dark                     " tell vim what the background color looks like
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continuation of comments
set clipboard^=unnamed,unnamedplus      " need to install vim via Homebrew since the Mac version was compiled w/out clipboard integration

set helpheight=100
set wildmenu
set wildmode=longest:full,full
set noerrorbells
set autoread                            " automatically re-read files if unmodified inside Vim
set visualbell                          " flash the screen instead of beeping on errors.
set title
set lazyredraw                          " avoid redrawing screen in running macro since it's expensive
"set autochdir                          " Your working directory will always be the same as your working directory

" whitespace color: https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
" faster ESC key, need to enable `ttimeout` before it could be overriden.
set ttimeout
set ttimeoutlen=100

" INDENTATION
set autoindent
filetype plugin indent on                " enable indenting for files
set tabstop=4                           " existing tab size is 4
set softtabstop=4                       " OTF tab to space conversion
set shiftwidth=4                        " > indentation size is 4
set expandtab                           " auto-converts tabs to spaces


" SEARCH
set hlsearch                            " highlight matches by default
set incsearch                           " highlight as you type your search.
set ignorecase                          " make searches case-insensitive.
set smartcase                           " unless you type a capital, use /\C to force match capitalizations.


" SWAP AND BACKUP
set directory=$HOME/.config/nvim/swp//
set nobackup
set nowritebackup
set undofile                             " save undo history across sessions
set undodir=$HOME/.vim/undodir


" TEXT RENDERING
set ttyfast
set scrolloff=999                       " the cursor is centered vertically if posible (even in search mode?)
set linebreak                           " break at word boundary
set listchars=tab:▸\ ,eol:¬             " visualize tabs and newlines
set cursorline                          " highlight current line

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

" You can't stop me
cmap w!! w !sudo tee %
