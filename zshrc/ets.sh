gce() {
    git checkout ets
}

gcs() {
    git checkout staging
}

gcprod() {
    git checkout release/ets/prod/v2.0
    # git checkout release/ets/prod/v1.8.47
}

gct() {
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
    git merge release/ets/prod/v2.0
    # git merge release/ets/prod/v1.8.44
}


# rtest 123 (for v.3.0.123)
rtest() {
    # gc upgrade/django-1.11
    # gpl
    gct
    gpl
    # gm upgrade/django-1.11
    fab create_release_tag:release/ets/test/v3.0,$1,full,melco
}

# rprod 123 (for RC123)
rprod() {
    gce
    gpl
    gcprod
    gpl
    # Merging requires $GIT_EDITOR to be set, and will use the binary file pointed to it.
    # Aliased `nvim` will not work. Hence, need to do `brew install nvim` first.
    gm ets

    $PY_MGR activate py311
    python ~/dev/whitelabels/scripts/python/whitelabels.py create_tag PROD --ets-version $1
    # fab create_release_tag:release/ets/prod/v2.0,$1,full,melco
    # fab create_release_tag:release/ets/prod/v1.8.47,ets-prod-v1.8.47-RC$1,full,melco

    # Merge new release tag back to `ets` and push.
    gce
    gmp
    gps

    # TODO: run `crm $1 - 1`
    echo
    echo 'Make sure to check for migrations!!!'
    $PY_MGR activate ticketing
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

    if [[ $1 == "clear" ]]
    then
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
fix_imports_ets() {
    git diff --name-only ets \
    | grep '.py' \
    | grep -v 'migrations/' \
    | grep -v 'conf/' \
    | xargs isort
}

fix_python_files() {
    modified_files=$(git diff --name-only | grep '.py' | grep -v 'migrations/' | grep -v 'conf/')

    # Convert newlines to spaces.
    FILES=($(echo $modified_files | tr '\n' ' '))

    for FILE in $FILES; do
        isort $FILE
        autoflake $FILE --remove-all-unused-imports --in-place --exclude 'conf/settings/*'
    done
}


# create_tag_and_deploy TEST ets-test-v3.0.101
function create_tag_and_deploy() {
    cd ~/dev/whitelabels/scripts
    pyenv activate ticketing
    python whitelabels.py create $1 --ets-version $2
    python whitelabels.py update $1 --ets-version $2
    python whitelabels.py commit $1
    python whitelabels.py deploy $1
}


# Helper function.
_cd_whitelabel() {
    # $# variable will tell you the number of input arguments the script was passed.
    if [[ $# -eq 2 ]]
    then
        # Don't open the whitelabel URL.
    else
        # With `open_url` command arg.
        # Check if need to use custom URL.
        # Quotes are not needed for evaluating the $ vars when using `[[  ]]`.
        if [[ $1 == "ticketing-ets-chart" ]]
        then
            open "https://git.hk.asiaticketing.com/technology/helm-charts/ticketing-ets-chart/-/pipelines"
        else
            open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/$1/-/pipelines"
        fi
    fi
}


cd_local_repo() {
    cd ~/dev/whitelabels/$1
    gc main
    gpl
    nvim
}


cd_pipelines() {
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/$1/-/pipelines"
}


cdl29rsg() {
    cd_local_repo 29rooms-sg
}
cdp29rsg() {
    cd_pipelines 29rooms-sg
}

cdlaaj() {
    cd_local_repo allaboutjazz
}
cdpaaj() {
    cd_pipelines allaboutjazz
}

cdlatl() {
    cd_local_repo asiaticketing
}
cdpatl() {
    cd_pipelines asiaticketing
}

cdlbjt() {
    cd_local_repo buyjapantickets
}
cdpbjt() {
    cd_pipelines buyjapantickets
}

cdlbkt() {
    cd_local_repo buykoreatickets
}
cdpbkt() {
    cd_pipelines buykoreatickets
}

cdlbymop() {
    cd_local_repo bookyay-mop
}
cdpbymop() {
    cd_pipelines bookyay-mop
}

cdlbyntd() {
    cd_local_repo bookyay-ntd
}
cdpbyntd() {
    cd_pipelines bookyay-ntd
}

cdldemo() {
    cd_local_repo demo
}
cdpdemo() {
    cd_pipelines demo
}

cdlf7() {
    cd_local_repo f7
}
cdpf7() {
    cd_pipelines f7
}

cdlgts() {
    cd_local_repo 11-skies
}
cdpgts() {
    cd_pipelines 11-skies
}


cdpTEST() {
    cdpatl
    cdpmc
    cdpttl
}


cdlhelm() {
    cd ~/dev/ticketing-ets-chart
    gc master
    gpl
    nvim
}
# cd_remote_repo
cdrhelm() {
    cd_pipelines ticketing-ets-chart master open_url
}


cdlhkida() {
    cd_local_repo hkida
}
cdphkida() {
    cd_pipelines hkida
}

cdlhkilf() {
    cd_local_repo hkilf
}
cdphkilf() {
    cd_pipelines hkilf
}

cdlhkru() {
    cd_local_repo hkru
}
cdphkru() {
    cd_pipelines hkru
}

cdlhkt() {
    cd_local_repo hkticketing
}
cdphkt() {
    cd_pipelines hkticketing
}

cdlkgg() {
    cd_local_repo kgg-kg
}
cdkgg() {
    cd_pipelines kgg-kg
}

cdlmt() {
    cd_local_repo matchtic
}
cdpmt() {
    cd_pipelines matchtic
}

cdlmc() {
    cd_local_repo melco
}
cdpmc() {
    cd_pipelines melco
}

cdlmcc() {
    cd_local_repo melco-cyprus
}
cdpmcc() {
    cd_pipelines melco-cyprus
}

cdlmgm() {
    cd_local_repo mgm
}
cdpmgm() {
    cd_pipelines mgm
}

cdlsun() {
    cd_local_repo sun-entertainment
}
cdpsun() {
    cd_pipelines sun-entertainment
}

cdlswi() {
    cd_local_repo swire
}
cdpswi() {
    cd_pipelines swire
}

cdlta() {
    cd_local_repo tatlerasia
}
cdpta() {
    cd_pipelines tatlerasia m
}

cdltcob() {
    cd_local_repo tcobmedia
}
cdptcob() {
    cd_pipelines tcobmedia
}

cdltfjpy() {
    cd_local_repo ticketflap-jpy
}
cdptfjpy() {
    cd_pipelines ticketflap-jpy
}

cdltkl() {
    cd_local_repo tickelo
}
cdptkl() {
    cd_pipelines tickelo
}

cdlttl() {
    cd_local_repo totalticketing
}
cdpttl() {
    cd_pipelines totalticketing
}

cdltwa() {
    cd_local_repo thewanch
}
cdptwa() {
    cd_pipelines thewanch
}

cdlxr() {
    cd_local_repo clockenflap-xr
}
cdpxr() {
    cd_pipelines clockenflap-xr
}

cdlwynn() {
    cd_local_repo wynn
}
cdpwynn() {
    cd_pipelines wynn
}

cdlzip() {
    cd_local_repo zipcity
}
cdpzip() {
    cd_pipelines zipcity
}

cdlzk() {
    cd_local_repo zicket
}
cdpzk() {
    cd_pipelines zicket
}

cdlzuni() {
    cd_local_repo zuni
}
cdpzuni() {
    cd_pipelines zuni
}


# Check release diff/packages/migrations
crm() {
    cd $ETS
    git diff --name-status $1.. -l 2000 | rg migrations | sd 'A\s+' '* '
    # git diff --name-status ets-prod-v2.0.$1.. -l 2000 | rg migrations | sd 'A\s+' '* '
    echo
    echo "====================================================================="
    fd --full-path "migrations" . | grep -oE "\/.+\/[0-9]+" | sort | uniq -d
    echo "====================================================================="
    echo
    cd -
}

crp() {
    # git diff --name-only $1.. | grep requirements.txt | xargs git diff $1..

    # Disable the Delta pager to have a plain diff.
    # Disable colors since it interferes with the `+` character.
    # Filter the changed lines only.
    # Remove duplicate lines.
    git diff --name-only $1.. \
        | grep requirements.txt \
        | xargs git --no-pager diff $1.. --unified=0 --color=never \
        | grep --extended-regexp "[-+][-a-zA-Z0-9]+[=><]+" \
        | sort --unique --reverse \
        | grep --invert-match "@@"

    # git diff --name-only ets-prod-v2.0.$1.. | grep requirements.txt | xargs git diff ets-prod-v2.0.$1..
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
    git log --pretty='%H %ar %s' --merges --grep='conflict' --grep='test' --regexp-ignore-case ets-prod-v2.0.$1..
}

# git tag grep
gtg() {
    git fetch --tags

    # $# variable will tell you the number of input arguments the script was passed.
    if [[ $# -eq 0 ]]
    then
        # Search PROD tag by default.
        git tag | grep 'ets-prod' | sort --version-sort | tail
    else
        git tag | grep $1 | sort --version-sort | tail
    fi
}

# GitLab Release Notes
# _glrn ets-prod-v2.0.11
# _glrn ets-prod-v2.0.11 123 456
_glrn() {
    pat
    python ~/dev/scripts/gitlab/release-notes.py $1 no_migrations ${@:2}
}

# glrn ets-prod-v2.0.11 (with migrations)
# glrn ets-prod-v2.0.11 123 456 (with migrations)
glrn() {
    # pat

    # $@ = ets-prod-v2.0.11 123 456
    # $@:0 = glrn ets-prod-v2.0.11 123 456
    # $0 = glrn
    # $1 = ets-prod-v2.0.11
    # $2 = 123
    # $3 = 456

    # Slice from index=2.
    # ${@:2}
    # python ~/dev/scripts/gitlab/release-notes.py $1 with_migrations ${@:2}

    # Now requires Py3 due to `whitelabels.py`.
    $PY_MGR activate py311

    python ~/dev/scripts/gitlab/release-notes.py $@
    $PY_MGR activate ticketing
}

# GitLab CI stats
glci() {
    # pat
    python ~/dev/scripts/gitlab/ci-stats.py $1
}
