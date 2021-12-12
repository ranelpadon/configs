CONFIGS=$HOME/dev/configs
source $CONFIGS/zshrc/zsh.sh

# Load all the Partials.
# source $HOME/dev/configs/zshrc/*.sh

# find/fd --exec arg requires a system/external command.
# source/exec is a built-in/internal command. It's a shell function.
# It's not an executable file found in $PATH. Hence, it fails.
# Creating an executable file or using shell FOR loop is the workaround.
# bash has `export -f FUNC` which convert FUNC to command, zsh has not.
# --exec zsh -c 'source {}' is ok but will execute in a sub-shell,
# not ideal for `source` commands which needs syncing with various vars.
# `declare -f source` not helpful also.
# fd --glob '*.sh' $HOME/dev/configs/zshrc --exec source {}

# `--extension sh ''` will also do.
FILES_STR=$(fd --glob '*.sh' --exclude 'zsh.sh' $CONFIGS/zshrc)

# `translate` will replace newlines with space.
# Outer () will convert the output of $() to array.
FILES=($(echo $FILES_STR | tr '\n' ' '))

# This will also work.
# FILES=$HOME/dev/configs/zshrc/
# for FILE in $FILES/*; do
for FILE in $FILES[@]; do
    source $FILE
done
