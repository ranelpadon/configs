let g:clever_f_smart_case = 1

" Sample: ctermfg=green ctermbg=NONE cterm=bold,underline guifg=blue guibg=NONE gui=bold,underline
highlight DraculaGreen guifg=#5fff87
highlight DraculaMagenta guifg=#ff87d7
highlight DraculaPurple guifg=#af87ff

let g:clever_f_mark_char = 1
let g:clever_f_mark_char_color = 'DraculaGreen'
let g:clever_f_across_no_line = 1
let g:clever_f_not_overwrites_standard_mappings = 1


" With inclusive Backward F/T operation.
nmap f <Plug>(clever-f-f)
omap f <Plug>(clever-f-f)
nmap F <Plug>(clever-f-F)
omap F v<Plug>(clever-f-F)
nmap t <Plug>(clever-f-t)
omap t <Plug>(clever-f-t)
nmap T <Plug>(clever-f-T)
omap T v<Plug>(clever-f-T)


" function! InclusiveOperation()
"     exec "normal! v\<Plug>(clever-f-F)"
" endfunction
" onoremap F v<Cmd>clever_f#find_with('F')<CR>
" onoremap F :call InclusiveOperation()<CR>
" onoremap T v<Plug>(clever-f-T)
