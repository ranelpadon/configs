" Docs: https://github.com/ludovicchabant/vim-gutentags/blob/master/doc/gutentags.txt

set statusline+=%{gutentags#statusline()}

augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

let g:gutentags_exclude_project_root = [
    \ '/Users/ranelpadon',
    \ '/Users/ranelpadon/dev/configs',
    \ '/Users/ranelpadon/dev/design-patterns',
    \ '/Users/ranelpadon/dev/elevenskies',
    \ '/Users/ranelpadon/dev/melco',
    \ '/Users/ranelpadon/dev/mgm'
    \ ]

let g:gutentags_exclude_filetypes = [
    \ 'css',
    \ 'html',
    \ 'po',
    \ 'sql',
    \ 'conf',
    \ 'sh',
    \ 'json',
    \ 'log',
    \ 'yml',
    \ 'sh',
    \ 'env'
    \ ]

let g:gutentags_ctags_exclude = [
    \ '.sass-cache',
    \ 'database',
    \ 'docker',
    \ 'docs',
    \ 'k8s',
    \ 'locale',
    \ 'logs',
    \ 'media',
    \ 'node_modules',
    \ 'qos',
    \ 'sites',
    \ 'static',
    \ ]
