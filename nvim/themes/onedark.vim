" onedark.vim override: Don't set a background color when running in a terminal;
if (has("autocmd") && !has("gui_running"))
    augroup colorset
        autocmd!
        let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16": "7" }
        " `bg` will not be styled since there is no `bg` setting
        autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) 
    augroup END
endif

hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=16

syntax on
syntax enable
colorscheme onedark

set termguicolors
" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif