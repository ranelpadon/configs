let g:lightline = {
\   'colorscheme': 'one',
\   'active': {
\       'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'filename', 'modified']],
\       'right': [['lineinfo'], ['percent'], ['searchcount']],
\   },
\   'tabline': {
\       'left': [['buffers']],
\       'right': [[]]
\   },
\   'component_function': {
\       'filename': 'LightlineFilename',
\       'gitbranch': 'gitbranch#name',
\       'searchcount': 'SearchCount'
\   },
\   'component_expand': {
\       'buffers': 'lightline#bufferline#buffers'
\   },
\   'component_type': {
\       'buffers': 'tabsel'
\   }
\ }

function! LightlineFilename()
    return expand('%:p:.') !=# '' ? expand('%:p:.') : '[No Name]'
endfunction


function! SearchCount() abort
    let result = searchcount()
    if empty(result.total)
        return ''
    endif
    " return result.total
    return printf('%d/%d', result.current, result.total)
endfunction

" let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#smart_path = 0
" Show only the filename.
let g:lightline#bufferline#filename_modifier = ':t'
" let g:lightline#bufferline#show_number = 2
" let g:lightline#bufferline#number_separator = '|'

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

    " Prevent opening buffer in sidebar.
    autocmd User LightlineBufferlinePreClick :wincmd l
    " let g:lightline#bufferline#click_handler_pre_command = 'wincmd l'
endif

" Fast buffer switching when multiple ones are opened.
" nmap 1 <Plug>lightline#bufferline#go(1)
" nmap 2 <Plug>lightline#bufferline#go(2)
" nmap 3 <Plug>lightline#bufferline#go(3)
" nmap 4 <Plug>lightline#bufferline#go(4)
" nmap 5 <Plug>lightline#bufferline#go(5)
" nmap 6 <Plug>lightline#bufferline#go(6)
" nmap 7 <Plug>lightline#bufferline#go(7)
" nmap 8 <Plug>lightline#bufferline#go(8)
" nmap 9 <Plug>lightline#bufferline#go(9)
" nmap 0 <Plug>lightline#bufferline#go(10)
