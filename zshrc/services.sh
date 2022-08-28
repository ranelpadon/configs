# Daemon mode.
brew_services() {
    brew services $1 $2
}


cache_start() {
    # For debugging/verbose output, use the non-daemon mode:
    # memcached -vv
    brew_services start memcached
}

cache_stop() {
    brew_services stop memcached
}

cache_restart() {
    brew_services restart memcached
}


cache_set() {
    KEY=$1
    VALUE=$2
    SIZE=${#VALUE}

    # Need to insert '\r\n' to separate the two lines of the SET statement.
    # The second line have no '\n' since it's auto-inserted by the 'echo' function already.
    # Otherwise, there will be error.
    echo "set $KEY 0 300 $SIZE\r\n$VALUE\r" | nc localhost 11211
}

cache_get() {
    echo "get $1" | nc localhost 11211
}

cache_delete() {
    echo "delete $1" | nc localhost 11211
}

cache_clear() {
    echo "flush_all" | nc localhost 11211
}

cache_ui() {
    cd $HOME/dev/simple-memcache-ui
    pyenv activate nvim
    python src/main.py localhost 11211
}

# Non-daemon mode.
memcache() {
    memcached -vv
}

# RabbitMQ bins.
export PATH="/usr/local/sbin:$PATH"

# Non-daemon mode.
rabbitmq() {
    # RabbitMQ UI: http://localhost:15672/
    CONF_ENV_FILE="/usr/local/etc/rabbitmq/rabbitmq-env.conf" /usr/local/opt/rabbitmq/sbin/rabbitmq-server
}

# Purge Queue Messages.
rabbitmq_purge() {
    declare -a QUEUES=(
        'default'
        'mail'
        'opera'
        'priority.high'
        'priority.low'
        'reporter'
        'scheduled'
    )
    for QUEUE in "${QUEUES[@]}" ; do
        /usr/local/sbin/rabbitmqctl purge_queue $QUEUE -p /
    done
}

worker() {
    brew_services start rabbitmq
    pat
    python apps/worker/manage.py autorestart worker
    # python \
    #     apps/worker/manage.py \
    #     celery \
    #     worker \
    #     --app=common.patcher \
    #     --loglevel=INFO \
    #     --pidfile=/var/run/ticketflap/celery/all@Ranels-MacBook-Pro.local.pid \
    #     --concurrency=4 \
    #     --autoreload
}

worker_clear() {
    clear_pyc
    rm celerybeat-schedule

    brew_services restart rabbitmq
    brew_services restart memcached

    python apps/worker/manage.py celery purge --app=common.patcher.celery -f
}

flower() {
    brew_services start rabbitmq
    pat
    python apps/worker/manage.py autorestart flower
    # python apps/worker/manage.py autorestart_flower flower
    # python apps/worker/manage.py celery flower \
    #     --app=common.patcher.celery_app \
    #     --loglevel=INFO
    # apps/worker/manage.py celery flower \
    #     --app=common.patcher \
    #     --loglevel=INFO \
    #     --pidfile=/var/run/ticketflap/celery/all@Ranels-MacBook-Pro.local.pid \
    #     --concurrency=4 \
    #     --autoreload
}


# For XAMPP, need to disable the root check for better UX:
# sudo chmod 777 /Applications/XAMPP/xamppfiles/share/xampp/xampplib
# then patch the contents of `checkRoot()`.
# Make sure to have access in db:
# sudo chmod 4777 /Applications/XAMPP/xamppfiles/var/mysql/TICKETFLAP

XAMPP=/Applications/XAMPP/xamppfiles/xampp

_start_or_stop() {
    if [[ $1 = 'start' ]]
    then
        eval $2
    else
        eval $3
    fi
}

mysql() {
    START="$XAMPP startmysql"
    STOP="$XAMPP stopmysql"
    _start_or_stop $1 $START $STOP
}

apache() {
    START="$XAMPP startapache"
    STOP="$XAMPP stopapache"
    _start_or_stop $1 $START $STOP
}


# ETS

start() {
    mysql start
    brew_services start memcached
}

stop() {
    mysql stop
    mysql_kill
    brew_services stop memcached
    brew_services stop rabbitmq
}


# port_kill 8000
port_kill() {
    sudo lsof -t -i tcp:$1 | xargs kill -9

    # other way:
    # ps aux | grep 8000
    # kill -9 <process_id>
}


# https://dba.stackexchange.com/questions/36102/how-to-properly-kill-mysql
mysql_kill() {
    mysqladmin -uroot -ppassword -h127.0.0.1 --protocol=tcp shutdown
}


import_db(){
    source ~/Dropbox/import_db_cron.sh $1 $2
}


# For XAMPP 7.3, start the Application manager.
# Start the MAMP server (PHP/MySQL)
# Go to http://localhost/phpmyadmin/, import db.
#
# Add vhost for new site so that the site folder dont need to be put in `htdocs` and will stay as is.
# Add the new vhost in host file (/etc/hosts).
#
# Update the admin user password using `wp-config.php`, execute once by loading any page.
# $user_id = 1;
# $user_pass = 'admin';
# $user_data = wp_update_user(array('ID' => $user_id, 'user_pass' => $user_pass));

# Change the root password:
# Note that in XAMPP's default `mysql` db, the password column is hidden, so that column is always blank.
# DB password:
# /Applications/XAMPP/xamppfiles/bin/mysqladmin --user=root password "password"
# PHPMyAdmin password
# sudo nano /Applications/XAMPP/xamppfiles/phpmyadmin/config.inc.php
# Target line:
# $cfg['Servers'][$i]['password'] = 'password';
# $cfg['Servers'][$i]['auth_type'] = 'config';  # others changed this to `cookie` but seems not needed.
# Source: https://www.youtube.com/watch?v=IEbGskM54wI
#
# To import new db, use /Applications/XAMPP/xamppfiles/bin/mysql -uroot -ppassword.
# or just use the PHPMyAdmin!
_mysql() {
    /Applications/XAMPP/xamppfiles/bin/mysql -uroot -ppassword
}


# start_local_alloserv
alloserv() {
    # Needs to restart db, memcached, and worker.
    pyenv activate alloserv \
    && cd $ETS/alloserv/ \
    && python alloserv_entry.py --config alloserv/conf/local_settings.py
}


# Start an HTTP server from a directory, optionally specifying the port
local_server() {
    open "http://localhost:8000/" &
    php -S localhost:8000
}


# The next line updates PATH for the Google Cloud SDK.
if [[ -f '~/google-cloud-sdk/path.zsh.inc' ]]
then
    . '~/google-cloud-sdk/path.zsh.inc';
fi

# The next line enables shell command completion for gcloud.
if [[ -f '~/google-cloud-sdk/completion.zsh.inc' ]]
then
    . '~/google-cloud-sdk/completion.zsh.inc';
fi

alias gad='gcloud app deploy'
