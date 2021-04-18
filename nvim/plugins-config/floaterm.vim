let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

if !g:is_vim
    nnoremap  <silent>  <C-Space>  :FloatermToggle<CR>
    tnoremap  <silent>  <C-Space>  <C-\><C-n>:FloatermToggle<CR>
else
    " Vim has no support for <C-Space>, unlike Nvim/MacVim.
    " https://github.com/neoclide/coc.nvim/issues/2176#issuecomment-658911940
    nnoremap  <silent>  <F5>  :FloatermToggle<CR>
    tnoremap  <silent>  <F5>  <C-\><C-n>:FloatermToggle<CR>
endif

" Default: '─│─│┌┐┘└'
let g:floaterm_borderchars = '· · ····'
let g:floaterm_title = ''

highlight FloatermBorder guibg=#282c34 guifg=#61afef