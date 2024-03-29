ETS=$HOME/dev/ticketing-v2

# Choose the right Py2 depending on the MacBook type.
if [[ $M1 == 'true' ]]
then
    PY27=/opt/homebrew/Caskroom/miniforge/base/envs/ticketing/bin/python
else
    PY27=$HOME/.pyenv/versions/2.7.17/envs/ticketing/bin/python
fi


# Replace vi/vim as default when triggerred in some contexts.
# https://github.com/kdheepak/lazygit.nvim/issues/22#issuecomment-903164348
export GIT_EDITOR=nvim
export VISUAL="$GIT_EDITOR"
export EDITOR="$GIT_EDITOR"
export COLORTERM="truecolor"

# Use `one-dark` theme in `fd`, `exa`, `ls`, etc.
# Download the binary instead of compiling via Homebrew!
# https://github.com/sharkdp/vivid/releases
# https://github.com/sharkdp/vivid
# https://github.com/sharkdp/vivid/blob/master/themes/one-dark.yml
alias vivid="$HOME/dev/binaries/vivid-v0.8.0/vivid"
export LS_COLORS="$(vivid generate one-dark)"

# `nnn` terminal file manager.
export NNN_PLUG='p:preview-tui;t:preview-tabbed;d:dragdrop;v:imgview'
export NNN_BMS='r:"$HOME/Data/UP DGE/Resources"'
export NNN_FIFO='$HOME/tmp/nnn.fifo'

# Doom Emacs
export PATH="~/.emacs.d/bin:$PATH"
export PATH="$HOMEBREW/opt/node@12/bin:$PATH"

# --body-numbering 'all-lines' (number the blank lines also)
alias nl='nl -b a $1'
alias ll='exa --long --icons --all --group-directories-first'
# alias lg='~/dev/binaries/lazygit/lazygit'
# alias lazygit='~/dev/binaries/lazygit/lazygit'

function _lazygit() {
    fix_python_files

    if [[ $M1 == 'true' ]]
    then
        $HOMEBREW/bin/lazygit
    else
        $HOMEBREW/bin/lazygit
    fi

}
alias lg='_lazygit'
alias lazygit='_lazygit'

# Karabiner/BTT sends <C-P> which zsh/Vim interprets as the EOL.
# https://jdhao.github.io/2019/06/13/zsh_bind_keys/
# Not needed anymore due to Home/End key rebinding in `alacritty.yml`.
# bindkey '^P' end-of-line


# Remap the delete word/line shortcuts.
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Keymaps
# Alternative: https://github.com/jeffreytse/zsh-vi-mode
# Remap: C-w
bindkey '^u' backward-kill-word
# Remap: A-d
bindkey '^e' kill-word
# Remap: C-u
bindkey '^l' backward-kill-line
# Remap: A-k
bindkey '^y' kill-line


# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"


# configs_link "~/Library/Application Support/lazygit/config.yml"
configs_link() {
    cp $1 $CONFIGS
    mv $1 "$1_orig"
    filename="$(basename -- $1)"
    ln -s $CONFIGS/$filename $1
}


# `find-and-replace`
# Usage: far foo bar --commit
far() {
    fd . | sad $@
}


# Building takes a long time, and could have errors.
# Just download the pre-built binaries:
# https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-download
alias nvim="$HOME/dev/binaries/nvim-osx64/bin/nvim"

# Nvim - Mac M1
# export PATH="$HOMEBREW/opt/node@12/bin:$PATH"

# ETS node@13
alias node13="$HOME/dev/binaries/node-v13.14.0/bin/node"
alias npm13="$HOME/dev/binaries/node-v13.14.0/bin/npm"
export PATH="$HOME/dev/binaries/node-v13.14.0/bin:$PATH"

# Node@12
# alias node12="$HOME/dev/binaries/node-v12.22.3/bin/node"
# alias npm12="$HOME/dev/binaries/node-v12.22.3/bin/npm"
# export PATH="$HOME/dev/binaries/node-v12.22.3/bin:$PATH"


Sad() {
    fd . | sad $1 $2
}


# Sample: `pipe_command_output_to_file tb common.voucher`
pipe_command_output_to_file() {
    # Create a new file in Desktop.
    FILE=~/Desktop/pipe.txt
    touch $FILE
    chmod 777 $FILE

    echo 'Created ~/Desktop/pipe.txt ...'

    # > file redirects stdout to file
    # 1> file redirects stdout to file
    # 2> file redirects stderr to file
    # &> file redirects stdout and stderr to file
    # & (in 2>&1) specifies that 1 is not a file name but a file descriptor.
    $@ > $FILE 2>&1
}


# Go to previous directory.
cdp() {
    cd -
}


# Some of helm chart values file have tabs
# causing issue with YAML parsers.
tabs_to_spaces() {
    expand -t 4 $1 | sponge $1
}
