# Set this in the repo: git config user.email ranel.padon@gmail.com
# then, fix commit email.
# Use `git pull origin master --allow-unrelated-histories`.
commit_email_update() {
    git filter-branch --env-filter '
        WRONG_EMAIL="ranel.padon@magneticasia.com"
        NEW_NAME="Ranel Padon"
        NEW_EMAIL="ranel.padon@gmail.com"

        if [ $GIT_COMMITTER_EMAIL = $WRONG_EMAIL ]]
        then
            export GIT_COMMITTER_NAME="$NEW_NAME"
            export GIT_COMMITTER_EMAIL="$NEW_EMAIL"
        fi
        if [[ $GIT_AUTHOR_EMAIL == $WRONG_EMAIL ]]
        then
            export GIT_AUTHOR_NAME="$NEW_NAME"
            export GIT_AUTHOR_EMAIL="$NEW_EMAIL"
        fi
    ' --tag-name-filter cat -- --branches --tags
}

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

gc() {
    git checkout $@
}

gcb() {
    git checkout -b $1 $2
}

# `git checkout previous` branch
gcp() {
    git checkout -
}

# `git checkout pull merge`
gcpm() {
    # Should have no space before and after `=` assignement operator!!!
    CURRENT_BRANCH=`git symbolic-ref --short HEAD`
    git checkout $1 && git pull origin $1
    git checkout $CURRENT_BRANCH
    git merge $1
}

gca() {
    git commit -am $1
}

gcm() {
    git commit -m $1
}

gd() {
    git diff $@
}

gft() {
    git fetch --tags
}

gm() {
    git merge $@
}

# `git merge previous` branch
gmp() {
    git merge -
}

gpl() {
    CURRENT_BRANCH=`git symbolic-ref --short HEAD`
    git pull origin $CURRENT_BRANCH
}

gps() {
    CURRENT_BRANCH=`git symbolic-ref --short HEAD`
    git push origin $CURRENT_BRANCH
}

grh() {
    git reset --hard $@
}


gs() {
    git status
}

gsp() {
    git stash pop
}

gst() {
    git stash
}


changelog() {
    gca "Update CHANGELOG."
}

conflicts() {
    # $# variable will tell you the number of input arguments the script was passed.
    if [ $# -eq 0 ]
    then
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


gb() {
    # Also set as `git blog` in ~/.gitconfig
    git log --color --pretty=format:'%C(green)%h%Creset: %C(yellow)%ar %C(blue)%s %C(red)(%an)' --abbrev-commit
}
