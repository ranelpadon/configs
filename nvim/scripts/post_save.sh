# ALE doesn't handle the isort/autoflake `--skip`/`--exclude` options
# since they're processed as in-memory buffers, and don't have the file path info.
# $1 is the passed filename (full path) from Vim.

# `--in-place` is needed since it will just print the diff by default,
# instead of applying the changes.
autoflake $1 --remove-all-unused-imports --in-place --exclude 'conf/settings/*'

isort $1
