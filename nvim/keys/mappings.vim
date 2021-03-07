" Better tabbing
vnoremap < <gv
vnoremap > >gv


" ENTER key
" https://vim.fandom.com/wiki/Insert_newline_without_entering_insert_mode
" Open a line before the current line (usual case)
nnoremap <Enter> O<Esc>j
" Open a line after the current line.
nnoremap <S-Enter> o<Esc>k


" ESSENTIALS

" Next match in search, Open lines, Insert mode.
nnoremap m n
nnoremap M N

" Newlines: map the o command first before remapping it!
nnoremap h o
nnoremap H O
nnoremap o i
nnoremap O I

" Arrows in general
" onoremap mode is needed so that
" `c3n` is interpreted as `c3j`.
" https://medium.com/usevim/operator-pending-mode-a4247d8596b7
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

" End of Word
nnoremap l e
vnoremap l e
nnoremap gl ge
vnoremap gl ge
nnoremap L E
vnoremap L E
nnoremap gL gE
vnoremap gL gE

" Registers
nnoremap 'a "a
nnoremap 'r "r
nnoremap 's "s
nnoremap 't "t
nnoremap <Leader>h "_


" Dont save and quit all.
nnoremap zz :qa!<CR>                                                            " exit when in Normal mode
" Save all, ZZ by default will save the current buffer only and if there are changes only, then will quit
" this shortcut makes it possible to force save all then exit.
nnoremap ZZ :wqa<CR>                                                            " exit when in Normal mode
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!         " save changes to a read-only/sudo-only file using :w!!

" Reload Nvim source
nnoremap <Leader>sv :source $MYVIMRC<CR>:echo "Reloaded init.vim"<CR>

" fix/remove whitespace
noremap <Leader>fw :FixWhitespace<CR>


" clear reset highlighting after search
" https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#657457
nnoremap <silent> <Esc><Esc> :let @/=""<CR>


" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>tt :set list!<CR>                                                    " Toggle tabs and EOL


" VISUAL MODE
vnoremap . :normal.<CR>                                                         " make . work with visually selected lines
" move block up/down
nnoremap <C-e> :m .+1<CR>==
nnoremap <C-u> :m .-2<CR>==
inoremap <C-e> <Esc>:m .+1<CR>==gi
inoremap <C-u> <Esc>:m .-2<CR>==gi
vnoremap <C-e> :m '>+1<CR>gv=gv
vnoremap <C-u> :m '<-2<CR>gv=gv
" Select All: Alt keys in iTerm2 need to be unmapped from Esc
nnoremap <Leader>sa ggVG                                                                " Select all text
" Duplicate selection (same as NyP and VyP)
" Mac Cmd key is not working with non-MacVim version
" https://unix.stackexchange.com/questions/29665/in-vim-how-to-map-command-right-and-command-left-to-beginning-of-line-and-e
nnoremap <Leader>d :copy .<CR>
vnoremap <Leader>d :copy '><CR>


" MACRO
" need to use the re-mapped values of j/k as e/u.
let @n="I  - \<Esc>uI* \<Esc>2edd"
nnoremap <F1> :g/^https/ norm @n <CR>


" BUFFERS
" Also `S-Tab` via BTT app.   
noremap <C-l> :bprev<CR>
" Also `Tab` via BTT app.   
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


" :term TERMINAL
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
