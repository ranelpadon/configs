lua require'hop'.setup {keys = 'neioarstkgluyhmpfwqdcv', term_seq_bias = 0.5}

hi HopNextKey guifg=#FCB6D4
hi HopNextKey1 guifg=#FCB6D4
hi HopNextKey2 guifg=#FCB6D4

noremap f :HopChar1<CR>
onoremap f v:HopChar1<CR>

