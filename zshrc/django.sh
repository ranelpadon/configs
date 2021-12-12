# Skip ETS manage.py test_coverage
export COVERAGE_SKIP=1

# enable-is-test
eit() {
  export IS_TEST=1
}

# disable-is-test
dit() {
  unset IS_TEST
}


# Commands will use the BackOffice site.
manage() {
    $PY27 apps/backoffice/manage.py $@
}

migrate_list() {
    # fab migrate:--list | grep "NodeNotFoundError\|\[ \]"
    # All results except those migrated ones.
    # fab migrate:--list | grep -v "\[X\]"
    # $PY27 ~/dev/ticketflap/ticketing/apps/backoffice/manage.py migrate --list | grep -v "\[X\]"
    manage migrate --list | grep --fixed-strings "[ ]"
}


_gunicorn() {
    pat
    # Set to workers=1 when debugging!!
    gunicorn conf.wsgi.$1 --workers 1 --bind :$2 --reload --access-logfile -
}


unalias gb
gb() {
    _gunicorn backoffice 8000
}

unalias gp
gp() {
    _gunicorn processing 8001
}

unalias gf
gf() {
    _gunicorn frontend 8002
}


_runserver() {
    pat
    $PY27 apps/$1/manage.py runserver 0.0.0.0:$2
}

rb() {
    _runserver backoffice 8000
}

rpb() {
    _runserver processing 8001
}

rf() {
    _runserver frontend 8002
}


test() {
    SITE=$1
    _SITE=$1
    TRIMMED_PATH=$2
    CONTEXT=$3

    # Default is `buildbox`.
    if [ -z "$CONTEXT" ]; then
        CONTEXT=buildbox
    fi

    if [ "$CONTEXT" = "buildbox" ] && [ "$SITE" = "worker" ]; then
        _SITE='worker_override'
    fi

    SETTING=settings.local_settings.$CONTEXT.$_SITE

    echo $SETTING

    $PY27 \
        ~/dev/ticketflap/ticketing/apps/$SITE/manage.py \
        test $TRIMMED_PATH \
        --settings=$SETTING \
        --verbosity=0
}


tb() {
    test backoffice $1
}

tp() {
    test processing $1
}

tf() {
    test frontend $1
}

tw() {
    test worker $1
}


tbs() {
    test backoffice $1 _local_sqlite
}

tps() {
    test processing $1 _local_sqlite
}

tfs() {
    test frontend $1 _local_sqlite
}

tws() {
    test worker $1 _local_sqlite
}


# Clear Download Signature records.
download_signature_clear() {
    mysql -h localhost -P 3306 -uroot -ppassword \
        -e 'use TICKETFLAP; TRUNCATE table download_signatures;'
}
