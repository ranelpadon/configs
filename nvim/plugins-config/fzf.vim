let g:fzf_layout = {'window': {'width': 1, 'height': 1}}

" Couldn't use the prescribed 'ctrl-/' in Mac,
" so use 'ctrl-_' instead (which is triggered by 'ctrl--' also).
" https://apple.stackexchange.com/questions/24261/how-do-i-send-c-that-is-control-slash-to-the-terminal#24282
let g:fzf_preview_window = ['up:60%', 'ctrl-_']
" let g:fzf_preview_window = ['right:60%', 'ctrl-_']


function ShiftFocusThenExecute(command)
    " Shift focus to the right/main window,
    " especially when focus is in sidebar.
    :wincmd l

    " Run commands like `:Files`.
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
map <Leader>gf :call ShiftFocusThenExecute('GFiles')<CR>

" git status
map <Leader>gs :call ShiftFocusThenExecute('GFiles?')<CR>
map <Leader>ma :call ShiftFocusThenExecute('Maps')<CR>
map <Leader>l :call ShiftFocusThenExecute('Files ~/dev')<CR>
map <Leader>rg :call ShiftFocusThenExecute('Rg')<CR>

" Cmd+t via BTT.
" map <F1>t ShiftFocusThenExecute('BTags')<CR>


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
    " let spec = {'options': '--exact'}
    let spec = {'options': '--exact --delimiter : --nth 3..'}
    " let spec = {'options': ['--query', query_exact_match, '--delimiter', ':', '--nth', '3..']}
    " let spec = {'options': ['--query', a:query]}
    " let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! FileRgHelper(query, fullscreen, command_fmt)
    :wincmd l

    " let command_fmt = a:command_fmt . ' --line-number --color=always --smart-case -- '
    let command_fmt = a:command_fmt . ' --line-number --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    " let spec = {'options': ['--phony', '--query', a:query]}
    " let query_exact_match = "'" . a:query
    " let query_exact_match = "'" . a:query
    " {'options': '--delimiter : --nth 4..'}
    let spec = {'options': '--exact'}
    " let spec = {'options': '--exact --delimiter : --nth 3..'}
    " let spec = {'options': ['--query', query_exact_match, '--delimiter', ':', '--nth', '3..']}
    " let spec = {'options': ['--query', a:query]}
    " let spec = {'options': ['--exact', '--query', 'backoffice/secure_api views model =']}
    " let spec = {'options': ['--exact', '--query', 'backoffice/secure_api views model =']}
    " let spec = {'options': ['--exact', '--query', 'sessions_api pk_url_kwarg =']}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction


" Search Python Files. Exclude the `apps/common`,  `test` and `migrations` files.
" Run `rg 'foo' --debug` to check the skipped paths.
" pyenv/virtualenv inserts a .gitignore file which skips all files (rename this file)!
" `~/.pyenv/versions/2.7.17/envs/ticketing/.gitignore`
let rg_py = 'rg --no-unicode --type py --glob "*.py" --glob "!**/test/**" --glob "!**/tests/**" --glob "!**/migrations/**"'
" let rg_py_uncommon = 'rg --no-unicode --type py --glob "!apps/common/**" --glob "!**/test/**" --glob "!**/migrations/**"'
" let rg_py = 'rg --type py --glob "!**/test/**" --glob "!**/migrations/**"'
" let rg_py = 'rg --type py --glob "!**/test/**" --glob "!**/migrations/**" --glob "**/serializers.py"'
command! -nargs=* -bang RgPy call RgHelper(<q-args>, <bang>0, rg_py)
" command! -nargs=* -bang RgPy call RgHelper('def validate_', <bang>0, rg_py)
noremap <Leader>p :RgPy<CR>

" Search Python Files in `apps/common` only.
" `--type py` seems useless here, due to glob pattern having higher priority.
let rg_py_common = 'rg --no-unicode --type py --glob "apps/common/**/*.py" --glob "!**/test/**" --glob "!**/migrations/**"'
command! -nargs=* -bang RgPyCommon call RgHelper(<q-args>, <bang>0, rg_py_common)
" command! -nargs=* -bang RgPy call RgHelper('def validate_', <bang>0, rg_py)
" noremap <Leader>c :RgPyCommon<CR>


" Search Python Files. Exclude the `test` and `migrations` files.
" let rg_py_core = 'rg --no-unicode --type py --glob "!**/test/**" --glob "!**/migrations/**"'
" " let rg_py = 'rg --type py --glob "!**/test/**" --glob "!**/migrations/**"'
" " let rg_py = 'rg --type py --glob "!**/test/**" --glob "!**/migrations/**" --glob "**/serializers.py"'
" command! -nargs=* -bang RgPyCore call RgHelper(<q-args>, <bang>0, rg_py_core)
" " command! -nargs=* -bang RgPy call RgHelper('def validate_', <bang>0, rg_py)
" noremap <Leader>a :RgPyCore<CR>


" Search Python Files. Include the ignored files.
" Useful for scouring the `site-packages` or Django source code.
" Need the `--hidden` for .pyenv dotted files.
" let rg_py_all = 'rg --no-unicode --type py --glob "!**/test/**" --glob "!**/migrations/**" --hidden'
let rg_py_all = 'rg --no-unicode --type py --glob "*.py" --glob "!**/test/**" --glob "!**/tests/**" --glob "!**/migrations/**" --no-ignore'
" let rg_py = 'rg --type py --glob "!**/test/**" --glob "!**/migrations/**" --glob "**/serializers.py"'
command! -nargs=* -bang RgPyAll call RgHelper(<q-args>, <bang>0, rg_py_all)
" command! -nargs=* -bang RgPy call RgHelper('def validate_', <bang>0, rg_py)
noremap <Leader>a :RgPyAll<CR>


" Search Python Files, includes the filename in matches. Exclude the `test` and `migrations` files.
let file_rg_py = 'rg --no-unicode --type py --glob "*.py" --glob "!**/test/**" --glob "!**/tests/**" --glob "!**/migrations/**"'
" let file_rg_py = 'rg --no-unicode --type py --glob "!**/test/*" --glob "!**/migrations/**"'
" command! -nargs=* -bang RgPy call RgHelper(<q-args>, <bang>0, rg_py)
" command! -nargs=* -bang FileRgPy call FileRgHelper('views pk_url_kwarg = ', <bang>0, file_rg_py)
command! -nargs=* -bang FileRgPy call FileRgHelper(<q-args>, <bang>0, file_rg_py)
noremap <Leader>fp :FileRgPy<CR>

" Search Python files, using the word under the cursor.
nnoremap <silent> <Leader>rp :call RgHelper(expand('<cword>'), 0, rg_py)<CR>
nnoremap <silent> <Leader>rt :call RgHelper(expand('<cword>'), 0, rg_py_tests)<CR>

" Search Python/Django Unit Test Files
let rg_py_tests = 'rg --no-unicode --type py --glob "**/test/**/*.py" --glob "**/tests/**/*.py" --glob "!**/migrations/**"'
command! -nargs=* -bang RgPyT call RgHelper(<q-args>, <bang>0, rg_py_tests)
noremap <Leader>t :RgPyT<CR>

" Search Python/Django Migration Files
let rg_py_migrations = 'rg --no-unicode --type py --glob "**/migrations/**/*.py" --glob "!**/test/**" --glob "!**/tests/**"'
command! -nargs=* -bang RgPyM call RgHelper(<q-args>, <bang>0, rg_py_migrations)
noremap <Leader>m :RgPyM<CR>


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
noremap <Leader>tx :RgTxt<CR>

" Search YAML Files
let rg_yaml = 'rg --type yaml'
command! -nargs=* -bang RgYAML call RgHelper(<q-args>, <bang>0, rg_yaml)
noremap <Leader>y :RgYAML<CR>

" Search Zsh Files
let rg_zsh = 'rg --type sh'
command! -nargs=* -bang RgZsh call RgHelper(<q-args>, <bang>0, rg_zsh)
noremap <Leader>z :RgZsh<CR>


" Search All Files (include Git-ignored files)
let rg_all = 'rg --no-unicode --no-ignore --type-add "compiled:*.compiled" --type-not compiled --type-not log'
command! -nargs=* -bang RgAll call RgHelper(<q-args>, <bang>0, rg_all)
noremap <Leader>ga :RgAll<CR>

" Search All Files with Git Conflicts. Include important files only.
let rg_git_conflicts = 'rg --no-unicode --type py --type html --type js --type css --type txt --type yaml --type po --type md'
command! -nargs=* -bang RgGitConflicts call RgHelper('>>>>>>>', <bang>0, rg_git_conflicts)
noremap <Leader>cc :RgGitConflicts<CR>
