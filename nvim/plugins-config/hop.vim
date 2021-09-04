lua require'hop'.setup {keys = 'neioarstkgluyhmpfwqdcv', term_seq_bias = 0.5}

hi HopNextKey guifg=#E06C75
hi HopNextKey1 guifg=#E06C75
hi HopNextKey2 guifg=#E06C75
hi HopUnmatched guifg=#4b5263

noremap s :HopChar1<CR>
onoremap s v:HopChar1<CR>

