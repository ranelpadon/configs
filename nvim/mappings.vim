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
" Maps to <C-m>, <C-h>, and <C-;> via BTT. <C-i> is same as <Tab>.
" Move to older cursor position. Opposite of <C-i>.
nnoremap <F11> <C-o>
" Move to newer cursor position. Opposite of <C-o>.
nnoremap <F12> <C-i>
" Mapped to <C-;> which is physically above the <C-o> in Colemak layout.
nnoremap <F13> <C-i>

" Go to SOL and EOL when in Insert/Normal mode.
" Use the Home/End keys mapped in `alacritty.yml` which is more robust
" than the C-A/C-P in BTT.
" C-A and C-P are mapped in Karabiner/BTT using the Left/Right Cmd physical keys.
" with Cmd-Left and Cmd-Right keys.
" https://coderwall.com/p/fd_bea/vim-jump-to-end-of-line-while-in-insert-mode
inoremap <Home> <C-o>^
inoremap <End> <C-o>$
nnoremap <Home> ^
nnoremap <End> $
" Execute Normal command.
inoremap kk <C-o>

" Duplicate line(s)/selection (same as NyP and VyP).
" Mac Cmd key is not working with non-MacVim version
" https://unix.stackexchange.com/questions/29665/in-vim-how-to-map-command-right-and-command-left-to-beginning-of-line-and-e
" Cmd+r via BTT.
nnoremap <F1>d :copy .<CR>
xnoremap <F1>d :copy '><CR>
inoremap <F1>d <C-o>yy<C-o>p

function AutoCommentDuplicatedLine()
    " Comment line.
    normal gcc

    " Duplicate the commented line.
    copy .

    " Uncomment the new line.
    normal gcc
endfunction


" `range` will make this function execute only once
" for the entire selection range.
" https://vi.stackexchange.com/questions/37295/duplicate-selected-lines-programmatically/#answer-37296
function AutoCommentDuplicatedLines() range
    " Duplicate the selected lines.
    '<,'>copy '>

    " Comment the previously selected lines.
    '<,'>Commentary
endfunction

" nnoremap R :call AutoCommentDuplicatedLine()<CR>

" Use `Bar` to separate commands and to avoid the <CR>!
" xnoremap R :copy '><Bar>'<,'>Commentary<CR>

" <C-U> will delete the existing command ('<,'>) before calling the function,
" hence, could be used when you don't want to use the `range` function modifier.
" <C-U> is similar to the shell/CLI shortcut for deleting characters towards the start of line.
" xnoremap R :<C-U>call AutoCommentDuplicatedLines()<CR>

" xnoremap R :call AutoCommentDuplicatedLines()<CR>


function CommentTwoAdjacentLines(direction)
    " `direction` arg will be referenced as `a:direction`.
    " echom a:direction

    if a:direction == 'DOWN'
        normal 2gcc
    else
        " Move the cursor up, comment, then move the cursor back to original position.
        normal u
        normal 2gcc
        normal e
    endif
endfunction

" Commenting 2 adjacent lines since the `commentary` plugin
" seems to work only in adjacent downward motion.
" `gce` (gc1e) and `gcu` (gc1u) have some delays,
" implement a function instead for faster sequence.
" nnoremap gce :call CommentTwoAdjacentLines('DOWN')<CR>
" nnoremap se :call CommentTwoAdjacentLines('DOWN')<CR>
" nnoremap gcu :call CommentTwoAdjacentLines('UP')<CR>
" nnoremap su :call CommentTwoAdjacentLines('UP')<CR>


function! _MoveCursorAndCenterVertically(end_line)
    let LINE_BELOW_END = a:end_line + 1
    exec 'normal!' .. LINE_BELOW_END .. 'gg'
    normal! zz
endfunction


function! DuplicateLines(type)
    " `type` is required arg for `operatorfunc`.
    " See https://vi.stackexchange.com/questions/7711/use-motion-in-normal-mapping-calling-a-function?#answer-7712

    " Get the lines/motion.
    let START = line("'[")
    let END = line("']")

    " Duplicate lines.
    " Equivalent: `:123,345copy 345`
    " See `:help execute` for the syntax, especially for `..`.
    exec START .. ',' .. END .. 'copy ' .. END

    call _MoveCursorAndCenterVertically(END)
endfunction


function! _CommentLines(start_line, end_line)
    " Equivalent: `:123,345Commentary`
    exec a:start_line .. ',' .. a:end_line .. 'Commentary'
endfunction


function! CommentLines(type)
    " Get the lines/motion.
    let START = line("'[")
    let END = line("']")

    call _CommentLines(START, END)
endfunction


" See `:help operatorfunc`.
" Comment lines by providing the motion/number of lines, say, `r4j`.
" Use `nmap` instead of `nnoremap` so that we could override the definition of `s`
" and could have `ss`.
nmap s :set operatorfunc=CommentLines<CR>g@
" If no motion provided, operate on the current line only (`_`).
nmap ss s_


function! DuplicateAndCommentLines(type)
    " Get the lines/motion.
    let START = line("'[")
    let END = line("']")

    " Provide a dummy arg since it's required.
    call DuplicateLines('')

    " Comment original lines.
    call _CommentLines(START, END)

    call _MoveCursorAndCenterVertically(END)
endfunction


" Remap `r` so that we could use it for more important commands below.
nnoremap <Leader>r r

" See `:help operatorfunc`.
" Duplicate lines by providing the motion/number of lines, say, `r4j`.
" Use `nmap` instead of `nnoremap` so that we could override the definition of `r`/`R`
" and could have `rr` and `RR`.
nmap r :set operatorfunc=DuplicateLines<CR>g@
nmap R :set operatorfunc=DuplicateAndCommentLines<CR>g@

" If no motion provided, operate on the current line only (`_`).
nmap rr r_
nmap RR R_


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
nnoremap <F1>r <C-r>
inoremap <F1>r <C-o><C-r>
" Edit file in a new 'tab'
" Cmd+t via BTT.
" <C-r>+ in command mode will copy the system clipboard registy (+).
nnoremap <F1>t :edit <C-r>+<CR>


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


" Need to be recursive mapping.
" Use `[[`/`]]` for classes navigation.
nmap J [mzz
nmap K ]mzz
nmap <C-j> [[zz
nmap <C-k> ]]zz


" Find and replace of the current word in cursor,
" with Live Preview when in Nvim.
nnoremap <Leader>fr :%s/\<<C-r><C-w>\>//g<Left><Left>


" Next match in search, Open lines, Insert mode.
nnoremap m nzz
nnoremap M Nzz

" Switch comma and semicolon
" ; as forward motion by default.
" , as backward motion by default, remap to `.
nnoremap ` ,
" g, as forward changelist. Analogous to <C-;>
" g; as backward changelist. Analogous to <C-o>
nnoremap go g;
nnoremap g; g,


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
nnoremap <C-o> <C-o>zz
nnoremap <C-d> <C-d>zz
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
" inoremap <C-u> <Esc>9kzzi
" inoremap <C-e> <Esc>9jzzi

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
" or use norm! to use the Vim's default keybindings.
let @n="I  - \<Esc>uI* \<Esc>2edd"
nnoremap <F5> :g/^https/ norm @n <CR>


" Buffers
" Also `S-Tab` via BTT app.
" nnoremap <C-l> :bprev<CR>
nnoremap <C-u> :bprev<CR>
" noremap N [m
" Also `Tab` via BTT app.
" nnoremap <C-y> :bnext<CR>
nnoremap <C-e> :bnext<CR>
" noremap I ]m
" Save file.
" Cmd+s via BTT.
noremap <F1>s :w!<CR>
" Close buffer, go to previous one, and preserve window layout.
" Use `!` so that unsaved/new buffer could be closed as well.
noremap <Leader>w :Bwipeout!<CR>
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
" Swap two letters: `vdp`.
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
vnoremap X "_X

" Use Leader key to revert to default mode.
" nnoremap <Leader>d d
" vnoremap <Leader>d d
" nnoremap <Leader>D D
" vnoremap <Leader>D D
" nnoremap <Leader>c c
" vnoremap <Leader>c c
" nnoremap <Leader>C C
" vnoremap <Leader>C C
" nnoremap <Leader>x "_x
" vnoremap <Leader>x "_x
" nnoremap <Leader>X "_X
" vnoremap <Leader>X "_X


nnoremap zf za                                                                  " Toggle fold
nnoremap zF zO                                                                  " Open fold recursively
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

" Repeat the last search.
" Good but has some delays when doing normal search only!
" nnoremap // //<CR>


" Open GitLab file.
function! GitLabFile()
    let s:base_uri = 'https://git.hk.asiaticketing.com/ticketflap/ticketing-v2/-/tree/ets/'
    echo s:base_uri
    let s:relative_file_path = expand("%")
    let s:uri = s:base_uri . s:relative_file_path
    exec "!open \"" . s:uri . "\""
endfunction
map <Leader>glf :call GitLabFile()<CR><CR>

" Open GitLab file in blame mode.
function! GitLabBlame()
    let s:base_uri = 'https://git.hk.asiaticketing.com/ticketflap/ticketing-v2/-/blame/ets/'
    echo s:base_uri
    let s:relative_file_path = expand("%")
    let s:uri = s:base_uri . s:relative_file_path
    exec "!open \"" . s:uri . "\""
endfunction
map <Leader>glb :call GitLabBlame()<CR><CR>


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
" https://stackoverflow.com/questions/3320182/cursor-position-in-vim-abbreviation#answer-3320321
" `<Left>` is the left arrow, `Eatchar` is built-in function (`:helpgrep Eatchar`).
" <C-R>=Eatchar('\s')<CR>` will eat the extraneous spaces.
" `=Eatchar` will evaluate the expression and put it in `=` register.
" `<C-R>=` will insert the contents of `=` register.
" https://dev.to/iggredible/the-only-vim-insert-mode-cheatsheet-you-ever-needed-nk9
iabbrev clog console.log()<Left><C-R>=Eatchar('\s')<CR>

iabbrev ict ic(type())<Left><Left><C-R>=Eatchar('\s')<CR>
iabbrev icd ic(dir())<Left><Left><C-R>=Eatchar('\s')<CR>
iabbrev icv ic(vars())<Left><Left><C-R>=Eatchar('\s')<CR>

iabbrev ic from icecream import ic
iabbrev icg ic(self.get_response_errors(response))
iabbrev lw logger.warning('{}'.format())<Left><Left><C-R>=Eatchar('\s')<CR>
iabbrev pudb import pudb; pu.db
iabbrev pdbpp import pdb; pdb.set_trace()
iabbrev ipdb import ipdb; ipdb.set_trace(context=10)
iabbrev IPy import IPython; IPython.embed()
iabbrev iskip # isort:skip_file
iabbrev dj111 # FIXME-DJ1.11:
iabbrev super super(Foo, self).bar(*args, **kwargs)<Home><Right><Right><Right><Right><Right><Right><C-R>=Eatchar('\s')<CR>

" autocmd FileType python nnoremap <buffer> [[ ?^class\\|^\s*def<CR>
" autocmd FileType python nnoremap <buffer> ]] /^class\\|^\s*def<CR>

" Include in jumps list (<C-o>) the j/k motions if they're more than 1 step.
nnoremap <silent> e :<C-U>execute 'normal!' (v:count > 1 ? "m'" . v:count : '') . 'jzz'<CR>
nnoremap <silent> u :<C-U>execute 'normal!' (v:count > 1 ? "m'" . v:count : '') . 'kzz'<CR>
