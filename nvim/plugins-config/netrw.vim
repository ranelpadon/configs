let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

noremap <Leader>ne :Lex<CR>

" Toggle shortcuts/commands help.
autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>

" augroup ProjectDrawer
    " autocmd!
    " autocmd VimEnter * :Lexplore
" augroup END

" Wipe previous netrw buffer
augroup AutoDeleteNetrwHiddenBuffers
    au!
    au FileType netrw setlocal bufhidden=wipe
augroup end
