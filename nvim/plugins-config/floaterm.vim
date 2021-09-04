let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

if !g:is_vim
    " Remove the default binding to `:help`.
    nnoremap <silent> <F6> <nop>
    nnoremap <silent> <F6> :FloatermToggle<CR>
    tnoremap <silent> <F6> <C-\><C-n>:FloatermToggle<CR>
else
    " Vim has no support for <C-Space>, unlike Nvim/MacVim.
    " https://github.com/neoclide/coc.nvim/issues/2176#issuecomment-658911940
    nnoremap <silent> <F6> :FloatermToggle<CR>
    tnoremap <silent> <F6> <C-\><C-n>:FloatermToggle<CR>
endif

" Default: '─│─│┌┐┘└'
let g:floaterm_borderchars = '· · ····'
let g:floaterm_title = ''

highlight FloatermBorder guibg=#282c34 guifg=#61afef
