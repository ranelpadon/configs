# Set this in the repo: git config user.email ranel.padon@gmail.com
# then, fix commit email.
# Use `git pull origin master --allow-unrelated-histories`.
commit_email_update() {
    git filter-branch --env-filter '
        WRONG_EMAIL="ranel.padon@magneticasia.com"
        NEW_NAME="Ranel Padon"
        NEW_EMAIL="ranel.padon@gmail.com"

        if [ "$GIT_COMMITTER_EMAIL" = "$WRONG_EMAIL" ]
        then
            export GIT_COMMITTER_NAME="$NEW_NAME"
            export GIT_COMMITTER_EMAIL="$NEW_EMAIL"
        fi
        if [ "$GIT_AUTHOR_EMAIL" = "$WRONG_EMAIL" ]
        then
            export GIT_AUTHOR_NAME="$NEW_NAME"
            export GIT_AUTHOR_EMAIL="$NEW_EMAIL"
        fi
    ' --tag-name-filter cat -- --branches --tags
}

unalias ga
ga() {
    git add $1
}

# get branch name
# gbn LINE FILE
gbn() {
    commit_log=$(git blame -L$1,$1 -- $2)
    commit_sha=${commit_log:0:8}
    git name-rev --name-only --exclude="tags/*" $commit_sha
}

unalias gc
gc() {
    git checkout $@
}

unalias gcb
gcb() {
    git checkout -b $1 $2
}

# `git checkout previous` branch
alias gcp='git checkout -'

gcpm() {
  # Should have no space before and after `=` assignement operator!!!
  CURRENT_BRANCH=`git symbolic-ref --short HEAD`
  git checkout $1 && git pull origin $1
  git checkout $CURRENT_BRANCH
  git merge $1
}

unalias gca
# needs alias because OMZ has `gca` alias also!
# https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet
# so we need to unbind/override it
# git commit all
gca() {
    git commit -am $1
}

unalias gcm
gcm() {
    git commit -m $1
}

unalias gd
gd() {
    git diff $@
}

gft() {
    git fetch --tags
}

unalias gm
gm() {
    git merge $@
}

# `git merge previous` branch
alias gmp='git merge -'

gpl() {
    CURRENT_BRANCH=`git symbolic-ref --short HEAD`
    git pull origin $CURRENT_BRANCH
}

gps() {
    CURRENT_BRANCH=`git symbolic-ref --short HEAD`
    git push origin $CURRENT_BRANCH
}

unalias grh
grh() {
    git reset --hard
}


alias gs='git status'

alias gsp='git stash pop'

alias gst='git stash'


changelog() {
    gca "Update CHANGELOG."
}

conflicts() {
    # $# variable will tell you the number of input arguments the script was passed.
    if [ $# -eq 0 ]; then
        gca "Fix merge conflicts."
    else
        gca "GL-$1: Fix merge conflicts."
    fi
}

mconflicts() {
    gca "Fix migration conflicts."
}


# Open all files with open conflicts with nvim
vconflicts() {
    git diff --name-only | uniq | xargs nvim
}
