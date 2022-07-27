let g:fzf_mru_relative = 1
let g:fzf_mru_no_sort = 1
let g:fzf_mru_exclude_current_file = 0
let g:save_on_update = 1

" Add a preview window.
command! -bang -nargs=? FZFMru call fzf_mru#actions#mru(<q-args>,
    \{
        \'window': {'width': 1, 'height': 1},
        \'options': [
            \'--preview', 'bat --style=numbers --color=always {}',
            \'--preview-window', 'up:60%',
            \'--bind', 'ctrl-_:toggle-preview'
        \]
    \}
\)

nnoremap <Leader>k :FZFMru<CR>
