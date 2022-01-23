let g:fzf_layout = {'window': {'width': 1, 'height': 1}}

" Couldn't use the prescribed 'ctrl-/' in Mac,
" so use 'ctrl-_' instead (which is triggered by 'ctrl--' also).
" https://apple.stackexchange.com/questions/24261/how-do-i-send-c-that-is-control-slash-to-the-terminal#24282
let g:fzf_preview_window = ['right:60%', 'ctrl-_']


function ShiftFocusThenExecute(command)
    " Shift focus to the right/main window,
    " especially when focus is in sidebar.
    :wincmd l

    "Run commands like `:Files`.
    execute a:command
endfunction


" Cmd+f via BTT.
map <F1>f /

" Cmd+p via BTT.
" Works also. Use `<Bar>` instead of `|`:
" map <F1>p :wincmd l <Bar> :Files<CR>
map <F1>p :call ShiftFocusThenExecute('Files')<CR>

" Cmd+b via BTT.
map <F1>b :call ShiftFocusThenExecute('Buffers')<CR>
map <Leader>g :call ShiftFocusThenExecute('GFiles')<CR>

" git status
map <Leader>gs :call ShiftFocusThenExecute('GFiles?')<CR>
map <Leader>m :call ShiftFocusThenExecute('Maps')<CR>
map <Leader>l :call ShiftFocusThenExecute('Files ~/dev')<CR>
map <Leader>rg :call ShiftFocusThenExecute('Rg')<CR>

" Cmd+t via BTT.
map <F1>t ShiftFocusThenExecute('BTags')<CR>


" Fix issue in `bat`'s preview colorscheme by inserting `COLORTERM=truecolor` as envvar.
" Fixed already in Neovim's nightly build. But needed in Vim.
if g:is_vim
    let $FZF_PREVIEW_COMMAND="COLORTERM=truecolor bat --style=numbers --color=always --line-range :5000 {}"
endif

if g:is_mvim
    " Quirks of MacVim.
    let $BAT_THEME="TwoDark"
endif


command! -bang -nargs=* Rg
\   call fzf#vim#grep(
\       'rg --line-number --color=always --smart-case -- '.shellescape(<q-args>), 1,
\       fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}), <bang>0
\   )

" Helper function only.
function! RgHelper(query, fullscreen, command_fmt)
    :wincmd l

    " let command_fmt = a:command_fmt . ' --line-number --color=always --smart-case -- '
    let command_fmt = a:command_fmt . ' --line-number --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    " let spec = {'options': ['--phony', '--query', a:query]}
    let query_exact_match = "'" . a:query
    " {'options': '--delimiter : --nth 4..'}
    let spec = {'options': '--exact --delimiter : --nth 3..'}
    " let spec = {'options': ['--query', query_exact_match, '--delimiter', ':', '--nth', '3..']}
    " let spec = {'options': ['--query', a:query]}
    " let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction


" Search Python Files. Exclude the `tests` and `migrations` files.
let rg_py = 'rg --type py --glob "!**/tests/**" --glob "!**/migrations/**"'
command! -nargs=* -bang RgPy call RgHelper(<q-args>, <bang>0, rg_py)
noremap <Leader>pp :RgPy<CR>

" Search Python files, using the word under the cursor.
nnoremap <silent> <Leader>pr :call RgHelper(expand('<cword>'), 0, rg_py)<CR>

" Search Python/Django Unit Test Files
let rg_py_tests = 'rg --type py --glob "**/tests/**"'
command! -nargs=* -bang RgPyT call RgHelper(<q-args>, <bang>0, rg_py_tests)
noremap <Leader>pt :RgPyT<CR>

" Search Python/Django Migration Files
let rg_py_migrations = 'rg --type py --glob "**/migrations/**"'
command! -nargs=* -bang RgPyM call RgHelper(<q-args>, <bang>0, rg_py_migrations)
noremap <Leader>pm :RgPyM<CR>


" Search HTML Files
let rg_html = 'rg --type html'
command! -nargs=* -bang RgHTML call RgHelper(<q-args>, <bang>0, rg_html)
noremap <Leader>h :RgHTML<CR>

" Search JS Files
let rg_js = 'rg --type js'
command! -nargs=* -bang RgJS call RgHelper(<q-args>, <bang>0, rg_js)
noremap <Leader>j :RgJS<CR>

" Search CSS Files
let rg_css = 'rg --type css'
command! -nargs=* -bang RgCSS call RgHelper(<q-args>, <bang>0, rg_css)
noremap <Leader>c :RgCSS<CR>


" Search Python/Django Requirements/Text Files
let rg_txt = 'rg --type txt'
command! -nargs=* -bang RgTxt call RgHelper(<q-args>, <bang>0, rg_txt)
noremap <Leader>t :RgTxt<CR>

" Search YAML Files
let rg_yaml = 'rg --type yaml'
command! -nargs=* -bang RgYAML call RgHelper(<q-args>, <bang>0, rg_yaml)
noremap <Leader>y :RgYAML<CR>


" Search All Files (include Git-ignored files)
let rg_all = 'rg --no-ignore --type-add "compiled:*.compiled" --type-not compiled --type-not log'
command! -nargs=* -bang RgAll call RgHelper(<q-args>, <bang>0, rg_all)
noremap <Leader>a :RgAll<CR>

" Search All Files with Git Conflicts. Include important files only.
let rg_git_conflicts = 'rg --type py --type html --type js --type css --type txt --type yaml --type po --type md'
command! -nargs=* -bang RgGitConflicts call RgHelper('>>>>>>>', <bang>0, rg_git_conflicts)
noremap <Leader>cc :RgGitConflicts<CR>
