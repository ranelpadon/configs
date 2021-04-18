nnoremap <Leader>tb :TagbarToggle<CR>

" Highlight groups: https://github.com/preservim/tagbar/blob/master/doc/tagbar.txt

highlight TagbarScope guifg=#61afef ctermfg=Blue
highlight TagbarKind guifg=#98c379 ctermfg=Green

highlight TagbarVisibilityPrivate guifg=#3e4452 ctermfg=Cyan
highlight TagbarVisibilityProtected guifg=#3e4452 ctermfg=Cyan
highlight TagbarVisibilityPublic guifg=#3e4452 ctermfg=Cyan

" No folding by default.
let g:tagbar_foldlevel = 0
