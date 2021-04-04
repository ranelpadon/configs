let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

noremap <Leader>e :Lex<CR>

" Copy Absolute Path  (/something/src/foo.txt)
nnoremap <leader>fpa :let @*=expand("%:p")<CR>
" Copy Relative Path  (src/foo.txt)
nnoremap <leader>fpr :let @*=expand("%")<CR>
" Copy Filename (foo.txt)
nnoremap <leader>fpn :let @*=expand("%:t")<CR>

" Toggle shortcuts/commands help.
autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>

augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :Lexplore
augroup END

" Wipe previous netrw buffer
augroup AutoDeleteNetrwHiddenBuffers
    au!
    au FileType netrw setlocal bufhidden=wipe
augroup end