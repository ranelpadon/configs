" For concistency with D (d$) and C (c$).
nnoremap Y y$
" Exclude the new line.
nnoremap yy 0y$


" Find and replace
nnoremap <silent> <Leader>ss :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn


" Better indents with tab key, retains highlights.
vnoremap < <gv
vnoremap > >gv


" Adjust current window width. Focus should be in file explorer.
nnoremap <Leader>, :vertical resize -15 <CR>
nnoremap <Leader>. :vertical resize +15 <CR>


" ENTER key
" https://vim.fandom.com/wiki/Insert_newline_without_entering_insert_mode
" Open a line before the current line (usual case)
nnoremap <Enter> O<Esc>jzz
" Open a line after the current line. Allow cursor to move as well.
" <S-Enter> will not work due to
" https://stackoverflow.com/questions/598113/can-terminals-detect-shift-enter-or-control-enter
" So, remap <S-Enter> via BTT app.
nnoremap <F2> o<Esc>zz


" Warning: conflicts with inoremap for F11/F12.
" Pressing <C-M> will map to <C-B> via BTT app
" since <C-M> could not be used directly because it's equivalent to ENTER key.
" Maps to <C-m> and <C-h> via BTT. <C-i> is same as <Tab>.
" Move to older cursor position. Opposite of <C-i>.
nnoremap <F11> <C-o>
" Move to newer cursor position. Opposite of <C-o>.
nnoremap <F12> <C-i>

" Go to SOL and EOL when in Insert/Normal mode.
" C-A and C-Z are mapped in Karabiner/BTT using the Left/Right Cmd physical keys.
" with Cmd-Left and Cmd-Right keys.
" https://coderwall.com/p/fd_bea/vim-jump-to-end-of-line-while-in-insert-mode
inoremap <C-a> <C-o>^
inoremap <C-z> <C-o>$
nnoremap <C-a> ^
nnoremap <C-z> $
" Execute Normal command.
inoremap kk <C-o>
" Duplicate selection (same as NyP and VyP).
" Mac Cmd key is not working with non-MacVim version
" https://unix.stackexchange.com/questions/29665/in-vim-how-to-map-command-right-and-command-left-to-beginning-of-line-and-e
" Cmd+d via BTT.
nnoremap <F1>d :copy .<CR>
vnoremap <F1>d :copy '><CR>
" Duplicate line.
" Cmd+r via BTT.
inoremap <F1>d <C-o>yy<C-o>p
" Copy.
" Cmd+c via BTT.
nnoremap <F1>c yy
inoremap <F1>c <C-o>yy
" Cut.
" Cmd+x via BTT.
nnoremap <F1>x dd
inoremap <F1>x <C-o>dd
" Undo.
" Cmd+z via BTT.
nnoremap <F1>u u
inoremap <F1>u <C-o>u
" Redo
" Cmd+g via BTT.
nnoremap <F1>r <C-R>
inoremap <F1>r <C-o><C-R>


" Forward/backward movements in chunks in Insert mode.
" Maps to <C-w>/<C-k> and <C-b> via BTT.
inoremap <F9> <C-o>B
inoremap <F10> <C-o>W
inoremap <C-l> <C-o>b
inoremap <C-y> <C-o>w


" Forward/backward delete in chunks in Insert mode.
" Maps to <C-m> and <C-h> via BTT.
inoremap <F11> <C-o>de
inoremap <F12> <C-o>db


" Move block up/down
" Maps to <C-,> and <C-.> via BTT.
nnoremap <F7> :move .+1<CR>==zz
nnoremap <F8> :move .-2<CR>==zz
inoremap <F7> <Esc>:move .+1<CR>==gi<C-o>zz
inoremap <F8> <Esc>:move .-2<CR>==gi<C-o>zz
vnoremap <F7> :move '>+1<CR>gv=gvzz
vnoremap <F8> :move '<-2<CR>gv=gvzz


" Find and replace of the current word in cursor,
" with Live Preview when in Nvim.
nnoremap <Leader>fr :%s/\<<C-r><C-w>\>//g<Left><Left>


" Next match in search, Open lines, Insert mode.
nnoremap m n
nnoremap M N

" Switch comma and semicolon
nnoremap , ;
nnoremap ; ,


" Set mark/jot.
" Usage: ja then 'a.
" Use '. for last edit.
nnoremap j m


" Newlines: map the o command first before remapping it!
nnoremap h o
nnoremap H O
nnoremap a i
nnoremap A I
nnoremap o a
nnoremap O A

" Center some operations.
nnoremap p pzz
nnoremap P Pzz
nnoremap G Gzz
nnoremap <Down> <Down>zz
nnoremap <Up> <Up>zz
inoremap <Esc> <Esc>zz
" Up/Down should not use `zz` when navigating completion popup menu.
inoremap <expr> <Down> pumvisible() ? "\<Down>" : "\<Down>\<C-o>zz"
inoremap <expr> <Up> pumvisible() ? "\<Up>" : "\<Up>\<C-o>zz"

" Arrows in general
" onoremap mode is needed so that
" `c3n` is interpreted as `c3j`.
" https://medium.com/usevim/operator-pending-mode-a4247d8596b7
nnoremap k u
nnoremap u kzz
nnoremap U 9kzz
vnoremap U 9k
onoremap u k
vnoremap u k
nnoremap e jzz
nnoremap E 9jzz
vnoremap E 9j
onoremap e j
vnoremap e j
nnoremap n h
vnoremap n h
nnoremap i l
vnoremap i l
" Override the `vim-indent-object` binding for `ii`
" to have right-ward direction than text object selection.
vnoremap ii ll

" Scroll up/down in chunks in Insert mode.
inoremap <C-u> <Esc>9kzzi
inoremap <C-e> <Esc>9jzzi

" End of Word
nnoremap l e
onoremap l e
vnoremap l e
nnoremap gl ge
onoremap gl ge
vnoremap gl ge
nnoremap L E
onoremap L E
vnoremap L E
nnoremap gL gE
onoremap gL gE
vnoremap gL gE

" Backward motion, inclusive the current cursor
onoremap b vb
onoremap F vF
onoremap T vT


" Dont save and quit all.
nnoremap qq :qa!<CR>                                                            " Exit when in Normal mode
" Save all, ZZ by default will save the current buffer only and if there are changes only, then will quit.
" This shortcut makes it possible to force save all then exit.
nnoremap ZZ :wqa<CR>                                                            " Exit when in Normal mode
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!         " Save changes to a read-only/sudo-only file using :w!!


" Reload Nvim source.
nnoremap <Leader>s :source ~/dev/configs/nvim/init.vim<CR>:echo "Reloaded Neovim init.vim"<CR>


" Clear highlighting after search:
" https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#657457
" Could not use the <Esc><Esc> sequence due to issues with other keys like arrows:
" https://stackoverflow.com/questions/11940801/mapping-esc-in-vimrc-causes-bizarre-arrow-behaviour?noredirect=1&lq=1
nnoremap <silent><Esc> :noh<CR>
" nnoremap <silent> kk :let @/ = ""<CR>

" Visual Mode - Dot
vnoremap . :normal.<CR>                                                         " Make . work with visually selected lines

" Select All: Alt keys in iTerm2 need to be unmapped from Esc.
" Cmd+a via BTT.
nnoremap <F1>a ggVG                                                             " Select all text


" Macro for compiling release notes.
" need to use the re-mapped values of j/k as e/u.
let @n="I  - \<Esc>uI* \<Esc>2edd"
nnoremap <F5> :g/^https/ norm @n <CR>


" Buffers
" Also `S-Tab` via BTT app.
" noremap <C-l> :bprev<CR>
nnoremap N :bprev<CR>
" Also `Tab` via BTT app.
" noremap <C-y> :bnext<CR>
nnoremap I :bnext<CR>
" Save file.
" Cmd+s via BTT.
noremap <F1>s :w!<CR>
" Close buffer, go to previous one, and preserve window layout.
noremap <Leader>w :Bwipeout<CR>
" Focus the file.
noremap <Leader>o :on<CR>
" Open new file.
noremap <Leader>n :enew<CR>
" Cycle window.
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


" Auto-yank mouse-selected text
vnoremap <LeftRelease> "+y<LeftRelease>
" Center mouse on click.
nnoremap <LeftMouse> <LeftMouse>zz
inoremap <LeftMouse> <LeftMouse><C-o>zz


" Shortcut to use blackhole register by default
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
nnoremap <Leader>D "_D
vnoremap <Leader>D "_D
" nnoremap d "_d
" vnoremap d "_d
" nnoremap D "_D
" vnoremap D "_D
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X"

" Use Leader key to revert to default mode.
" nnoremap <Leader>d d
" vnoremap <Leader>d d
" nnoremap <Leader>D D
" vnoremap <Leader>D D
" nnoremap <Leader>c c
" vnoremap <Leader>c c
" nnoremap <Leader>C C
" vnoremap <Leader>C C
" nnoremap <Leader>x "_d
" vnoremap <Leader>x "_d
" nnoremap <Leader>X "_D
" vnoremap <Leader>X "_D


nnoremap zf zO                                                                  " Open fold recursively
nnoremap zF za                                                                  " Toggle fold
nnoremap za zR                                                                  " Open all folds
nnoremap zA zM                                                                  " Close all folds


" Center screen to result(s) while searching.
function! CenterSearch()
    let cmdtype = getcmdtype()
    if cmdtype == '/' || cmdtype == '?'
        return "\<enter>zz"
    endif
    return "\<enter>"
endfunction

cnoremap <silent> <expr> <enter> CenterSearch()


" Copy Absolute Path  (/something/src/foo.txt)
nnoremap <leader>fn :let @*=expand("%:p")<CR>
" Copy Relative Path  (src/foo.txt)
nnoremap <leader>fe :let @*=expand("%")<CR>
" Python dotted path (project/relative path). Similar to `copy reference` in PyCharm.
" Auto-truncate the `apps/conf` folders in `ets` codebase.
nnoremap <Leader>fi :let @*=substitute(expand('%:r'), '\/', '.', 'g')[5:] . '.' . expand('<cword>')<CR>
" Copy Filename (foo.txt)
nnoremap <leader>fo :let @*=expand("%:t")<CR>
" Copy Filename without extension (foo)
nnoremap <leader>f' :let @*=expand("%:t:r")<CR>


" Expands in Insert mode.
abbreviate clog console.log(
abbreviate ic from icecream import ic
abbreviate pudb import pudb; pu.db
abbreviate pdbpp import pdb; pdb.set_trace()
abbreviate ipdb import ipdb; ipdb.set_trace(context=10)
