export PYTHONWARNINGS=ignore
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# So that arrow navigation and history will work when in Python REPL mode.
export PYTHONSTARTUP=$HOME/.python_startup.py

# used by Python's sys.stdout.encoding
export LANG=en_US.UTF-8 # Fix for some unit tests also
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Make the Python console/interpreter UTF-8 compatible
export PYTHONIOENCODING=UTF-8

# PyEnv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    # eval "$(pyenv virtualenv-init -)"  # Optional.
fi

if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)";
fi

# `quiet` mode means to disable the POWERLEVEL instant prompt.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Crucial export.
# Debugging: PYENV_DEBUG=1 pyenv versions
export PATH=$(pyenv root)/shims:$PATH


# For this warning: pyenv: python3: command not found
# 3.8.4 contains the py-neovim.
pyenv global 2.7.17 3.8.4


pat() {
    pyenv activate ticketing
    eit
}

pai() {
    pyenv activate 3_10_0__ipython
}


# Command: yvt URL START_TIME END_TIME
# Sample: yvt https://www.youtube.com/watch?v=sI-a64EVPPU 2:45 4:48.7
yt_video_trimmer() {
    # Set the working dir.
    cd ~/Desktop
    pyenv activate alloserv
    python ~/dev/scripts/video/yt-trimmer.py $1 $2 $3
}
alias yvt=yt_video_trimmer

# Command: vt FILE_PATH START_TIME END_TIME
# Sample: vt /Users/ranelpadon/Desktop/sample.mp4 2:45 4:48.7
video_trimmer() {
    # Set the working dir.
    cd ~/Desktop
    pyenv activate alloserv
    python ~/dev/scripts/video/trimmer.py $1 $2 $3
}
alias vt=video_trimmer


unrar() {
    $PY27 "$HOME/Data/UP DGE/Resources/Codes/uvle_processor/zip_processor.py" $1
}

pathx() {
    $PY27 "$HOME/Data/UP DGE/Resources/Codes/pathx.py" $1
}
