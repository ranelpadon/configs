# RipGrep MAN page:
# https://www.mankier.com/1/rg

# Core helper function.
# Add -s for --case-sensitive search when calling the top level functions.
# rp "LoginView" -s
# For --colors, see https://www.mankier.com/1/rg#--colors.
_rg() {
    rg \
        --ignore-case \
        --colors match:bg:249,245,154 \
        --colors match:fg:66,98,150 \
        --colors match:style:nobold $@
}

# rg-python
# Search in Python files only.
rp() {
    _rg --type py --glob '!**/tests/**' --glob '!**/migrations/**' $@
}

# rg-python-tests
# Search in unit test files.
rpt() {
    rp --glob '**/tests/**' $@
}

# rg-python-migrations
# Search in migration files.
rpm() {
    rp --glob '**/migrations/**' $@
}

# rg-python-html
# Search in Python + HTML files.
rph() {
    rp --type html $@
}

# rg-python-html-js
# Search in Python + HTML + JS files.
rphj() {
    rph --type js --glop '!*.min.js' $@
}


# rg-html
# Search in HTML files only.
rh() {
    _rg --type html $@
}

# rg-html-js
# Search in HTML + JS files.
rhj() {
    rh --type js --glob '!*.min.js' $@
}

# rg-html-js-css
# Search in HTML + JS + CSS files.
rhjc() {
    rhj --type css --glob '!*.min.js' $@
}

# rg-js
# Search in JS files only. Exclude minified files.
rj() {
    _rg --type js --glob '!*.min.js' $@
}

# rg-css
# Search in CSS files only.
rc() {
    _rg --type css $@
}

# rg-txt
# Search in text files (mainly Python's requirements.txt).
rt() {
    _rg --type txt $@
}

# rg-yaml
# Search in YAML files (mainly CI/k8s files).
ry() {
    _rg --type yaml $@
}


# rg-all
# Include the Git-ignored files w/c are excluded by default!
# Exclude files we don't care about.
# Define file type if it's not included in the `rg --type-list`.
ra() {
    _rg \
        --no-ignore \
        --type-add 'compiled:*.compiled' \
        --type-not compiled \
        --type-not log \
        $@
}

# rg-git-conflicts
# Search for Git conflict marker in important files.
# No need to search all file types.
# rgc instead of `rc` since it's already mapped to CSS files.
rcc() {
    _rg \
        --type py \
        --type html \
        --type js \
        --type css \
        --type yaml \
        --type txt \
        --type po \
        --type md \
        '>>>>>>>'
}


# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setting fd as the default source for fzf
# This is used when running `fzf` in the CLI.
# For faster/better results with ** operator in files/folders,
# preprend with a representative folder first, like
# `cd projects/**` instead of `cd **` only.
export FZF_DEFAULT_COMMAND='
    fd \
        --hidden \
        --follow \
        --no-ignore \
        --exclude node_modules \
        --exclude Library \
        --exclude logs \
        --exclude /media \
        --exclude /static \
        --exclude /sites \
        --exclude cache \
        --exclude undo/ \
        --exclude backups/ \
        --exclude automatic_backups/ \
        --exclude autoload/ \
        --exclude .idea/ \
        --exclude .git \
        --exclude .DS_Store \
        --exclude .git \
        --exclude "*.pyc" \
        --exclude "*.compiled" \
        --exclude "*.scss" \
'

export FZF_PREVIEW_COMMAND='COLORTERM=truecolor bat --style=numbers --color=always --line-range :5000 {}'
export FZF_DEFAULT_OPTS='--multi --bind ctrl-a:toggle-all'

rfb() {
    # --nth=3 to search the right side of each line which is the code contents.
    rg  --line-number --no-heading '' | fzf --delimiter=: --preview "$HOME/Desktop/fzf-bat-preview.sh {1} {2}" --nth=3
}

rpfb() {
    # --nth=3 to search the right side of each line which is the code contents.
    rp  --line-number --no-heading '' | fzf --delimiter=: --preview "$HOME/Desktop/fzf-bat-preview.sh {1} {2}" --nth=3
}


# `bat`
# https://github.com/sharkdp/bat
export BAT_THEME="TwoDark"

