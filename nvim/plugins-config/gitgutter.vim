function! GitGutterNextHunkAllBuffers()
    let line = line('.')
    GitGutterNextHunk

    if line('.') != line
        return
    endif

    let bufnr = bufnr('')
    while 1
        bnext
        if bufnr('') == bufnr
            return
        endif

        if !empty(GitGutterGetHunks())
            1
            GitGutterNextHunk
            return
        endif
    endwhile
endfunction


function! GitGutterPrevHunkAllBuffers()
    let line = line('.')
    GitGutterPrevHunk

    if line('.') != line
        return
    endif

    let bufnr = bufnr('')
    while 1
        bprevious
        if bufnr('') == bufnr
            return
        endif

        if !empty(GitGutterGetHunks())
            normal! G
            GitGutterPrevHunk
            return
        endif
    endwhile
endfunction


" Cycle when it reaches the EOF.
function! GitGutterNextHunkCycle()
    let line = line('.')
    GitGutterNextHunk

    if line('.') == line
        normal! gg
        " 1
        GitGutterNextHunk
    endif
endfunction


" Cycle when it reaches the SOF.
function! GitGutterPrevHunkCycle()
    let line = line('.')
    silent! GitGutterPrevHunk

    if line('.') == line
        normal! G
        " 1
        GitGutterPrevHunk
    endif
endfunction


nnoremap <Leader>gg :GitGutterToggle<CR>


" Same file.
nnoremap <Leader>e :call GitGutterNextHunkCycle()<CR>zz
nnoremap <Leader>u :call GitGutterPrevHunkCycle()<CR>zz


" Across files.
nnoremap ge :call GitGutterNextHunkAllBuffers()<CR>zz
nnoremap gu :call GitGutterPrevHunkAllBuffers()<CR>zz


" nnoremap ge :GitGutterNextHunk<CR>zz
" nnoremap gu :GitGutterPrevHunk<CR>zz
nnoremap gp :GitGutterPreviewHunk<CR>zz
nnoremap gk :GitGutterUndoHunk<CR>zz
