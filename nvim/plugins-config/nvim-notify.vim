" Ways to check if plugin is installed:
" https://vi.stackexchange.com/questions/10939/how-to-see-if-a-plugin-is-active
if has_key(plugs, 'nvim-notify')
    " lua require('notify')('Hello World')
    lua vim.notify = require('notify')

    " Useful when dubegging scripts.
    " lua vim.notify('Hello World')

    " To print a debug message just type `lvn` and the variable:
    iabbrev lvn lua vim.notify('')<Left><Left><C-R>=Eatchar('\s')<CR>
    " For sanity checking of the `vim-notify` plugin:
    cabbrev lvn lua vim.notify('')<Left><Left><C-R>=Eatchar('\s')<CR>
endif
