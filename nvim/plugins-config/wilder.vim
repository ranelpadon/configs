call wilder#setup({
\   'modes': [':', '/', '?'],
\   'next_key': '<Down>',
\   'previous_key': '<Up>',
\   'accept_key': '<Tab>',
\   'reject_key': '<Esc>',
\ })

call wilder#set_option('renderer', wilder#popupmenu_renderer({
\   'highlighter': wilder#basic_highlighter(),
\ }))
