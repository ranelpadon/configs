# Custom command combining `isort` and `autoflake`.

# zsh aliases will not work in Vim, so need to redefine the shell function.
# https://unix.stackexchange.com/questions/550622/how-to-run-aliases-commands-in-inside-the-vim-editor
fix_python_files() {
    modified_files=$(git diff --name-only | grep '.py' | grep -v 'migrations/' | grep -v 'conf/')
    files=$modified_files

    # No need inside of Vim, since the files are separated by spaces, not newlines.
    # Enabling this will cause some logic error.
    # files=($(echo $modified_files | tr '\n' ' '))

    for file in $files; do
        isort $file
        autoflake $file --remove-all-unused-imports --ignore-pass-statements --in-place --exclude 'conf/settings/*'
    done
}

fix_python_files
