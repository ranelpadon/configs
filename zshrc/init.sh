# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]
# then
#     source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# https://stackoverflow.com/questions/51006002/how-do-i-get-intellij-terminal-to-work-properly-with-oh-my-zsh
# https://intellij-support.jetbrains.com/hc/en-us/community/posts/360003553899-Change-colors-for-Oh-my-zsh-in-PHPStorm-terminal
# system-wide environment settings for zsh(1)
if [[ -x /usr/libexec/path_helper ]]
then
	eval `/usr/libexec/path_helper -s`
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# https://github.com/romkatv/powerlevel10k
# Main `p10k` configuration.
# Run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=60

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins can be found in `~/.oh-my-zsh/plugins/*`.
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-completions zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh


# Fix the annoying gap in the right prompt!
# Doesn't work though (and causes double prompts!):
# https://superuser.com/questions/655607/removing-the-useless-space-at-the-end-of-the-right-prompt-of-zsh-rprompt
# ZLE_RPROMPT_INDENT=0

preexec() {
    # Add newline before command output for better vertical spacing.
    echo ''
}

ez() {
    exec zsh
}

# This conflicts with `fzf`'s Ctrl-R for command history.
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[3 q"
# }

# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"


# Define $M1 and other vars for reuse in other scripts.
if [[ $(uname -m) == 'arm64' ]]
then
    M1='true'
    HOMEBREW='/opt/homebrew'
else
    M1='false'
    HOMEBREW='/usr/local'
fi
export PATH="$HOMEBREW/bin:$PATH"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [[ $? -eq 0 ]]
then
    eval "$__conda_setup"
else
    if [[ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]]
    then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
