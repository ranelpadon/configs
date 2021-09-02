let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [[ 'mode', 'paste' ], ['readonly', 'filename', 'modified']]
    \ },
    \ 'tabline': {
    \   'left': [['buffers']],
    \   'right': [[]]
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ }
    \ }

let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#filename_modifier = ':p:.'

" Remove the pipe character as separator.
let g:lightline.tabline_separator = { 'left': '', 'right': '' }
let g:lightline.tabline_subseparator = { 'left': '', 'right': '' }


" Improve the tabline colors
let one_dark_black = '#282c34'
let one_dark_white = '#abb2bf'
let one_dark_gray = '#5c6370'
let transparent_term_color = 'NONE'

" See `:help internal-variables` for `s:p`.
let s:p = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:p.tabline.left = [[one_dark_gray, one_dark_black, transparent_term_color, transparent_term_color]]
let s:p.tabline.tabsel = [[one_dark_white, one_dark_black, transparent_term_color, transparent_term_color]]
let s:p.tabline.middle = [[one_dark_black, one_dark_black, transparent_term_color, transparent_term_color]]


" Clickable buffer tabs when in Neovim
if g:is_nvim
    let g:lightline#bufferline#clickable = 1
    let g:lightline.component_raw = {'buffers': 1}
endif
