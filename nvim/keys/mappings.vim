" Better indents with tab key, retains highlights.
vnoremap < <gv
vnoremap > >gv


" ENTER key
" https://vim.fandom.com/wiki/Insert_newline_without_entering_insert_mode
" Open a line before the current line (usual case)
nnoremap <Enter> O<Esc>j
" Open a line after the current line.
nnoremap <S-Enter> o<Esc>k


" Go to SOL and EOL when in Insert mode.
" C-A and C-Z are mapped in Karabiner/BTT
" with Cmd-Left and Cmd-Right keys.
" https://coderwall.com/p/fd_bea/vim-jump-to-end-of-line-while-in-insert-mode
inoremap <C-A> <C-o>^
inoremap <C-Z> <C-o>$


" Find and replace of the current word in cursor,
" with Live Preview when in Nvim.
:nnoremap <Leader>fr :%s/\<<C-r><C-w>\>//g<Left><Left>


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
nnoremap zz :qa!<CR>                                                            " Exit when in Normal mode
" Save all, ZZ by default will save the current buffer only and if there are changes only, then will quit.
" This shortcut makes it possible to force save all then exit.
nnoremap ZZ :wqa<CR>                                                            " Exit when in Normal mode
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!         " Save changes to a read-only/sudo-only file using :w!!


" Reload Nvim source
nnoremap <Leader>sv :source ~/dev/configs/nvim/init.vim<CR>:echo "Reloaded Neovim init.vim"<CR>


" Fix/remove whitespace
noremap <Leader>fw :FixWhitespace<CR>


" Clear highlighting after search:
" https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#657457
" Could not use the <Esc><Esc> sequence due to issues with other keys like arrows:
" https://stackoverflow.com/questions/11940801/mapping-esc-in-vimrc-causes-bizarre-arrow-behaviour?noredirect=1&lq=1
nnoremap <silent> <Leader><Esc> :let @/ = ""<CR>


" Uncomment this to enable by default:
" set list
" Or use your leader key + l to toggle on/off
map <leader>tt :set list!<CR>                                                   " Toggle tabs and EOL


" Visual Mode - Dot
vnoremap . :normal.<CR>                                                         " Make . work with visually selected lines

" Move block up/down
nnoremap <C-e> :m .+1<CR>==
nnoremap <C-u> :m .-2<CR>==
inoremap <C-e> <Esc>:m .+1<CR>==gi
inoremap <C-u> <Esc>:m .-2<CR>==gi
vnoremap <C-e> :m '>+1<CR>gv=gv
vnoremap <C-u> :m '<-2<CR>gv=gv

" Select All: Alt keys in iTerm2 need to be unmapped from Esc
nnoremap <Leader>sa ggVG                                                        " Select all text

" Duplicate selection (same as NyP and VyP)
" Mac Cmd key is not working with non-MacVim version
" https://unix.stackexchange.com/questions/29665/in-vim-how-to-map-command-right-and-command-left-to-beginning-of-line-and-e
nnoremap <Leader>d :copy .<CR>
vnoremap <Leader>d :copy '><CR>


" Macro for compiling release notes.
" need to use the re-mapped values of j/k as e/u.
let @n="I  - \<Esc>uI* \<Esc>2edd"
nnoremap <F5> :g/^https/ norm @n <CR>


" Buffers
" Also `S-Tab` via BTT app.   
noremap <C-l> :bprev<CR>
" Also `Tab` via BTT app.   
noremap <C-y> :bnext<CR>
" Save file
noremap <Leader>s :w!<CR>
" Close/delete netrw/buffer
noremap <Leader>w :bw<CR>
" Focus the file.
noremap <Leader>o :on<CR>
" Cycle windowv
noremap <Leader><Space> <C-w>w


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


" Extra space color: https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
highlight ExtraWhitespace ctermbg=7 guibg=#c0c0c0
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=7 guibg=#c0c0c0
match ExtraWhitespace /\s\+$/

" Remove extra space
noremap <Leader>fw :FixWhitespace<CR>


" Auto-yank mouse selected text
noremap <LeftRelease> "+y<LeftRelease>