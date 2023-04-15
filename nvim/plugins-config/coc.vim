" M1 - MacVim couldn't detect the `node` path for some reason.
if !executable('node')
    " let g:coc_node_path = '/opt/homebrew/opt/node@12/bin/node'
    " let g:coc_node_path = '/Users/ranelpadon/dev/binaries/node-v12.22.3/bin/node'
endif


" After launch, focus on editor, not on explorer.
function FocusEditor()
    :CocCommand explorer --sources file+ --no-focus
endfunction

augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * call FocusEditor()
augroup END

" Toggle explorer (`te`)
nnoremap <Leader>te :CocCommand explorer --sources file+<CR>


" Focus the file.
noremap <Leader>o :on<CR> <bar> :CocCommand explorer --sources file+<CR>

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


" To find the highlight groups:
" `:highlight Coc*`
highlight CocErrorHighlight ctermfg=Red  guifg=#E06C75
highlight CocErrorSign  ctermfg=Red guifg=#E06C75

highlight CocExplorerFileDiagnosticError ctermfg=Yellow guifg=#D19A66
highlight CocExplorerFileDiagnosticWarning ctermfg=Yellow guifg=#D19A66
highlight CocExplorerFileFilenameDiagnosticError ctermfg=Yellow guifg=#D19A66
highlight CocExplorerFileFilenameDiagnosticWarning ctermfg=Yellow guifg=#D19A66

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
nmap <silent> gd :call <SID>GoToDefinition()<CR>zz

" Use ctags
nmap <Leader>gd <C-]>zz

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
" nmap <Leader>rn <Plug>(coc-rename)

" Restart when COC crashed for some reason.
nmap <Leader>cr :CocRestart<CR>


function StartsWith(longer, shorter) abort
    " Check if the `shorter` is found at the start index which is zero.
    return stridx(a:longer, a:shorter) == 0
endfunction

let b:python_version = system('python --version')
let b:is_py3 = StartsWith(b:python_version, 'Python 3')


" Set the Python interpreter dynamically, depending on the virtualenv.
" Instead of setting `python.pythonPath` in `coc-settings.json`.
autocmd FileType python call coc#config('python', {'pythonPath': split(execute('!which python'), '\n')[-1]})


if b:is_py3
    echom 'Py3 detected, will use a custom `coc` data folder!'
    let g:coc_data_home = expand('~/.config/coc_py3_pyright')
else
    echom 'Py2 detected, will use the default `coc` data folder!'
endif

" For syntax highlighting of comments in JSONC files (JSON + Comments)
" like in `coc-settings.json`.
autocmd FileType json syntax match Comment +\/\/.\+$+

" Refactoring, couldn't detect `rope` Python package even it's installed.
" Triggered also by visual selection then `:CocAction`.
" https://github.com/neoclide/coc-python/issues/44
" xmap ,a  <Plug>(coc-codeaction-selected)
" nmap ,a  <Plug>(coc-codeaction-selected)

" Notes for `coc-pyright` issues when using Py3/Node13:
" To install for Node13: `:CocInstall coc-pyright@1.1.282`
" https://github.com/fannheyward/coc-pyright/issues/834#issuecomment-1399338962
" `coc-pyright` works both in Py2/Py3.

" `coc-pyright` vs `coc-python`:
" https://github.com/fannheyward/coc-pyright/issues/116#issue-730311715

" `coc-pyright` vs `coc-jedi`:
" https://github.com/fannheyward/coc-pyright/issues/431#issuecomment-816341062

" `coc-pyright` requires rope for Refactoring.

" For debugging `Coc`, run `:CocInfo` and `:CocOpenLog`.

" For custom coc-settings.json file/overrides:
" `:help coc-configuration`
