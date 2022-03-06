" See  `:ALEInfo` for list of settings.

let g:ale_linters = {
    \ 'python': ['flake8'],
    \ 'javascript': ['eslint'],
    \ }

let g:ale_fixers = {
    \ '*': ['trim_whitespace'],
    \ 'python': ['autoflake', 'isort', 'trim_whitespace'],
    \ }

nnoremap <Leader>af :ALEFix<CR>

let g:ale_fix_on_save = 1
let g:ale_python_autoflake_options = '--in-place --remove-all-unused-imports --exclude */conf/settings/*'
let g:ale_python_isort_options = '--skip-glob */conf/settings/*'
