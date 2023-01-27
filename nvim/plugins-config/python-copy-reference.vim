let g:python_copy_reference = {
    \ 'remove_prefixes': ['apps', 'conf']
\ }

nnoremap <Leader>fi :PythonCopyReferenceDotted<CR>
nnoremap ,fi :PythonCopyReferenceImport<CR>
nnoremap ,Fi :PythonCopyReferencePytest<CR>
