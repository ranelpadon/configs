" Plugin default already.
" nnoremap <Leader>gm <Plug>(git-messenger)

let g:git_messenger_always_into_popup = v:true
let g:git_messenger_include_diff = 'current'

" Disable the transparent overlay.
highlight gitmessengerPopupNormal term=None guibg=#282c34

" Override the mapping.
function! s:setup_git_messenger_popup() abort
    nnoremap <buffer><Esc> :<C-u>call gitmessenger#close_popup(bufnr('%'))<CR>
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
