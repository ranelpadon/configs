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
manage_p() {
    $PY27 apps/processing/manage.py $@
}
manage_rd() {
    $PY27 apps/redemption/manage.py $@
}
manage_taapi() {
    $PY27 apps/taapi/manage.py $@
}
manage_scapi() {
    $PY27 apps/scapi/manage.py $@
}
manage_acapi() {
    $PY27 apps/acapi/manage.py $@
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


gb() {
    _gunicorn backoffice 8000
}

gp() {
    _gunicorn processing 8001
}

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

    # Use [[]] instead of []:
    # https://stackoverflow.com/questions/3427872/whats-the-difference-between-and-in-bash/#answer-3427931

    # Default is `buildbox`.
    if [[ -z $CONTEXT ]]; then
        CONTEXT=buildbox
    fi

    if [[ $CONTEXT = 'buildbox' ]]; then
        _SITE="_$SITE"
    fi

    SETTING=settings.local_settings.$CONTEXT.$_SITE

    echo $SETTING

    $PY27 \
        ~/dev/ticketflap/ticketing/apps/$SITE/manage.py \
        test \
        --settings=$SETTING \
        --verbosity=1 \
        $TRIMMED_PATH
}


ta() {
    test acapi $1
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

trd() {
    test redemption $1
}

ts() {
    test sessions_api $1
}

tsc() {
    test scapi $1
}

tt() {
    test taapi $1
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

trds() {
    test worker $1 _local_sqlite
}

tss() {
    test sessions_api $1 _local_sqlite
}

tts() {
    test taapi $1 _local_sqlite
}


# Clear Download Signature records.
download_signatures_clear() {
    # echo "from common.misc.models import DownloadSignature; DownloadSignature.objects.all().delete()" | manage shell
    /Applications/XAMPP/xamppfiles/bin/mysql \
        -h localhost -P 3306 -uroot -ppassword \
        -e 'use TICKETFLAP; TRUNCATE table download_signatures;'
}

drf2() {
    gce
    clear_pyc
    pip install djangorestframework===2.4.8 --no-input
    # pip install django-authority==0.11
    pip install drf_compound_fields==0.2.2 --no-input
}

drf3() {
    gc feature/gl-394_upgrade_drf_related_packages
    clear_pyc
    pip install djangorestframework===3.5.4 --no-input
    # pip install django-authority==0.13.2
    pip uninstall drf_compound_fields==0.2.2 --no-input
}


install_flake() {
    pip install isort==4.3.21  # 4.x for Py2
    pip install flake8==3.8.3  # Latest
    pip install flake8-isort==3.0.1
}


dj111() {
    gc upgrade/django-1.11
    pip install Django==1.11.29 --no-input
    pip uninstall django-longerusernameandemail==0.5.7 --no-input
    pip install django-modeltranslation==0.14.4 --no-input

    # pip install django-sekizai==1.1.0
    # pip install django-classy-tags==0.9.0
}

undj111() {
    pip install Django==1.8.19 --no-input
    pip install django-longerusernameandemail==0.5.7 --no-input
    pip install django-modeltranslation==0.12.2 --no-input

    # pip install django-sekizai==0.10.0
    # pip install django-classy-tags==0.8.0
}


downgrade() {
    drf2
    undj111
}


upgrade() {
    drf3
    dj111
}


py37() {
    pip install billiard>=3.6.3.0,<4.0 --no-input
    pip install kombu>=4.6.8,<5.0.0 --no-input
    pip install celery==4.4.7 --no-input
    pip install django-celery-email==2.0.2 --no-input
}
unpy37() {
    pip install billiard>=3.5.0.2,<3.6.0 --no-input
    pip install kombu>=4.2.0,<4.4 --no-input
    pip install celery==4.2.2 --no-input
    pip install django-celery-email==2.0.1 --no-input
}
