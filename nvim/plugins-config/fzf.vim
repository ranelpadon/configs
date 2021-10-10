let g:fzf_layout = {'window': {'width': 1, 'height': 1}}

" Couldn't use the prescribed 'ctrl-/' in Mac,
" so use 'ctrl-_' instead (which is triggered by 'ctrl--' also).
" https://apple.stackexchange.com/questions/24261/how-do-i-send-c-that-is-control-slash-to-the-terminal#24282
let g:fzf_preview_window = ['up:50%', 'ctrl-_']

" Cmd+f via BTT.
map <F1>f /
" Cmd+p via BTT.
map <F1>p :Files<CR>
" Cmd+b via BTT.
map <F1>b :Buffers<CR>
map <Leader>g :GFiles<CR>
" git status
map <Leader>gs :GFiles?<CR>
map <Leader>m :Maps<CR>

" map <Leader>ph :History<CR>
map <Leader>l :Files ~/dev<CR>
map <Leader>c :Files ~/dev/configs<CR>
map <Leader>v :Files ~/Dropbox/Vortex<CR>
map <Leader>t :Files ~/dev/ticketflap/ticketing<CR>

map <Leader>rg :Rg<CR>

" Fix issue in `bat`'s preview colorscheme by inserting `COLORTERM=truecolor` as envvar.
" Fixed already in Neovim's nightly build. But needed in Vim.
if g:is_vim
    let $FZF_PREVIEW_COMMAND="COLORTERM=truecolor bat --style=numbers --color=always --line-range :5000 {}"
endif

if g:is_mvim
    " Quirks of MacVim.
    let $BAT_THEME="TwoDark"
endif


" Helper function only.
function! RgHelper(query, fullscreen, command_fmt)
    let command_fmt = a:command_fmt . ' --no-heading --line-number --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--preview-window', 'right:50%', '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction


" Search Python Files. Exclude the `tests` and `migrations` files.
let rg_py = 'rg --type py --glob "!**/tests/**" --glob "!**/migrations/**"'
command! -nargs=* -bang RgPy call RgHelper(<q-args>, <bang>0, rg_py)
noremap <Leader>rp :RgPy<CR>

" Search Python/Django Unit Test Files
let rg_py_tests = 'rg --type py --glob "**/tests/**"'
command! -nargs=* -bang RgPyT call RgHelper(<q-args>, <bang>0, rg_py_tests)
noremap <Leader>rpt :RgPyT<CR>

" Search Python/Django Migration Files
let rg_py_migrations = 'rg --type py --glob "**/migrations/**"'
command! -nargs=* -bang RgPyM call RgHelper(<q-args>, <bang>0, rg_py_migrations)
noremap <Leader>rpm :RgPyM<CR>


" Search HTML Files
let rg_html = 'rg --type html'
command! -nargs=* -bang RgHTML call RgHelper(<q-args>, <bang>0, rg_html)
noremap <Leader>rh :RgHTML<CR>

" Search JS Files
let rg_js = 'rg --type js'
command! -nargs=* -bang RgJS call RgHelper(<q-args>, <bang>0, rg_js)
noremap <Leader>rj :RgJS<CR>

" Search CSS Files
let rg_css = 'rg --type css'
command! -nargs=* -bang RgCSS call RgHelper(<q-args>, <bang>0, rg_css)
noremap <Leader>rc :RgCSS<CR>


" Search Python/Django Requirements/Text Files
let rg_txt = 'rg --type txt'
command! -nargs=* -bang RgTxt call RgHelper(<q-args>, <bang>0, rg_txt)
noremap <Leader>rt :RgTxt<CR>

" Search YAML Files
let rg_yaml = 'rg --type yaml'
command! -nargs=* -bang RgYAML call RgHelper(<q-args>, <bang>0, rg_yaml)
noremap <Leader>ry :RgYAML<CR>


" Search All Files (include Git-ignored files)
let rg_all = 'rg --no-ignore --type-add "compiled:*.compiled" --type-not compiled --type-not log'
command! -nargs=* -bang RgAll call RgHelper(<q-args>, <bang>0, rg_all)
noremap <Leader>ra :RgAll<CR>

" Search All Files with Git Conflicts. Include important files only.
let rg_git_conflicts = 'rg --type py --type html --type js --type css --type txt --type yaml --type po --type md'
command! -nargs=* -bang RgGitConflicts call RgHelper('>>>>>>>', <bang>0, rg_git_conflicts)
noremap <Leader>rgc :RgGitConflicts<CR>
