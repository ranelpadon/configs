" See  `:ALEInfo` for list of settings.

let g:ale_linters = {
    \ 'python': ['flake8'],
    \ 'javascript': ['eslint'],
    \ }

let g:ale_fixers = {
    \ '*': ['trim_whitespace'],
    \ }

nnoremap <Leader>af :ALEFix<CR>

let g:ale_fix_on_save = 1
" let g:ale_python_autoflake_options = '--in-place --remove-all-unused-imports --exclude conf/settings/*'

" Skipping using `--skip-glob` in `isort` will not work since
" ALE will only pass the '-' as file name, which will be treated as an in-memory buffer.
" so the `*/conf/settings/*` pattern will not match to '-'.
" See the `site-packages/isort/main.py#main()`
" The `call add(l:cmd, '-')` in nvim/autoload/plugged/ale/autoload/ale/fixers/isort.vim
" still need to be commented-out also to avoid extra/useless processing.
" Better to just fix the imports using custom shell command/pre-commit hook.
" function SetALEPythonOptions()
"     let l:file_path_absolute = expand("%:p")
      " `--quiet` is needed, otherwise, the `print()` in isort.py
      " will print to Vim buffer which is not intended.
"     let b:ale_python_isort_options = ' --quiet ' . l:file_path_absolute
" endfunction
" autocmd FileType python call SetALEPythonOptions()
