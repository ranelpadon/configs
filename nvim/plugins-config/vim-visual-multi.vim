" https://github.com/mg979/vim-visual-multi/wiki/Mappings
let g:VM_maps = {}

" Replace <C-n>
let g:VM_maps['Find Under'] = 'gm'
" Replace visual <C-n>
let g:VM_maps['Find Subword Under'] = 'gm'

" https://github.com/mg979/vim-visual-multi/issues/187#issuecomment-908988989
let g:VM_maps['i'] = 'a'
let g:VM_maps['I'] = 'A'
let g:VM_maps['a'] = 'o'
let g:VM_maps['A'] = 'O'
let g:VM_maps['o'] = 'i'
let g:VM_maps['O'] = 'I'
" let g:VM_maps["Find Next"] = 'm'
" let g:VM_maps["Find Prev"] = 'M'
" let g:VM_maps["Toggle Multiline"] = ''

let g:VM_custom_remaps = {'m': 'n', 'M': 'N'}
let g:VM_maps['Undo'] = 'k'
let g:VM_maps['Redo'] = '<C-r>'


" Go back to Normal mode immediately after doing VM Insert.
function! VM_Start()
    " Center stuff.
    set scrolloff=999
    imap <buffer> <Esc> <Esc><Esc>
endfun
function! VM_Exit()
    iunmap <buffer> <Esc>
    " Back to default centering.
    set scrolloff=0
endfun


function! CurrentWordSelect()
   execute "normal \<Plug>(VM-Find-Under)"
endfunction

" nnoremap gm :call CurrentWordSelect()<CR>


" Normal way: v + HopChar1 + <C-d>
" Better way: gm + HopChar1
" Best way: gm + <motion>
" function! SubWordSelect(command)
"     normal v

"     " Run commands like `:HopChar1`.
"     execute a:command
"
" endfunction

" nnoremap <Leader>gm :call SubWordSelect('HopChar1')<CR>


function! SubWordSelect(type)
    " Get the char-wise motion.
    let START_CHAR = "`["
    let END_CHAR = "`]"

    " Run command like `vfa`.
    execute "normal v" . END_CHAR
    execute "normal \<Plug>(VM-Find-Subword-Under)"
endfunction

" nnoremap <Leader>gm :set operatorfunc=SubWordSelect<CR>g@
