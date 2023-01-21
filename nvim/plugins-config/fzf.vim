" Fzf+Bat is still faster/better than Telescope|Snap+Treesitter:
" https://github.com/junegunn/fzf.vim/issues/1312

" Options
" https://www.mankier.com/1/fzf
" https://www.mankier.com/1/rg

let g:fzf_layout = {'window': {'width': 0.75, 'height': 0.5}}

" Couldn't use the prescribed 'ctrl-/' in Mac,
" so use 'ctrl-_' instead (which is triggered by 'ctrl--' also).
" https://apple.stackexchange.com/questions/24261/how-do-i-send-c-that-is-control-slash-to-the-terminal#24282
" let g:fzf_preview_window = ['up:55%:hidden', '?']


function ShiftFocusThenExecute(command)
    " Shift focus to the right/main window,
    " especially when focus is in sidebar.
    :wincmd l

    " Run commands like `:Files`.
    execute a:command
endfunction


" Cmd+f via BTT.
map <F1>f /


let s:fzf_options = {
    \ 'options':
        \ [
            \ '--prompt', 'λ ',
            \ '--exact',
            \ '--preview-window', 'up,55%:hidden',
            \ '--bind', '?:toggle-preview',
        \ ]
\ }

" command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(s:fzf_options), <bang>0)
command! -nargs=? Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(s:fzf_options), 0)


function GoToTemplateFileOnCursor()
    " Copy the enclosed texts, including the quotes, for example:
    "   `'purchasing/cart_summary_vuejs_app.html'`
    " `yiq` will not work since sometimes there are nested quotes, for example:
    "   `src='{% static 'ets-vue-mini-confirm-order-page/js/app.js' %}'`
    execute 'normal! yiW'

    " Use the unnamed register, seems has issue with system register (e.g. @* or @+).
    " `let query = getreg('"')` will do also.
    let query = @"

    " Remove the surrounding quotes.
    let query = substitute(query, "'", '', 'g')
    let query = substitute(query, '"', '', 'g')

    " Set the initial query.
    let fzf_options = {
        \ 'options':
            \ [
                \ '--prompt', 'λ ',
                \ '--exact',
                \ '--query', query,
                \ '--preview-window', 'up,55%:hidden',
                \ '--bind', '?:toggle-preview',
            \ ]
    \ }

    call fzf#vim#files('', fzf#vim#with_preview(fzf_options))
endfunction

nnoremap gf :call GoToTemplateFileOnCursor()<CR>


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


" Has significant effect in Rg inside of Vim:
"   fzf window size: due to color rendering in embedded terminal.
"   fzf preview window size: due to color rendering in bat/embedded terminal.
"       - maybe use `bat` without theme, or don't use it all since it's not really useful.
"   rg_initial_command: since it will load all Rg lines.
"
" Has significant effect in Rg outside of Vim:
"   --color=never vs --color=always
"       https://github.com/junegunn/fzf.vim/issues/488
"       https://github.com/BurntSushi/ripgrep/issues/696
"       https://github.com/BurntSushi/ripgrep/issues/764

" Has not much effect in Rg outside of Vim:
"   --block-buffered
"   --mmap


let s:rg_colors = ' --colors line:fg:red --colors path:fg:blue --colors match:fg:green '

" We just need a dummy command that do nothing.
" This will work also.
" Run Rg in quiet mode (basically no searching/output).
" let rg_initial_command = 'rg "" --quiet'
let s:rg_initial_command = 'true'

" {q} is the query string passed from fzf to ripgrep.
" If query is empty do nothing instead of fetching all lines.
" `--fixed-strings` to avoid escaping regex chars like parentheses.
" `%s` is a placeholder for `rg_base_command` and resolved by using `printf()`.
let s:rg_full_command = '[[ {q} != "" ]] && '. '%s' . s:rg_colors . ' --line-number --color=always --smart-case --fixed-strings {q} || ' . s:rg_initial_command


command! -bang -nargs=* Rg
\   call fzf#vim#grep(
\       'rg' . s:rg_colors . ' --line-number --color=always --smart-case -- '.shellescape(<q-args>), 1,
\       fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}), <bang>0
\   )


" `fzf.vim` example version (for reference):
" https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
" function! RgReloader(query, fullscreen, _command_fmt)
"   let shell_command = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
"   let rg_initial_command = printf(shell_command, shellescape(a:query))
"   let rg_reload_command = printf(shell_command, '{q}')
"   let fzf_options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.rg_reload_command]}
"   call fzf#vim#grep(rg_initial_command, 1, fzf#vim#with_preview(fzf_options), a:fullscreen)
" endfunction


" Ranel's previous version (for reference).
" let g:fzf_layout = {'window': {'width': 1, 'height': 1}}
" let g:fzf_preview_window = ['up:60%', 'ctrl-_']
" function! RgReloader(query, fullscreen, shell_command)
"     :wincmd l

"     let shell_command = a:shell_command . s:rg_colors . ' --line-number --color=always --smart-case -- %s || true'
"     let rg_initial_command = printf(shell_command, shellescape(a:query))
"     let rg_reload_command = printf(shell_command, '{q}')
"     let query_exact_match = "'" . a:query
"     let fzf_options = {'options': '--exact --delimiter : --nth 3..'}
"     call fzf#vim#grep(rg_initial_command, 1, fzf#vim#with_preview(fzf_options), a:fullscreen)
" endfunction


" On-demand search using Rg if query is non-empty. Fzf is a middleman only.
function! RgReloader(query, fullscreen, rg_base_command)
    :wincmd l

    let rg_reload_command = printf(s:rg_full_command, a:rg_base_command)

    " --disabled: disable the fuzzy search, use fzf just a simple filter/pipe which is mainly search by Rg (makes the fzf's `--exact` option useless)
    " Use `--phony` for version 0.24.0 or lower.
    " https://github.com/junegunn/fzf/blob/master/CHANGELOG.md#0250
    " --bind 'change:reload:rg ... {q}' will make fzf restart ripgrep process whenever the query string
    " With --phony option, fzf will no longer perform search. The query string you type on fzf prompt is only used for restarting ripgrep process.
    " `--delimiter`: parse per line.
    " `--nth`: the scope of the search after parsing with delimiter.
    " Looks like `--disabled` makes the `--delimiter` and `--nth` useless and will just relay the searching to `ripgrep`.
    " let fzf_options = {'options': ['--prompt', 'λ ', '--disabled', '--phony', '--query', a:query, '--bind', 'change:reload:'.rg_reload_command, '--delimiter', ':', '--nth', '3..']}
    let fzf_options = {
        \ 'options':
            \ [
                \ '--prompt', 'λ ',
                \ '--disabled',
                \ '--phony',
                \ '--query', a:query,
                \ '--preview-window', 'up,55%:hidden',
                \ '--bind', 'change:reload:' . rg_reload_command,
                \ '--bind', '?:toggle-preview',
            \ ]
    \ }

    " call fzf#vim#grep(s:rg_initial_command, 1, fzf#vim#with_preview(fzf_options), a:fullscreen)
    call fzf#vim#grep(s:rg_initial_command, 1, fzf#vim#with_preview(fzf_options))
endfunction


" On-load search using Rg and Fzf, regardless if query is non-empty.
function! RgLoader(query, fullscreen, rg_base_command)
    :wincmd l

    " Use empty string ("") as initial query string ({q}) to load all lines.
    " Then, `rg` could search the contents and return the results with file paths.
    " Then, `fzf` could search the file paths as well.
    " Hence, this will load all lines at first, then use `fzf` to query the initial data.
    " No data reloading will be done unlike in `RgReloader()`.
    let _rg_load_command = a:rg_base_command . s:rg_colors . ' --line-number --color=always --smart-case --fixed-strings %s || true'
    " Resolve the `%s` query string.
    let rg_load_command = printf(_rg_load_command, shellescape(a:query))

    let fzf_options = {
        \ 'options':
            \ [
                \ '--prompt', 'λ ',
                \ '--exact',
                \ '--preview-window', 'up,55%',
                \ '--bind', '?:toggle-preview',
            \ ]
    \ }
    " call fzf#vim#grep(rg_load_command, 1, fzf#vim#with_preview(fzf_options), a:fullscreen)
    call fzf#vim#grep(rg_load_command, 1, fzf#vim#with_preview(fzf_options))
endfunction


" Search Python Files. Exclude the `test` and `migrations` files.
" Run `rg 'foo' --debug` to check the skipped paths.
" pyenv/virtualenv inserts a .gitignore file which skips all files (rename this file)!
" `~/.pyenv/versions/2.7.17/envs/ticketing/.gitignore`
" let rg_py = 'rg --mmap --glob "apps/**/*.py" ---glob "!apps/**/__init__.py" --glob "!**/test/**" --glob "!**/tests/**" --glob "!**/migrations/**"'
let rg_py = 'rg --type py --glob "!**/test/**" --glob "!**/tests/**" --glob "!**/migrations/**"'
command! -nargs=* -bang RgPy call RgReloader(<q-args>, <bang>0, rg_py)
" command! RgPy call RgReloader(<q-args>, <bang>0, rg_py)
" noremap <Leader>p :RgPy<CR>
" noremap <Leader>p :RgReloader(<q-args>, 0, rg_py)<CR>
noremap <Leader>p :RgPy<CR>

" Search Python/Django Unit Test Files
let rg_py_tests = 'rg --type py --glob "**/test/**/*.py" --glob "**/tests/**/*.py" --glob "!**/migrations/**"'
command! -nargs=* -bang RgPyT call RgReloader(<q-args>, <bang>0, rg_py_tests)
noremap <Leader>t :RgPyT<CR>

" Search Python/Django Migration Files
let rg_py_migrations = 'rg --type py --glob "!**/test/**" --glob "!**/tests/**" --glob "**/migrations/**/*.py"'
command! -nargs=* -bang RgPyM call RgReloader(<q-args>, <bang>0, rg_py_migrations)
noremap <Leader>m :RgPyM<CR>

" Search Python Files. Include the ignored files.
" Useful for scouring the `site-packages` or Django source code.
" Need the `--hidden` for .pyenv dotted files.
" let rg_py_all = 'rg --type py --glob "!**/test/**" --glob "!**/migrations/**" --hidden'
let rg_py_all = 'rg --type py --glob "!**/test/**" --glob "!**/tests/**" --glob "!**/migrations/**" --no-ignore --hidden'
command! -nargs=* -bang RgPyAll call RgReloader(<q-args>, <bang>0, rg_py_all)
noremap <Leader>a :RgPyAll<CR>


" Search Python Files, includes the filename in matches. Exclude the `test` and `migrations` files.
let file_rg_py = 'rg --type py --glob "!**/test/**" --glob "!**/tests/**" --glob "!**/migrations/**"'
" command! -nargs=* -bang FileRgPy call RgLoader('views pk_url_kwarg = ', <bang>0, file_rg_py)
command! -nargs=* -bang FileRgPy call RgLoader(<q-args>, <bang>0, file_rg_py)
noremap <Leader>fp :FileRgPy<CR>

" Search Python files using the word under the cursor.
nnoremap <silent> <Leader>rp :call RgLoader(expand('<cword>'), 0, rg_py)<CR>
nnoremap <silent> <Leader>rt :call RgLoader(expand('<cword>'), 0, rg_py_tests)<CR>


" Search JS/JSON/Vue Files, includes the filename in matches.
" let file_rg_json = 'rg --type js'
let file_rg_js = 'rg --type js --type json --type-add "vue:*.vue" --type vue'
command! -nargs=* FileRgJS call RgLoader(<q-args>, 0, file_rg_js)
noremap <Leader>fj :FileRgJS<CR>


" Search HTML Files
let rg_html = 'rg --type html'
command! -nargs=* -bang RgHTML call RgReloader(<q-args>, <bang>0, rg_html)
noremap <Leader>h :RgHTML<CR>

" Search HTML files using the word under the cursor.
nnoremap <silent> <Leader>rh :call RgLoader(expand('<cword>'), 0, rg_html)<CR>

" Search JS Files
let rg_js = 'rg --type js'
command! -nargs=* -bang RgJS call RgReloader(<q-args>, <bang>0, rg_js)
noremap <Leader>j :RgJS<CR>

" Search JS files using the word under the cursor.
nnoremap <silent> <Leader>rj :call RgLoader(expand('<cword>'), 0, rg_js)<CR>

" Search CSS Files
let rg_css = 'rg --type css'
command! -nargs=* -bang RgCSS call RgReloader(<q-args>, <bang>0, rg_css)
noremap <Leader>c :RgCSS<CR>


" Search Python/Django Requirements/Text Files
let rg_txt = 'rg --type txt'
command! -nargs=* -bang RgTxt call RgReloader(<q-args>, <bang>0, rg_txt)
noremap <Leader>tx :RgTxt<CR>

" Search YAML Files
let rg_yaml = 'rg --type yaml'
command! -nargs=* -bang RgYAML call RgReloader(<q-args>, <bang>0, rg_yaml)
noremap <Leader>y :RgYAML<CR>

" Search Zsh Files
let rg_zsh = 'rg --type sh'
command! -nargs=* -bang RgZsh call RgReloader(<q-args>, <bang>0, rg_zsh)
noremap <Leader>z :RgZsh<CR>

" Search Vim Files
let rg_vim = 'rg --type vim'
command! -nargs=* -bang RgVim call RgReloader(<q-args>, <bang>0, rg_vim)
noremap <Leader>v :RgVim<CR>


" Search All Files (include Git-ignored files)
let rg_all = 'rg --no-ignore --type-add "compiled:*.compiled" --type-not compiled --type-not log'
command! -nargs=* -bang RgAll call RgReloader(<q-args>, <bang>0, rg_all)
noremap <Leader>ga :RgAll<CR>

" Search All Files with Git Conflicts. Include important files only.
let rg_git_conflicts = 'rg --type py --type html --type js --type css --type txt --type yaml --type po --type md'
command! -nargs=* -bang RgGitConflicts call RgReloader('>>>>>>>', <bang>0, rg_git_conflicts)
noremap <Leader>cc :RgGitConflicts<CR>
