let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :Lexplore
augroup END

"unmap \fe
autocmd VimEnter * noremap <Leader>fe :Lex<CR>
noremap <Leader>e :Lex<CR>
" Wipe previous netrw buffer
augroup AutoDeleteNetrwHiddenBuffers
    au!
    au FileType netrw setlocal bufhidden=wipe
augroup end


" FILE PATHS
" absolute path  (/something/src/foo.txt)
nnoremap <leader>fpa :let @*=expand("%:p")<CR>
" relative path  (src/foo.txt)
nnoremap <leader>fpr :let @*=expand("%")<CR>
" filename       (foo.txt)
nnoremap <leader>fpn :let @*=expand("%:t")<CR>
