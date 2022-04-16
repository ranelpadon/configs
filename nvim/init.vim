" Start vim without plugins:
" vim -u NONE file.txt

runtime settings.vim
runtime plugins.vim
runtime mappings.vim

" `!` is needed to load all files in the folder.
runtime! themes/*.vim
runtime! plugins-config/*.vim
