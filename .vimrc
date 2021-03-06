set nocompatible                                                                " use Vim settings instead of vi
filetype off                                                                     " turn filetype detection off and, even if it's not strictly
filetype plugin indent off                                                       " necessary, disable loading of indent scripts and filetype plugins

" https://medium.com/@jeantimex/how-to-configure-iterm2-and-vim-like-a-pro-on-macos-e303d25d5b5c
" vim-plug package manager
" https://github.com/junegunn/vim-plug#example
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'vim-scripts/FavEx'


" FZF
" If installed using Homebrew
set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'haya14busa/vim-asterisk'
Plug 'RRethy/vim-tranquille'
Plug 'justinmk/vim-sneak'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 'voldikss/vim-floaterm'

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'
Plug 'bronson/vim-trailing-whitespace'

Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'machakann/vim-highlightedyank'

call plug#end()


let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'tabline': {
    \   'left': [ ['buffers'] ],
    \   'right': [ [] ]
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ }
    \ }
set showtabline=2                                                               " Show tabline
set guioptions-=e                                                               " Don't use GUI tabline
set laststatus=2

" tmux compatibility
" use 256 colors in terminal
if !has("gui_running")
    set t_Co=256
    set term=xterm-256color
endif
set background=dark
set t_ut=

" ========= Put your non-Plugin stuff after this line


" Space as leader key.
map <Space> <leader>


" ENTER key
" https://vim.fandom.com/wiki/Insert_newline_without_entering_insert_mode
" Open a line before the current line (usual case)
nnoremap <Enter> O<Esc>j
" Open a line after the current line.
nnoremap <S-Enter> o<Esc>k


" FavEx (/Users/ranelpadon/\.vim/plugged/FavEx/favlist)

noremap <Leader>fa :FF<CR>                                                      " fav add
noremap <Leader>fl :FE<CR>                                                       " fav list


" NETRW / Nerdtree-like setup
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :Lexplore
augroup END

"unmap \fe
autocmd VimEnter * noremap <Leader>fe :Lex<CR>
noremap <Leader>e :Lex<CR>
" Wipe previous netrw buffer
augroup AutoDeleteNetrwHiddenBuffers
    au!
    au FileType netrw setlocal bufhidden=wipe
augroup end


" FILE PATHS
" absolute path  (/something/src/foo.txt)
nnoremap <leader>fpa :let @*=expand("%:p")<CR>
" relative path  (src/foo.txt)
nnoremap <leader>fpr :let @*=expand("%")<CR>
" filename       (foo.txt)
nnoremap <leader>fpn :let @*=expand("%:t")<CR>


" GENERAL CONFIG
set backspace=indent,eol,start                                                  " smart backspace
set history=1000
set termwinscroll=300000
set showcmd                                                                     " show incomplete commands at the bottom
set hidden                                                                      " manage multiple buffers effectively (save their state/history) 


" USER INTERFACE
set laststatus=2                                                                " always show the status bar
set ruler                                                                       " always show info along bottom.
set cc=120
set wildmenu                                                                    " display command line's tab complete options as a menu
set number                                                                      " always show line number (instead of 0 if relative)
set relativenumber                                                              " show the relative line number
set noerrorbells
set autoread                                                                    " automatically re-read files if unmodified inside Vim
set visualbell                                                                  " flash the screen instead of beeping on errors.
set title
set mouse=a                                                                     " allow scroll/resizing in iTerm2 with mouse
set whichwrap+=<,>,h,l,[,]


" MULTI-CURSOR / STAR SEARCH (auto-selects first occurrence and no jumping)
map g*  <Plug>(asterisk-z*)
map g#  <Plug>(asterisk-z#)
map * <Plug>(asterisk-gz*)
map # <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1
nmap / g/


" SWAP AND BACKUP
set directory=$HOME/.vim/swp//
set nobackup
set nowritebackup
set undofile                                                                     " save undo history across sessions
set undodir=$HOME/.vim/undodir
" set backupdir=$HOME/.vim/backup//
"" set noswapfile
"" set nowb


" INDENTATION
set autoindent
filetype plugin indent on                                                        " enable indenting for files
set tabstop=4                                                                   " existing tab size is 4
set softtabstop=4                                                               " OTF tab to space conversion
set shiftwidth=4                                                                " > indentation size is 4
set expandtab                                                                   " auto-converts tabs to spaces
set nowrap


" SEARCH
set hlsearch                                                                    " highlight matches by default
set incsearch                                                                   " highlight as you type your search.
set ignorecase                                                                  " make searches case-insensitive.
set smartcase                                                                   " unless you type a capital, use /\C to force match capitalizations.
" clear reset highlighting after search
" https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#657457
nnoremap <silent> <Esc><Esc> :let @/=""<CR>


" TEXT RENDERING
set ttyfast
set encoding=utf-8
set scrolloff=999                                                               " the cursor is centered vertically if posible (even in search mode?)
set linebreak                                                                   " break at word boundary
set listchars=tab:▸\ ,eol:¬                                                     " visualize tabs and newlines
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>tt :set list!<CR>                                                    " Toggle tabs and EOL
syntax on
set cursorline                                                                  " highlight current line

if (has("termguicolors"))
    set termguicolors
 endif

colorscheme onedark


" VISUAL MODE
vnoremap . :normal.<CR>                                                         " make . work with visually selected lines
" move block up/down
nnoremap <C-e> :m .+1<CR>==
nnoremap <C-u> :m .-2<CR>==
inoremap <C-e> <Esc>:m .+1<CR>==gi
inoremap <C-u> <Esc>:m .-2<CR>==gi
vnoremap <C-e> :m '>+1<CR>gv=gv
vnoremap <C-u> :m '<-2<CR>gv=gv
" Select All: Alt keys in iTerm2 neexd to be unmapped from Esc
nnoremap <Leader>sa ggVG                                                                " Select all text
" Duplicate selection (same as NyP and VyP)
" Mac Cmd key is not working with non-MacVim version
" https://unix.stackexchange.com/questions/29665/in-vim-how-to-map-command-right-and-command-left-to-beginning-of-line-and-e
nnoremap <Leader>d :copy .<CR>
vnoremap <Leader>d :copy '><CR>


" MACRO
set lazyredraw                                                                  " avoid redrawing screen in running macro since it's expensive
" need to use the re-mapped values of j/k as e/u.
let @n="I  - \<Esc>uI* \<Esc>2edd"
nnoremap <F1> :g/^https/ norm @n <CR>


" MISC
set clipboard^=unnamed,unnamedplus                                              " need to install vim via Homebrew since the Mac version was compiled w/out clipboard integration
"nnoremap <leader>v :Vexplore<CR>                                                " open file in vertical split
" Next match in search, Open lines, Insert mode.
nnoremap m n
nnoremap M N
" map the o command first before remapping it!
nnoremap h o
nnoremap H O
nnoremap o i
nnoremap O I
" next/down in general
" onoremap mode is needed so that
" `c3n` is interpreted as `c3j`.
" https://medium.com/usevim/operator-pending-mode-a4247d8596b7
" autocmd VimEnter * nnoremap n j

nnoremap e j
nnoremap E 9j
onoremap e j
vnoremap e j
noremap k u
nnoremap u k
nnoremap U 9k
onoremap u k
vnoremap u k
nnoremap n h
vnoremap n h
nnoremap i l
vnoremap i l
" END
nnoremap l e
vnoremap l e
nnoremap gl ge
vnoremap gl ge
nnoremap L E
vnoremap L E
nnoremap gL gE
vnoremap gL gE
nnoremap 'a "a
nnoremap 'r "r
nnoremap 's "s
nnoremap 't "t
nnoremap <Leader>h "_

" For the operator pending mode of Vim Sneak
omap s <Plug>Sneak_s
omap S <Plug>Sneak_S

" dont save and quit all.
nnoremap zz :qa!<CR>                                                            " exit when in Normal mode
" save all, ZZ by default will save the current buffer only and if there are changes only, then will quit
" this shortcut makes it possible to save all then exit.
nnoremap ZZ :wqa<CR>                                                            " exit when in Normal mode
" Esc when in Insert mode (dont move this as inline comment to prevent issue)
"inoremap nn <Esc>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!         " save changes to a read-only/sudo-only file using :w!!
" comment/uncomment
vnoremap <Leader>/ :norm gcc<CR>
noremap <Leader>/ :norm gcc<CR>

nnoremap <Leader>sv :source ~/.vimrc<CR>:echo "Reloaded .vimrc"<CR>
augroup vimrc     " Source vim configuration upon save
     autocmd!
     autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
augroup END

" remove whitespace
noremap <Leader>fw :FixWhitespace<CR>
" whitespace color: https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
" faster ESC key, need to enable `ttimeout` before it could be overriden.
" noremap <Esc> <C-c>
set ttimeout
set ttimeoutlen=100
" redo
" nnoremap <leader>gr <C-r>


" TERMINAL
" Escape using ESC, exit, or C-c! (C-c hard to remap)
" tnoremap <C-c> <C-w>:q!<CR>
" map <Leader>t :below term<CR>
" terminal-normal mode to cycle to other windows!
"tnoremap <C-u> <C-w>N
" needed to escape terminal insert mode
" but conflicts with fzf arrows!!!
" Caps Lock triggers F7 via Karabiner.
"tnoremap <f7> <C-w>N
"tnoremap <f7> <C-w>N<C-w>w
"tnoremap <Esc> <C-c>
"autocmd! FileType terminal tnoremap <buffer> <Esc> <C-w>N
"autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>


" FLOATING TERM
"nnoremap  <silent>  <C-l>  :FloatermToggle<CR>
"tnoremap  <silent>  <C-l>  <C-\><C-n>:FloatermToggle<CR>
"nnoremap  <silent>  <C-u>   :FloatermNext<CR>
"tnoremap  <silent>  <C-u>  <C-\><C-n>:FloatermNext<CR>
"nnoremap  <silent>  <C-y>  :FloatermNew<CR>
"tnoremap  <silent>  <C-y>  <C-\><C-n>:FloatermNew<CR>
"nnoremap  <silent>  <C-j>  :FloatermPrev<CR>
"tnoremap  <silent>  <C-j>  <C-\><C-n>:FloatermPrev<CR>
"let g:floaterm_width = 0.8
"let g:floaterm_height = 0.8


" BUFFERS
noremap <C-l> :bprev<CR>
noremap <C-y> :bnext<CR>
"nnoremap ls :ls<CR>
"vnoremap ls :ls<CR>
" save file
noremap <Leader>w :w!<CR>
noremap <Leader>o :on<CR>
" cycle windowv
noremap <Leader><Space> <C-w>w
" close/delete netrw/buffer
noremap <Leader>q :bd!<CR>
" close if final buffer is netrw or the quickfix
"augroup finalcountdown
    "au!
    "autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
    ""autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) || &buftype == 'quickfix' | q | endif
    "nmap - :Lexplore<cr>
    ""nmap - :NERDTreeToggle<cr>
"augroup END


" FZF
" Escape using ESC, exit, or C-c! (C-c hard to remap)
" Terminal up/down using <Space-n>/<Space-e>
map <Leader>p :Files<CR>
map <Leader>g :GFiles<CR>
map <Leader>b :Buffers<CR>
map <Leader>m :Maps<CR>
map <Leader>fh :History<CR>
map <Leader>fc :Files ~/dev/configs<CR>
map <Leader>fv :Files ~/Dropbox/Vortex<CR>

" Git Blame
map <Leader>gb :BlamerToggle<CR>
let g:blamer_delay = 100
let g:blamer_date_format = '%m/%d/%y'


" Rg
map <Leader>rg :Rg<CR>

function! RgHelper(query, fullscreen, command_fmt)
    let command_fmt = a:command_fmt . ' --no-heading --line-number --color=always --smart-case -- %s || true' 
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--preview-window', 'right:50%', '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" Search Python Files
function! RgPyFzf(query, fullscreen)
    let command_fmt = 'rg --type py'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgPy call RgPyFzf(<q-args>, <bang>0)
noremap <Leader>rp :RgPy<CR>

" Search Python/Django Unit Test Files
function! RgPyTFzf(query, fullscreen)
    let command_fmt = 'rg --type py --glob "**/tests/**"'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgPyT call RgPyTFzf(<q-args>, <bang>0)
noremap <Leader>rt :RgPyT<CR>

" Search Python/Django Migration Files
function! RgPyMFzf(query, fullscreen)
    let command_fmt = 'rg --type py --glob "**/migrations/**"'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgPyM call RgPyMFzf(<q-args>, <bang>0)
noremap <Leader>rm :RgPyM<CR>

" Search JS Files
function! RgJSFzf(query, fullscreen)
    let command_fmt = 'rg --type js'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgJS call RgJSFzf(<q-args>, <bang>0)
noremap <Leader>rj :RgJS<CR>

" Search HTML Files
function! RgHTMLFzf(query, fullscreen)
    let command_fmt = 'rg --type html'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgHTML call RgHTMLFzf(<q-args>, <bang>0)
noremap <Leader>rh :RgHTML<CR>

" Search All Files (includes Git-ignored files)
function! RgAllFzf(query, fullscreen)
    let command_fmt = 'rg --no-ignore --type-add "compiled:*.compiled" --type-not compiled'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgAll call RgAllFzf(<q-args>, <bang>0)
noremap <Leader>ra :RgAll<CR>

" Search All Files with Git Conflicts
function! RgAllConflictsFzf(query, fullscreen)
    let command_fmt = 'rg --type-add "po:*.po" --type po --type py --type html --type js --type css --type txt'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgAllConflicts call RgAllConflictsFzf(<q-args>, <bang>0)
noremap <Leader>rc :RgAllConflicts<CR>


" CoC
" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <leader>sd :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')


" Open browser with the specified link
function! HandleURI()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
    echo s:uri
    if s:uri != ""
        exec "!open \"" . s:uri . "\""
    else
        echo "No URI found in line."
    endif
    endfunction
map <Leader>ob :call HandleURI()<CR><CR>
