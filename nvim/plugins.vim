call plug#begin('~/.config/nvim/autoload/plugged')
    " If installed using Homebrew
    set rtp+=/usr/local/opt/fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
    Plug 'junegunn/fzf.vim'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'mgedmin/python-imports.vim'
    Plug 'dense-analysis/ale'
    Plug 'voldikss/vim-floaterm'

    Plug 'preservim/tagbar'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'yggdroot/indentline'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'tpope/vim-commentary'
    Plug 'ap/vim-css-color'
    Plug 'mattn/emmet-vim'

    Plug 'psliwka/vim-smoothie'
    Plug 'justinmk/vim-sneak'
    Plug 'haya14busa/vim-asterisk'
    Plug 'RRethy/vim-tranquille'

    Plug 'jiangmiao/auto-pairs'
    Plug 'sheerun/vim-polyglot'

    Plug 'wellle/targets.vim'
    Plug 'michaeljsmith/vim-indent-object'

    if !g:is_nvim
        Plug 'machakann/vim-highlightedyank'
    endif
    Plug 'vim-scripts/ReplaceWithRegister'

    if g:is_nvim
        Plug 'kdheepak/lazygit.nvim'
    endif
    Plug 'airblade/vim-gitgutter'
    Plug 'rhysd/conflict-marker.vim'
    Plug 'APZelos/blamer.nvim'

    Plug 'joshdick/onedark.vim'
    Plug 'tweekmonster/startuptime.vim'
call plug#end()