let g:mapleader = "\<Space>"

let g:is_nvim = has('nvim')
let g:is_mvim = has('gui_running')
let g:is_vim = !g:is_nvim && !g:is_mvim

if g:is_nvim
    " `highlight.on_yank` is only in Nvim.
    au TextYankPost * silent! lua vim.highlight.on_yank {higroup='IncSearch', timeout=300}

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

" These settings are auto-configured already in Neovim.
if !g:is_nvim
    set nocompatible                                                            " Vim instead of vi
    syntax on                                                                   " Syntax highlighing
    set autoindent                                                              " Smart indention
    filetype on                                                                 " File type detection
    filetype plugin on                                                          " Load ftplugin hooks for the file type
    filetype indent on                                                          " Load indent hooks for the file type
    set autoread                                                                " Re-read files if modified outside Vim
    set background=dark                                                         " Dark mode
    set backspace=indent,eol,start                                              " Smart backspace
    set belloff=all                                                             " No event bells
    set encoding=utf-8                                                          " File encoding
    set hlsearch                                                                " Highlight search matches
    set incsearch                                                               " Highlight as you type your search.
    set laststatus=2                                                            " Always display the status line
    set ruler                                                                   " Show the cursor position
    set showcmd                                                                 " Show the run commands
    set smarttab                                                                " Smart tabbing based on tab settings
    set ttyfast                                                                 " Fast scroll
    set wildmenu                                                                " Command completion menu
endif

" `:h shortmess` is a text, so use concatenation.
set shortmess+=I                                                                " Disable startup message
" Has issue with auto-cursor centering like `nzz`.
set shortmess-=S                                                                " Show search count (S: means do not show search count, so we negate it)
set t_Co=256                                                                    " 8-bit/256 colors in terminal
set termguicolors                                                               " 24-bit colors for in TUI, use `gui` instead of `cterm` attributes

set fileencoding=utf-8                                                          " The encoding written to file
set showtabline=2                                                               " Always show tabs, even if there's one file
set title                                                                       " Filename as window/tab name
set hidden                                                                      " Required to keep multiple buffers open multiple buffers

set mouse=a                                                                     " Enable mouse in all modes
" set scrolloff=999                                                             " Cursor is always centered vertically
" Toggling [relative]number: set [r]nu!
set number                                                                      " Line numbers
set relativenumber                                                              " Show the relative line number
set cursorline                                                                  " Highlight current line
set colorcolumn=80                                                              " Line wrap/column marker
set linebreak                                                                   " Break at word boundary
set iskeyword+=-                      	                                        " Treat dash-separated words as a word text object
set formatoptions-=cro                                                          " Stop auto-commenting for new lines.
set whichwrap+=<,>,[,],h,l                                                      " Continue cursor to the start of new line when it reaches the edge

" Fold by default to reduce clutter.
set foldmethod=indent
" set foldclose=all
set foldlevelstart=99
set foldnestmax=4

set listchars=tab:▸\ ,eol:¬                                                     " Visualize tabs and newlines
set conceallevel=0                                                              " To see `` in markdown files

set tabstop=4                                                                   " Tab size in existing files
set expandtab                                                                   " Tab to spaces conversion in Insert mode
set softtabstop=4                                                               " Tab key/backspace stops
set shiftwidth=4                                                                " > indentation size
set shiftround                                                                  " indent to nearest indentatin

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
" set directory=$HOME/.config/nvim/swp//
set noswapfile
set nobackup
set nowritebackup
set undofile                                                                    " Save undo history across sessions
set undodir=$HOME/.config/nvim/undo

" Define the default Py2/Py3 versions to avoid relying in the active env.
" Py2
let g:python_host_prog = '/opt/homebrew/Caskroom/miniforge/base/envs/ticketing/bin/python'
" Py3
let g:python3_host_prog = '/opt/homebrew/Caskroom/miniforge/base/envs/py311/bin/python'

" To check the buffer's filetype:
" set filetype?
"
" To define the filetype commentstring, add new <FILETYPE>.vim:
" nvim/after/ftplugin/<FILETYPE>.vim

" Better DX with YAML files.
autocmd FileType yml set cursorcolumn
autocmd FileType yaml set cursorcolumn


" `smartindent` is superseded by `autoindent` and generally useless.
" It also causes issue when inserting the comment character:
" the comment character is being put in the start of line
" instead of indenting it.
" https://stackoverflow.com/questions/2063175/comments-go-to-start-of-line-in-the-insert-mode-in-vim
" https://stackoverflow.com/questions/18415492/autoindent-is-subset-of-smartindent-in-vim/18415867#18415867
" au! FileType python setl nosmartindent
" autocmd BufRead *.py inoremap # X<c-h>#
" https://linuxhint.com/use-auto-indent-in-vim/
" https://www.reddit.com/r/vim/comments/erjyhl/smartindent_vs_cindent/
" `autoindent`: this method uses indent from the previous line for the file type you are editing.
" `smartindent`: works similarly to autoindent but recognizes the syntax for some languages such as C language.
" `cindent`: slightly different from autoindent and smartindent as it is more clever and is configurable to various indexing styles.
" set smartindent                                                               " Newline indention
" `:help  c-indenting`
" set cindent                                                                   " Potentially useful as well.

" Don't render markdown files.
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
