" https://github.com/sheerun/vim-polyglot#language-packs
" let g:polyglot_disabled = [
" \    'css',
" \    'docker',
" \    'html5',
" \    'javascript',
" \    'json',
" \    'php',
" \    'python',
" \    'python-indent',
" \]

call plug#begin('~/.config/nvim/autoload/plugged')
    " Plug 'nathom/filetype.nvim'

    " If installed using Homebrew
    set rtp+=/usr/local/opt/fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
    Plug 'junegunn/fzf.vim'
    " Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
    " Plug 'lotabout/skim.vim'
    " Plug 'camspiers/snap'
    " Plug 'sineto/fzy.nvim'
    " Plug 'mfussenegger/nvim-fzy'
    " Plug 'bfrg/vim-fzy'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    if has('nvim')
        Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'gelguy/wilder.nvim'
    endif
    Plug 'wincent/ferret'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'mgedmin/python-imports.vim'
    Plug 'dense-analysis/ale'
    Plug 'voldikss/vim-floaterm'
    Plug 'pbogut/fzf-mru.vim'
    Plug 'wsdjeg/vim-fetch'

    Plug 'moll/vim-bbye'
    Plug 'preservim/tagbar'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'yggdroot/indentline'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'tpope/vim-commentary'
    Plug 'ap/vim-css-color'
    Plug 'mattn/emmet-vim'

    " Fix issue with `scrolloff=999` when operating on the end of file:
    " normal mode is ok, but once you edit, the cursor moves back to bottom.
    " This plugin has issue when scrolling/clicking with mouse!
    " Plug 'vim-scripts/scrollfix'

    Plug 'psliwka/vim-smoothie'
    " Plug 'karb94/neoscroll.nvim'

    " Plug 'justinmk/vim-sneak'
    " Plug 'easymotion/vim-easymotion'
    Plug 'phaazon/hop.nvim'
    " Plug 'ggandor/lightspeed.nvim'
    Plug 'mg979/vim-visual-multi'
    Plug 'haya14busa/vim-asterisk'
    Plug 'RRethy/vim-tranquille'
    if !g:is_nvim
        Plug 'obcat/vim-hitspop'
    endif

    " Seems not working!
    " https://github.com/henrik/vim-indexed-search#alternatives
    " Plug 'osyo-manga/vim-anzu'
    " Plug 'henrik/vim-indexed-search'
    " Plug 'google/vim-searchindex'

    Plug 'jiangmiao/auto-pairs'
    Plug 'sheerun/vim-polyglot'

    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                 " We recommend updating the parsers on update
    " Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    " Plug 'RRethy/nvim-treesitter-textsubjects'
    " BAD: Plug 'navarasu/onedark.nvim'
    " GOOD: Plug 'monsonjeremy/onedark.nvim'
    " TO-TRY: Plug 'ful1e5/onedark.nvim'

    Plug 'ray-x/guihua.lua'  "lua GUI lib
    Plug 'ray-x/sad.nvim'

    Plug 'wellle/targets.vim'
    Plug 'michaeljsmith/vim-indent-object'

    if !g:is_nvim
        Plug 'machakann/vim-highlightedyank'
    endif
    Plug 'vim-scripts/ReplaceWithRegister'

    if g:is_nvim
        Plug 'kdheepak/lazygit.nvim'
        Plug 'f-person/git-blame.nvim'
    endif
    Plug 'airblade/vim-gitgutter'
    Plug 'rhysd/git-messenger.vim'
    " Plug 'Xuyuanp/scrollbar.nvim'
    Plug 'dstein64/nvim-scrollview'
    Plug 'itchyny/vim-gitbranch'
    Plug 'rhysd/conflict-marker.vim'

    Plug 'joshdick/onedark.vim'
    Plug 'tweekmonster/startuptime.vim'
call plug#end()
