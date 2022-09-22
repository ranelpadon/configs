" Cycle when it reaches the EOF.
function! GitGutterNextHunkCycle()
    let line = line('.')
    silent! GitGutterNextHunk

    if line('.') == line
        norm! gg
        GitGutterNextHunk
    endif
endfunction


" Cycle when it reaches the SOF.
function! GitGutterPrevHunkCycle()
    let line = line('.')
    silent! GitGutterPrevHunk

    if line('.') == line
        norm! G
        GitGutterPrevHunk
    endif
endfunction


nnoremap <Leader>gg :GitGutterToggle<CR>
nnoremap ge :call GitGutterNextHunkCycle()<CR>zz
nnoremap gu :call GitGutterPrevHunkCycle()<CR>zz
" nnoremap ge :GitGutterNextHunk<CR>zz
" nnoremap gu :GitGutterPrevHunk<CR>zz
nnoremap gp :GitGutterPreviewHunk<CR>zz
nnoremap gk :GitGutterUndoHunk<CR>zz
