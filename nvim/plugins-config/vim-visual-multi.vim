" https://github.com/mg979/vim-visual-multi/wiki/Mappings

let g:VM_maps = {}

" Replace <C-n>
let g:VM_maps['Find Under'] = '<C-d>'
" Replace visual <C-n>
let g:VM_maps['Find Subword Under'] = '<C-d>'

let g:VM_maps['i'] = 'o'
let g:VM_maps['I'] = 'O'
" let g:VM_maps["Find Next"] = 'm'
" let g:VM_maps["Find Prev"] = 'M'
" let g:VM_maps["Toggle Multiline"] = ''

let g:VM_custom_remaps = {'m': 'n', 'M': 'N'}
let g:VM_maps['Undo'] = 'k'
let g:VM_maps['Redo'] = '<C-r>'

" Go back to Normal mode immediately after doing VM Insert.
fun! VM_Start()
    imap <buffer> <Esc> <Esc><Esc>
endfun
fun! VM_Exit()
    iunmap <buffer> <Esc>
endfun
