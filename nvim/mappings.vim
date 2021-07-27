" Find and replace
nnoremap <silent> <Leader>ss :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn


" Better indents with tab key, retains highlights.
vnoremap < <gv
vnoremap > >gv


" Adjust current window width.
nnoremap <Leader>, :vertical resize +15 <CR>
nnoremap <Leader>. :vertical resize -15 <CR>


" ENTER key
" https://vim.fandom.com/wiki/Insert_newline_without_entering_insert_mode
" Open a line before the current line (usual case)
nnoremap <Enter> O<Esc>j
" Open a line after the current line.
" <S-Enter> will not work due to
" https://stackoverflow.com/questions/598113/can-terminals-detect-shift-enter-or-control-enter
" So, remap <S-Enter> via BTT app.
nnoremap <F2> o<Esc>k


" Warning: conflicts with inoremap for F11/F12.
" Move to older cursor position. Opposite of <C-I>.
" Pressing <C-M> will map to <C-B> via BTT app
" since <C-M> could not be used directly because it's equivalent to ENTER key.
" nnoremap <C-B> <C-O>
" Move to newer cursor position. Opposite of <C-O>.
" nnoremap <C-H> <C-I>


" Go to SOL and EOL when in Insert/Normal mode.
" C-A and C-Z are mapped in Karabiner/BTT using the Left/Right Cmd physical keys.
" with Cmd-Left and Cmd-Right keys.
" https://coderwall.com/p/fd_bea/vim-jump-to-end-of-line-while-in-insert-mode
inoremap <C-A> <C-o>^
inoremap <C-Z> <C-o>$
nnoremap <C-A> ^
nnoremap <C-Z> $


" Move block up/down
" Maps to <C-,> and <C-.> via BTT.
nnoremap <F7> :m .+1<CR>==
nnoremap <F8> :m .-2<CR>==
inoremap <F7> <Esc>:m .+1<CR>==gi
inoremap <F8> <Esc>:m .-2<CR>==gi
vnoremap <F7> :m '>+1<CR>gv=gv
vnoremap <F8> :m '<-2<CR>gv=gv


" Forward/backward movements in chunks in Insert mode.
" Maps to <C-w> and <C-b> via BTT.
inoremap <F9> <C-o>W
inoremap <F10> <C-o>B


" Forward/backward delete in chunks in Insert mode.
" Maps to <C-m> and <C-h> via BTT.
inoremap <F11> <Esc>dwi
inoremap <F12> <Esc>dbi


" Find and replace of the current word in cursor,
" with Live Preview when in Nvim.
nnoremap <Leader>fr :%s/\<<C-r><C-w>\>//g<Left><Left>


" Next match in search, Open lines, Insert mode.
nnoremap m n
nnoremap M N


" Set mark/jot.
" Usage: ja then 'a.
" Use '. for last edit.
nnoremap j m


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
vnoremap E 9j
onoremap e j
vnoremap e j
noremap k u
nnoremap u k
nnoremap U 9k
vnoremap U 9k
onoremap u k
vnoremap u k
nnoremap n h
vnoremap n h
nnoremap i l
vnoremap i l

" Scroll up/down in chunks in Insert mode.
inoremap <C-u> <C-O>9k
inoremap <C-e> <C-O>9j

" End of Word
nnoremap l e
vnoremap l e
nnoremap gl ge
vnoremap gl ge
nnoremap L E
vnoremap L E
nnoremap gL gE
vnoremap gL gE

" Backward motion, inclusive the current cursor
onoremap b vb
onoremap F vF
onoremap T vT


" Dont save and quit all.
nnoremap zz :qa!<CR>                                                            " Exit when in Normal mode
" Save all, ZZ by default will save the current buffer only and if there are changes only, then will quit.
" This shortcut makes it possible to force save all then exit.
nnoremap ZZ :wqa<CR>                                                            " Exit when in Normal mode
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!         " Save changes to a read-only/sudo-only file using :w!!


" Reload Nvim source
nnoremap <Leader>sv :source ~/dev/configs/nvim/init.vim<CR>:echo "Reloaded Neovim init.vim"<CR>


" Clear highlighting after search:
" https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#657457
" Could not use the <Esc><Esc> sequence due to issues with other keys like arrows:
" https://stackoverflow.com/questions/11940801/mapping-esc-in-vimrc-causes-bizarre-arrow-behaviour?noredirect=1&lq=1
nnoremap <silent> <Leader>j :let @/ = ""<CR>


" Uncomment this to enable by default:
" set list
" Or use your leader key + l to toggle on/off
map <leader>tt :set list!<CR>                                                   " Toggle tabs and EOL


" Visual Mode - Dot
vnoremap . :normal.<CR>                                                         " Make . work with visually selected lines

" Select All: Alt keys in iTerm2 need to be unmapped from Esc
nnoremap <Leader>sa ggVG                                                        " Select all text

" Duplicate selection (same as NyP and VyP)
" Mac Cmd key is not working with non-MacVim version
" https://unix.stackexchange.com/questions/29665/in-vim-how-to-map-command-right-and-command-left-to-beginning-of-line-and-e
nnoremap <Leader>rr :copy .<CR>
vnoremap <Leader>rr :copy '><CR>


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
" Open new file.
noremap <Leader>n :enew<CR>
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
map <Leader>ol :call HandleURI()<CR><CR>


" Extra space color: https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
highlight ExtraWhitespace ctermbg=7 guibg=#c0c0c0
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=7 guibg=#c0c0c0
match ExtraWhitespace /\s\+$/

" Remove extra space
noremap <Leader>fw :FixWhitespace<CR>


" Auto-yank mouse selected text
noremap <LeftRelease> "+y<LeftRelease>


" Python dotted path (project/relative path).
nnoremap <Leader>cr :let @*=substitute(expand('%:h'), '\/', '.', 'g')<CR>


" Shortcut to use blackhole register by default
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X"

" Use Leader key to revert to default mode.
nnoremap <Leader>d d
vnoremap <Leader>d d
nnoremap <Leader>D D
vnoremap <Leader>D D
nnoremap <Leader>c c
vnoremap <Leader>c c
nnoremap <Leader>C C
vnoremap <Leader>C C
nnoremap <Leader>x x
vnoremap <Leader>x x
nnoremap <Leader>X X
vnoremap <Leader>X X


nnoremap zf zO                                                                  " Open fold recursively
nnoremap zF za                                                                  " Toggle fold
nnoremap za zR                                                                  " Open all folds
nnoremap zA zM                                                                  " Clos all folds
