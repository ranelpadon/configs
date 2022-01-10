gce() {
    git checkout ets
}

gcprod() {
    git checkout release/ets/prod/v1.8.47
}

gct() {
    git checkout release/ets/test/v2.21
}

gctsc() {
    git checkout release/ets/test/shopping-cart
}

gcuat() {
    git checkout release/ets/uat/melco/v1.8.44
}


# `git diff ets`: compare the current checked out branch to ets, optionally with specific file.
# git diff ets release/ets/test/v2.4 apps/backoffice/generic/forms/property_forms.py
# git diff ets..release/ets/test/v2.4 apps/backoffice/generic/forms/property_forms.py
gde() {
    git diff ets $1
}

# `git diff branches`: compare the two branches, optionally with specific file.
# git diff ets release/ets/test/v2.4 apps/backoffice/generic/forms/property_forms.py
gdb() {
    git diff $@
}

# `git difftool ets`: compare the current checked out branch to ets, optionally with specific file.
# git diff ets release/ets/test/v2.4 apps/backoffice/generic/forms/property_forms.py
# git diff ets..release/ets/test/v2.4 apps/backoffice/generic/forms/property_forms.py
gdte() {
    git difftool ets $1
}

# `git difftool branches`: compare the two branches, optionally with specific file.
# git difftool ets release/ets/test/v2.4 apps/backoffice/generic/forms/property_forms.py
gdtb() {
    git difftool $@
}


gme() {
    git merge ets
}

gmprod() {
    git merge release/ets/prod/v1.8.44
}


# rprod 123 (for RC123)
rprod() {
    gce
    gpl
    gcprod
    gpl
    gm ets
    fab create_release_tag:release/ets/prod/v1.8.47,ets-prod-v1.8.47-RC$1,full,melco
}

# rttltest 1 (for RC1)
rttltest() {
    gc release/ets/test/shopping-cart
    gpl
    fab create_release_tag:release/ets/test/shopping-cart,ets-test-shopping-cart-RC$1,full,melco
}


worker_logs() {
    # tail -f $ETS/logs/worker.log
    batwatch $ETS/logs/worker.log
}


logs_clear() {
    echo 'Clearing logs..'
    LOGS_DIR=$ETS/logs
    # https://linuxhandbook.com/empty-file-linux/
    # `truncate` will empty the file to size 0.
    # `cat /dev/null` is tricky to use here.
    fd --glob "*.log" --no-ignore $LOGS_DIR --exec-batch truncate --size 0
    fd --glob "*.eml" --no-ignore $LOGS_DIR --exec-batch rm
}

_pyc() {
    # Check/clear the .pyc files.
    FD='
        fd \
            --no-ignore \
            --type file \
            --extension pyc \
            --exclude database \
            --exclude docker \
            --exclude docs \
            --exclude k8s \
            --exclude locale \
            --exclude logs \
            --exclude media \
            --exclude node_modules \
            --exclude static \
            --exclude templates \
    '

    if [ "$1" = "clear" ]; then
        FD+='--exec rm'
        echo 'Clearing .pyc files...'
    else
        echo 'Checking .pyc files...'
    fi

    eval $FD
}

alias pyc_check='_pyc check'
alias pyc_clear='_pyc clear'


# Fix imports
fim() {
    git diff --name-only ets \
    | grep '.py' \
    | grep -v 'migrations/' \
    | grep -v 'conf/' \
    | xargs isort
}


# Helper function.
_cd_whitelabel() {
    # Check if need to use custom URL.
    # Quotes are needed for evaluating the $ vars.
    if [ "$1" = "ticketing-ets-chart" ]; then
        open "https://git.hk.asiaticketing.com/technology/helm-charts/ticketing-ets-chart/-/pipelines"
    else
        open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/$1/-/pipelines"
    fi

    cd ~/dev/$1
    gc $2
    gpl
    nvim
}

cdatl() {
    _cd_whitelabel asiaticketing main
}

cddemo() {
    _cd_whitelabel demo main
}

cdgts() {
    _cd_whitelabel 11-skies main
}

cdhelm() {
    _cd_whitelabel ticketing-ets-chart master
}

cdhkilf() {
    _cd_whitelabel hkilf main
}

cdhkru() {
    _cd_whitelabel hkru main
}

cdkgg() {
    _cd_whitelabel kgg-kg main
}

cdmc() {
    _cd_whitelabel melco main
}

cdmgm() {
    _cd_whitelabel mgm main
}

cdsun() {
    _cd_whitelabel sun-entertainment main
}

cdttl() {
    _cd_whitelabel totalticketing main
}

cdxr() {
    _cd_whitelabel clockenflap-xr main
}

cdzip() {
    _cd_whitelabel zipcity main
}

cdzk() {
    _cd_whitelabel zicket main
}

cdzuni() {
    _cd_whitelabel zuni main
}


# Check release diff/packages/migrations
crm() {
    cd $ETS
    git diff --name-status ets-prod-v1.8.47-RC$1.. -l 2000 | rg migrations | sd 'A\s+' '* '
    echo
    echo "====================================================================="
    fd --full-path "migrations" . | grep -oE "\/.+\/[0-9]+" | sort | uniq -d
    echo "====================================================================="
    echo
    cd -
}

crp() {
    git diff --name-only ets-prod-v1.8.47-RC$1.. | grep requirements.txt | xargs git diff ets-prod-v1.8.47-RC$1..
}

cr() {
    crm $1
    crp $1
}

crmtsc() {
    cd $ETS
    echo
    git diff --name-status ets-test-shopping-cart-RC$1.. -l 2000 | rg migrations | sd 'A\s+' '* '
    echo
    echo "====================================================================="
    fd --full-path "migrations" . | grep -oE "\/.+\/[0-9]+" | sort | uniq -d
    echo "====================================================================="
    echo
    cd -
}

# Check release logs/merges
crl() {
    git log --pretty='%H %ar %s' --merges --grep='conflict' --grep='test' --regexp-ignore-case ets-prod-v1.8.47-RC$1..
}

# git tag grep
gtg() {
    git fetch --tags

    # $# variable will tell you the number of input arguments the script was passed.
    if [ $# -eq 0 ]; then
        # Search PROD tag by default.
        git tag | grep 'ets-prod' | sort --version-sort | tail
    else
        git tag | grep $1 | sort --version-sort | tail
    fi
}

# Release Notes
# rn 142 (for RC142)
# rn 142 1 (with migrations)
rn() {
    pat
    python /Users/ranelpadon/dev/scripts/gl-api.py ets-prod-v1.8.47-RC$1 $2
}

