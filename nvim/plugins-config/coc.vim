" After launch, focus on editor, not on explorer.
function FocusEditor()
    :CocCommand explorer --sources file+ --no-focus
endfunction

augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * call FocusEditor()
augroup END
nmap <Leader>e :CocCommand explorer --sources file+<CR>

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

highlight CocErrorHighlight ctermfg=Red  guifg=#e06c75
highlight CocErrorSign  ctermfg=Red guifg=#e06c75

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if g:is_nvim
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" nmap <silent> gd <Plug>(coc-definition)
" Search definitions: coc -> tags -> searchdecl
function! s:GoToDefinition()
    if CocAction('jumpDefinition')
        return v:true
    endif

    let ret = execute('silent! normal \<C-]>')
    if ret =~ 'Error' || ret =~ '错误'
        call searchdecl(expand('<cword>'))
    endif
endfunction
nmap <silent> gd :call <SID>GoToDefinition()<CR>

" `gr` conflicts with `ReplaceWithRegister`.
" Be careful with other mapping like `gv` since it conflicts with Indent Object's `ii` for some reason.
nmap <silent> gz <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)

" Use K to show documentation in preview window.
nnoremap <silent> <leader>sd :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)
