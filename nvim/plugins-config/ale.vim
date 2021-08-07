" See  `:ALEInfo` for list of settings.

let g:ale_linters = {
    \ 'python': ['flake8'],
    \ 'javascript': ['eslint'],
    \ }

let g:ale_fixers = {
    \ '*': ['trim_whitespace'],
    \ 'python': ['isort', 'trim_whitespace'],
    \ }

" `:ALEFix`
nnoremap <Leader>af :ALEFix<CR>

let g:ale_fix_on_save = 1
