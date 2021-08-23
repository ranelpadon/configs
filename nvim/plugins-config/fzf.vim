let g:fzf_layout = {'window': {'width': 1, 'height': 1}}

" Couldn't use the prescribed 'ctrl-/' in Mac,
" so use 'ctrl-_' instead (which is triggered by 'ctrl--' also).
" https://apple.stackexchange.com/questions/24261/how-do-i-send-c-that-is-control-slash-to-the-terminal#24282
let g:fzf_preview_window = ['up:50%', 'ctrl-_']


map <Leader>p :Files<CR>
map <Leader>g :GFiles<CR>
" git status
map <Leader>gs :GFiles?<CR>
map <Leader>b :Buffers<CR>
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

" Search Python/Django Requirements/Text Files
function! RgPyTxtFzf(query, fullscreen)
    let command_fmt = 'rg --type txt'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgPyTxt call RgPyTxtFzf(<q-args>, <bang>0)
noremap <Leader>rtxt :RgPyTxt<CR>

" Search Python/Django Migration Files
function! RgPyMFzf(query, fullscreen)
    let command_fmt = 'rg --type py --glob "**/migrations/**"'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgPyM call RgPyMFzf(<q-args>, <bang>0)
noremap <Leader>rmp :RgPyM<CR>

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
"
" Search CSS Files
function! RgCSSFzf(query, fullscreen)
    let command_fmt = 'rg --type css'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgCSS call RgCSSFzf(<q-args>, <bang>0)
noremap <Leader>rc :RgCSS<CR>

" Search YAML Files
function! RgYAMLFzf(query, fullscreen)
    let command_fmt = 'rg --type-add "yaml:*.yaml" --type-add "yml:*.yml" --type yaml --type yml'
    call RgHelper(a:query, a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgYAML call RgYAMLFzf(<q-args>, <bang>0)
noremap <Leader>ry :RgYAML<CR>

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
    call RgHelper('>>>>>>>', a:fullscreen, command_fmt)
endfunction
command! -nargs=* -bang RgAllConflicts call RgAllConflictsFzf(<q-args>, <bang>0)
noremap <Leader>rac :RgAllConflicts<CR>
