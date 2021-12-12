ETS=$HOME/dev/ticketflap/ticketing
PY27=$HOME/.pyenv/versions/2.7.17/envs/ticketing/bin/python


# Replace vi/vim as default when triggerred in some contexts.
# https://github.com/kdheepak/lazygit.nvim/issues/22#issuecomment-903164348
export GIT_EDITOR=nvim
export VISUAL="$GIT_EDITOR"
export EDITOR="$GIT_EDITOR"
export COLORTERM="truecolor"

# `nnn` terminal file manager.
export NNN_PLUG='p:preview-tui;t:preview-tabbed;d:dragdrop;v:imgview'
export NNN_BMS='r:"$HOME/Data/UP DGE/Resources"'
export NNN_FIFO='$HOME/tmp/nnn.fifo'

# Doom Emacs
export PATH="/Users/ranelpadon/.emacs.d/bin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"


# --body-numbering 'all-lines' (number the blank lines also)
alias nl='nl -b a $1'
alias ll='exa --long --icons --all --group-directories-first'
alias lg='lazygit'


# Karabiner/BTT sends <C-Z> which zsh/Vim interprets as the EOL.
# https://jdhao.github.io/2019/06/13/zsh_bind_keys/
bindkey '^Z' end-of-line


# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"


# configs_link "/Users/ranelpadon/Library/Application Support/lazygit/config.yml"
configs_link() {
    cp $1 $CONFIGS
    mv $1 "$1_orig"
    filename="$(basename -- $1)"
    ln -s $CONFIGS/$filename $1
}


# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
