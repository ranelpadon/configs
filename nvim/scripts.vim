" `%:p` will give the absolute file path also, alternative to `<afile>`.
" `silent` to skip the confirmation prompt.
autocmd BufWritePost *.py silent ! ~/dev/configs/nvim/scripts/post_save.sh <afile>
