# docker clear
dc() {
    docker stop \
        sessions-ui \
        ets-mysql \
        ticketing_ets-celery_1 \
        832603c3c1a5_ets-mysql
}


# ubuntu:20.04 is the base system used in TF!
dfh() {
    docker run --rm ubuntu:20.04 df -h
}

dfh_2() {
    docker system df -v
}


worker_logs_inspect() {
    # Verbose
    docker exec --tty --interactive --workdir /var/log/supervisor ticketflap-worker bash
    # docker exec --tty --interactive --workdir /var/log/supervisor $(docker ps --filter "name=ticketflap-worker" --quiet) bash
    # Shorthand
    # docker exec -ti -w /var/log/supervisor $(docker ps -f "name=ticketflap-worker" -q) bash
    # docker exec -ti -w /var/log/supervisor ticketflap-worker bash
    # docker exec -ti ticketflap-worker
}

# TODO: Re-evaluate when migrated to `docker-compose`.

frb() {
    fab runserver:backoffice
}

frf() {
    fab runserver:frontend
}

frp() {
    fab runserver:processing
}

frpb() {
    fab runserver_plus:backoffice
}

frpf() {
    fab runserver_plus:frontend
}

frpp() {
    fab runserver_plus:processing
}


# fab pip install
# fpi backoffice "factory-boy\=\=2.8.1"  <-- needs the quotes!!!
# fab pip:backoffice,'install factory-boy\=\=2.8.1'
fpi() {
    # echo "install $2"
    fab pip:$1,"install $2"
}

# fab pip install all
# fpia "factory-boy\=\=2.8.1"  <-- needs the quotes!!!
fpia() {
    fpi backoffice $1
    fpi worker $1
    fpi processing $1
    fpi frontend $1
    fpi scapi $1
    fpi taapi $1
    fpi acapi $1
}


frdb() {
    # fix the `Head usage unknown option -1` error
    # https://stackoverflow.com/questions/21498991/head-usage-unknown-option-1-n-error-possibly-ruby-related
    # mv /Applications/XAMPP/xamppfiles/bin/HEAD /Applications/XAMPP/xamppfiles/bin/HTTP_HEAD
    export PATH="/Applications/XAMPP/xamppfiles/bin:$PATH"
    # should be in docker/ folder!!!!
    # no need for this now since Homebrew's /usr/local/bin/mysql is ok now!
    # Set this first in root `fabfile.py`
    # local('gunzip < {db_target_file} | /Applications/XAMPP/xamppfiles/bin/mysql {db_connect} {db_target}'.format(
    # fab stop  # since Cmd+C will still leave the `db` container running in the background.
    # this doesnt work due to CLI error.
    # clear the docker compose's autoruns, to free up the MySQL port.
    # export PATH="/Applications/XAMPP/xamppfiles/bin:$PATH"
    dc
    fab create_database:drop=True
    cd ..
    fab local_sync_from_remote_db
    cd docker
}



# Sample: ftb apps.common.voucher.tests.test_models verbosity=2
ftb() {
    # dotted_path=$(pathx $1)
    # fab test:backoffice,$dotted_path
    # fab test:backoffice,$1,auto_clean_pyc=0,$2

    # $# variable will tell you the number of input arguments the script was passed.
    if [[ $# -eq 1 ]]; then
        fab test:backoffice,$1,auto_clean_pyc=0
    else
        fab test:backoffice,$1,auto_clean_pyc=0,$2
    fi
}

ftw() {
    if [[ $# -eq 1 ]]; then
        fab test:worker,$1,auto_clean_pyc=0
    else
        fab test:worker,$1,auto_clean_pyc=0,$2
    fi
}

ftf() {
    if [[ $# -eq 1 ]]; then
        fab test:frontend,$1,auto_clean_pyc=0
    else
        fab test:frontend,$1,auto_clean_pyc=0,$2
    fi
}

ftp() {
    if [[ $# -eq 1 ]]; then
        fab test:processing,$1,auto_clean_pyc=0
    else
        fab test:processing,$1,auto_clean_pyc=0,$2
    fi
}


dcu() {
    docker-compose up $@
}

dcm() {
    docker-compose run backoffice_manage $@
}

# For unit tests also.
# dcr backoffice_test backoffice.box_office.tests
dcr() {
    docker-compose run $@
}

# dcc backoffice
dcc() {
    docker-compose run $1_manage collectstatic --clear --link --noinput
}

dcs() {
    docker-compose stop && docker-compose rm -f
}
