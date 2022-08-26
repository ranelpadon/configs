" lua require('hop').setup {keys = 'neioarstkgluyhmpfwqdcv', term_seq_bias = 0.5, inclusive_jump = true, hint_offset = 0}
lua require('hop').setup {keys = 'neioarstkgluyhmpfwqdc', hint_offset = -1}
" lua require('hop').setup {keys = 'neioarstkgluyhmpfwqdc'}


hi HopNextKey guifg=#E06C75
hi HopNextKey1 guifg=#E06C75
hi HopNextKey2 guifg=#E06C75
hi HopUnmatched guifg=#4B5263


function ExecuteThenCenterScreenVertically(command)
    " normal v
    " Run commands like `:HopChar1`.
    execute a:command
    normal zz
endfunction

function VisuallyExecute(command)
    normal v
    " Run commands like `:HopChar1`.
    execute a:command
    " normal zz
endfunction

" function RangeSelect(command)
"     " normal v
"     " Run commands like `:HopChar1`.
"     " execute a:command
"     execute "normal!" .. "\<C-d>"
"    " execute "\<Plug>(VM-Find-Under)"
"    " execute "normal!" .. "\<Plug>(VM-Find-Under)"
"    " <Plug>(VM-Find-Under)
" endfunction

" " map F <Plug>(VM-Find-Under)
" map F :call RangeSelect('HopChar1')<CR>

" Cmd+f via BTT.
map <F1>f /

" nmap f :call ExecuteThenCenterScreenVertically('HopChar1')<CR>
" For verb-subject operations.
" omap f :call VisuallyExecute('HopChar1')<CR>
" For `vim-visual-multi` cursor.
" xmap f <Cmd>HopChar1<CR>
" omap f v<Cmd>HopChar1<CR>
omap f v<Cmd>HopChar1<CR>

" map F v<Cmd>HopChar1<CR>
" nnoremap f :call ExecuteThenCenterScreenVertically('HopChar1')<CR>
" omap f <Cmd>HopChar1<CR>

" Use `v` so that it's an inclusive operation!
" map s v<Cmd>HopChar1<CR>

" nnoremap F V<Cmd>HopChar1<CR>

" map f <Cmd>HopChar1CurrentLineAC<CR>
" omap f v<Cmd>HopChar1CurrentLineAC<CR>

" map F <Cmd>HopChar1CurrentLineBC<CR>
" omap F v<Cmd>HopChar1CurrentLineBC<CR>

