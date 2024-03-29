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


if [[ $M1 == 'true' ]]
then
    # `conda` will throw this warning:
    # '<frozen importlib._bootstrap>:914: ImportWarning: _SixMetaPathImporter.find_spec() not found; falling back to find_module()'
    export PY_MGR=conda
    $PY_MGR activate ticketing
    # $PY_MGR activate py311
    eit
else
    # PyEnv
    # export PYENV_ROOT="$HOME/.pyenv"
    # export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1
    then
        eval "$(pyenv init -)"
        # eval "$(pyenv virtualenv-init -)"  # Optional.
    fi

    if which pyenv-virtualenv-init > /dev/null
    then
        eval "$(pyenv virtualenv-init -)";
    fi

    export PY_MGR=pyenv

    # Crucial export.
    # Debugging: PYENV_DEBUG=1 pyenv versions
    export PATH=$(pyenv root)/shims:$PATH

    # For this warning: pyenv: python3: command not found
    # 3.8.4 contains the py-neovim.
    pyenv global 2.7.17 3.8.4
fi


# `quiet` mode means to disable the POWERLEVEL instant prompt.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet


pat() {
    $PY_MGR activate ticketing
    eit
}

pai() {
    $PY_MGR activate 3_10_0__ipython
}


# Command: yvt URL START_TIME END_TIME
# Sample: yvt https://www.youtube.com/watch?v=sI-a64EVPPU 2:45 4:48.7
yt_video_trimmer() {
    # Set the working dir.
    cd ~/Desktop
    $PY_MGR activate alloserv
    python ~/dev/scripts/video/yt-trimmer.py $1 $2 $3
}
alias yvt=yt_video_trimmer

# Command: vt FILE_PATH START_TIME END_TIME
# Sample: vt ~/Desktop/sample.mp4 2:45 4:48.7
video_trimmer() {
    # Set the working dir.
    cd ~/Desktop
    # $PY_MGR activate alloserv
    python ~/dev/scripts/video/trimmer.py $1 $2 $3
}
alias vt=video_trimmer


_lotc_init() {
    $PY_MGR activate py311
    cd ~/Desktop
}
lotcd() {
    _lotc_init
    lotc download $@
    cd -
}
lotct() {
    _lotc_init
    lotc trim $@
    cd -
}
lotcm() {
    _lotc_init
    lotc merge $@
    cd -
}


unrar() {
    $PY27 "$HOME/Data/UP DGE/Resources/Codes/uvle_processor/zip_processor.py" $1
}

pathx() {
    $PY27 "$HOME/Data/UP DGE/Resources/Codes/pathx.py" $1
}


_pyfix() {
    # Exclude D (Deleted) in `--diff-filter`.
    CHANGED_PYTHON_FILES=$(git diff --name-only --diff-filter=ACMR | rg '.py')
    BLUE='\e[1;34m'
    NC='\e[0m'  # No Color

    echo "${BLUE}isort check: $NC"
    echo $CHANGED_PYTHON_FILES | xargs isort --check-only

    echo
    echo "${BLUE}autoflake check: $NC"
    echo $CHANGED_PYTHON_FILES | xargs autoflake --remove-all-unused-imports --exclude 'conf/settings/*' --check
}
pyfix() {
    # Exclude D (Deleted) in `--diff-filter`.
    CHANGED_PYTHON_FILES=$(git diff --name-only --diff-filter=ACMR | rg '.py')
    BLUE='\e[1;34m'
    NC='\e[0m'  # No Color

    echo "${BLUE}isort fix: $NC"
    echo $CHANGED_PYTHON_FILES | xargs isort

    echo
    echo "${BLUE}autoflake fix: $NC"
    echo $CHANGED_PYTHON_FILES | xargs autoflake --in-place --remove-all-unused-imports --exclude 'conf/settings/*'
}


create_conda_environment() {
    # Create a conda environment using x86 architecture.
    # $1 is environment name, all subsequent arguments will be passed to `conda create`.
    # Example: create_conda_environment ticketing python=2.7

    # Installs the x86_64/i386 Python installer.
    CONDA_SUBDIR=osx-64 conda create --name $@
    conda activate $1

    # Set to use install packages for x86_64/i386 in ~/.condarc.
    # https://docs.conda.io/projects/conda/en/stable/commands/config.html
    conda config --env --set subdir osx-64
}


# python whitelabels.py
w() {
    cd ~/dev/whitelabels/scripts/python
    python whitelabels.py $@
}


wut() {
    w update TEST $@
}
wrt() {
    w reset TEST $@
}
wct() {
    w commit TEST $@
}
wdt() {
    w deploy TEST $@
}
wctdt() {
    w create_tag_and_deploy TEST $@
}
wvrnt() {
    w view_release_notes TEST $@
}
wcrnt() {
    w create_release_notes TEST $@
}


wus() {
    w update STAG $@
}
wrs() {
    w reset STAG $@
}
wcs() {
    w commit STAG $@
}
wds() {
    w deploy STAG $@
}
wctds() {
    w create_tag_and_deploy STAG $@
}
wvrns() {
    w view_release_notes STAG $@
}
wcrns() {
    w create_release_notes STAG $@
}


wup() {
    w update PROD $@
}
wrp() {
    w reset PROD $@
}
wcp() {
    w commit PROD $@
}
wdp() {
    w deploy PROD $@
}
wvrnp() {
    w view_release_notes PROD $@
}
wcrnp() {
    w create_release_notes PROD $@
}


# mouse_mover.py
mouse_mover() {
    cd ~/dev/scripts
    python mouse_mover.py
    cd -
}
alias mm=mouse_mover

# `cd` to current env's `site-packages` folder.
cdsp() {
    site_packages_folder=$(python -c 'import site; print(site.getsitepackages()[0])')
    cd $site_packages_folder
}


pip_build_upload() {
    rm -rf dist
    python -m build
    python -m twine upload --username $1 --password $2 "dist/*"
}
alias pbu=pip_build_upload
