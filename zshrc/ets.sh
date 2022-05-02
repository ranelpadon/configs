gce() {
    git checkout ets
}

gcprod() {
    git checkout release/ets/prod/v1.8.47
}

gct3() {
    git checkout release/ets/test/v3.0
}
gct2() {
    git checkout release/ets/test/v2.22
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

check_pyc() {
    _pyc check
}
clear_pyc() {
    _pyc clear
}


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
    # $# variable will tell you the number of input arguments the script was passed.
    if [ $# -eq 2 ]; then
        # Don't open the whitelabel URL.
    else
        # With `open_url` command arg.
        # Check if need to use custom URL.
        # Quotes are needed for evaluating the $ vars.
        if [ "$1" = "ticketing-ets-chart" ]; then
            open "https://git.hk.asiaticketing.com/technology/helm-charts/ticketing-ets-chart/-/pipelines"
        else
            open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/$1/-/pipelines"
        fi
    fi

    cd ~/dev/$1
    gc $2
    gpl
    nvim
}

_cdatl() {
    _cd_whitelabel asiaticketing main
}
cdatl() {
    _cd_whitelabel asiaticketing main open_url
}

_cdbymop() {
    _cd_whitelabel bookyay-mop main
}
cdbymop() {
    _cd_whitelabel bookyay-mop main open_url
}

_cdbyntd() {
    _cd_whitelabel bookyay-ntd main
}
cdbyntd() {
    _cd_whitelabel bookyay-ntd main open_url
}

_cddemo() {
    _cd_whitelabel demo main
}
cddemo() {
    _cd_whitelabel demo main open_url
}

_cdf7() {
    _cd_whitelabel f7 main
}
cdf7() {
    _cd_whitelabel f7 main open_url
}

_cdgts() {
    _cd_whitelabel 11-skies main
}
cdgts() {
    _cd_whitelabel 11-skies main open_url
}

_cdhelm() {
    _cd_whitelabel ticketing-ets-chart master
}
cdhelm() {
    _cd_whitelabel ticketing-ets-chart master open_url
}

_cdhkilf() {
    _cd_whitelabel hkilf main
}
cdhkilf() {
    _cd_whitelabel hkilf main open_url
}

_cdhkru() {
    _cd_whitelabel hkru main
}
cdhkru() {
    _cd_whitelabel hkru main open_url
}

_cdkgg() {
    _cd_whitelabel kgg-kg main
}
cdkgg() {
    _cd_whitelabel kgg-kg main open_url
}

_cdmt() {
    _cd_whitelabel matchtic main
}
cdmt() {
    _cd_whitelabel matchtic main open_url
}

_cdmc() {
    _cd_whitelabel melco main
}
cdmc() {
    _cd_whitelabel melco main open_url
}

_cdmgm() {
    _cd_whitelabel mgm main
}
cdmgm() {
    _cd_whitelabel mgm main open_url
}

_cdsun() {
    _cd_whitelabel sun-entertainment main
}
cdsun() {
    _cd_whitelabel sun-entertainment main open_url
}

_cdttl() {
    _cd_whitelabel totalticketing main
}
cdttl() {
    _cd_whitelabel totalticketing main open_url
}

_cdxr() {
    _cd_whitelabel clockenflap-xr main
}
cdxr() {
    _cd_whitelabel clockenflap-xr main open_url
}

_cdzip() {
    _cd_whitelabel zipcity main
}
cdzip() {
    _cd_whitelabel zipcity main open_url
}

_cdzk() {
    _cd_whitelabel zicket main
}
cdzk() {
    _cd_whitelabel zicket main open_url
}

_cdzuni() {
    _cd_whitelabel zuni main
}
cdzuni() {
    _cd_whitelabel zuni main open_url
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

# GitLab Release Notes
# _rn 142 (for RC142)
_glrn() {
    pat
    python /Users/ranelpadon/dev/scripts/gitlab/release-notes.py ets-prod-v1.8.47-RC$1
}
# rn 142 (with migrations)
glrn() {
    pat
    python /Users/ranelpadon/dev/scripts/gitlab/release-notes.py ets-prod-v1.8.47-RC$1 with_migrations
}


# GitLab CI stats
glci() {
    # pat
    python /Users/ranelpadon/dev/scripts/gitlab/ci-stats.py $1
}
