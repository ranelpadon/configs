nnoremap <Leader>gb :GitBlameToggle<CR>
nnoremap <Leader>gbc :GitBlameCopySHA<CR>
nnoremap <Leader>gbo :GitBlameOpenCommitURL<CR>

" Don't run on startup.
let g:gitblame_enabled = 0

" Prepend with spaces to improve visual spacing.
let g:gitblame_message_template = '    <sha>: <committer> - <committer-date> • <summary>'
let g:gitblame_date_format = '%x'

" Disable when in file explorer.
" To know the filetype: `:echo &filetype`.
let g:gitblame_ignored_filetypes = ['coc-explorer']
