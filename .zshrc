CONFIGS=$HOME/dev/configs

# Load the critical scripts.
source $CONFIGS/zshrc/init.sh

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
# FILES_STR=$(find zshrc -name '*.sh' -not -name 'zsh.sh')
FILES_STR=$(fd --glob '*.sh' --exclude 'init.sh' $CONFIGS/zshrc)

# `translate`/`transliterate` is a find-and-replace utility.
# `echo 'haha' | tr 'a' 'e'` outputs `hehe`.
# Outer () will convert the output of $() to array.
FILES=($(echo $FILES_STR | tr '\n' ' '))

# Load the partials.
# This will also work if we don't need to exlude a file.
# FILES=$HOME/dev/configs/zshrc/
# for FILE in $FILES/*; do
# for FILE in $FILES[@]; do
for FILE in $FILES; do
    source $FILE
done
