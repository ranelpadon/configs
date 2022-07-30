if g:is_nvim
    let g:lazygit_floating_window_scaling_factor = 1.0

    " Fix the Python imports before showing the LazyGit.
    function! HookedLazyGit()
        silent ! ~/dev/configs/nvim/scripts/fix_python_files.sh
        LazyGit
    endfunction

    nnoremap <silent> <leader>lg :call HookedLazyGit()<CR>
endif
