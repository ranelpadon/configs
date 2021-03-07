call plug#begin('~/.config/nvim/autoload/plugged')

    Plug 'joshdick/onedark.vim'

    " If installed using Homebrew
    set rtp+=/usr/local/opt/fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
    Plug 'junegunn/fzf.vim'

    Plug 'voldikss/vim-floaterm'

    Plug 'haya14busa/vim-asterisk'
    Plug 'RRethy/vim-tranquille'
    Plug 'justinmk/vim-sneak'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'

    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-commentary'
    Plug 'airblade/vim-gitgutter'
    Plug 'APZelos/blamer.nvim'
    Plug 'bronson/vim-trailing-whitespace'

    Plug 'michaeljsmith/vim-indent-object'
    Plug 'vim-scripts/ReplaceWithRegister'
    Plug 'machakann/vim-highlightedyank'

call plug#end()