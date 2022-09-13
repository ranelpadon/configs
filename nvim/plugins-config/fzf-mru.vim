let g:fzf_mru_relative = 1
let g:fzf_mru_no_sort = 1
let g:fzf_mru_exclude_current_file = 0
let g:save_on_update = 1

" Add a preview window.
command! -bang -nargs=? FZFMru call fzf_mru#actions#mru(<q-args>,
    \{
        \'window': {'width': 0.75, 'height': 0.5},
        \'options': [
            \'--prompt', 'λ ',
            \'--preview', 'bat --style=numbers --color=always {}',
            \'--preview-window', 'up:55%:hidden',
            \'--bind', '?:toggle-preview'
        \]
    \}
\)

nnoremap <Leader>k :FZFMru<CR>
