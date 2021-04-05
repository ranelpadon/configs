# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# https://stackoverflow.com/questions/51006002/how-do-i-get-intellij-terminal-to-work-properly-with-oh-my-zsh
# https://intellij-support.jetbrains.com/hc/en-us/community/posts/360003553899-Change-colors-for-Oh-my-zsh-in-PHPStorm-terminal
# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

# Path to your oh-my-zsh installation.
export ZSH=/Users/ranelpadon/.oh-my-zsh

# https://github.com/romkatv/powerlevel10k
# Unli-run
# p10k configure
ZSH_THEME="powerlevel10k/powerlevel10k"
# Fix the annoying gap in the right prompt!
ZLE_RPROMPT_INDENT=0

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=60

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# TODO: plugins=(git virtualenv virtualenvwrapper python django)
plugins=(git python django)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# DEFAULT_USER="ranelpadon"
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    # prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
    # prompt_segment black default "%(!.%{%F{yellow}%}.)$PATH"
  fi
}

# PROMPT='myPrompt=>'

prompt_agnoster_precmd() {
    RV=$?
    vcs_info
    PROMPT='$(date +%H:%M:%S)%{%f%b%k%}$(prompt_agnoster_main) '
    # RPROMPT="$(my_right_prompt)"
}

gitdiff() {
  git diff $1
}
alias gd=gitdiff

gitcheckout() {
  git checkout $1
}
alias gc=gitcheckout

gitmerge() {
  git merge $1
}
alias gm=gitmerge

gme() {
  git merge ets
}
gmprod() {
  git merge release/ets/prod/v1.8.44
}

my_grh() {
  git reset --hard
} 
alias grh=my_grh
# needs alias because OMZ has `gca` alias also!
# so we need to unbind/override it
# git commit all
my_gca() {
  git commit -am $1
} 
alias gca=my_gca

# git diff ets..release/ets/test/v2.4 apps/backoffice/generic/forms/property_forms.py
gde() {
    git diff ets..$1 $2
}
# `function` keyword is needed in ZSH?
# `u` for `undirty`
gce() {
  git checkout ets
}
gcprod() {
  git checkout release/ets/prod/v1.8.47
}
gcuat() {
  git checkout release/ets/uat/melco/v1.8.44
}
gctt() {
  git checkout whitelabel/ttcl
}
gcmpr() {
  git checkout release/ets/test/melco/v1.8.46
}
gcuat() {
  git checkout release/ets/uat/melco/v1.8.44
}
gcemf() {
  git checkout release/v1.8.32-emfhk-test
}

gple() {
  git pull origin ets
}
gplprod() {
  git pull origin release/ets/prod/v1.8.44
}
gpluat() {
  git pull origin release/ets/uat/melco/v1.8.44
}
gpltt() {
  git pull origin whitelabel/ttcl
}
gplmpr() {
  git pull origin release/ets/test/melco/v1.8.46
}
gpluat() {
  git pull origin release/ets/uat/melco/v1.8.44
}
gplemf() {
  git pull origin release/v1.8.32-emfhk-test
}

gpse() {
  git push origin ets
}
gpsprod() {
  git push origin release/ets/prod/v1.8.44
}
gpsuat() {
  git push origin release/ets/uat/melco/v1.8.44
}
gpstt() {
  git push origin whitelabel/ttcl
}
gpsmpr() {
  git push origin release/ets/test/melco/v1.8.46
}
gpsuat() {
  git push origin release/ets/uat/melco/v1.8.44
}
gpsemf() {
  git push origin release/v1.8.32-emfhk-test
}

gitcheckoutbranchnew() {
  git checkout -b $1 $2
}
alias gcb=gitcheckoutbranchnew

gitadd() {
  git add $1
}
alias ga=gitadd

gitblame() {
  git blame $1
}
alias gb=gitblame

gitblameline() {
  git blame -L $1 $2
}
alias gbl=gitblameline
# get branch name
gbn() {
  git name-rev --name-only --exclude="tags/*" $1
}

# git tag grep
gtg() {
    git fetch --tags
    git tag | grep $1 | sort --version-sort | tail
}

gpl() {
  CURRENT_BRANCH=`git symbolic-ref --short HEAD`
  # git pull origin $1
  git pull origin $CURRENT_BRANCH
}
gps() {
  CURRENT_BRANCH=`git symbolic-ref --short HEAD`
  # git push origin $1
  git push origin $CURRENT_BRANCH
}
gft() {
  git fetch origin $1
}

changelog() {
  git commit -am "Update CHANGELOG."
}
conflict() {
  # $# variable will tell you the number of input arguments the script was passed.
  if [ $# -eq 0 ]
  then
    git commit -am "Fix merge conflicts."
  else
    git commit -am "GL-$1: Fix merge conflicts."
  fi
}
mconflict() {
  git commit -am "Fix migration conflicts."
}
mlist() {
  # fab migrate:--list | grep "NodeNotFoundError\|\[ \]"
  # All results except those migrated ones.
  # fab migrate:--list | grep -v "\[X\]"
  ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/backoffice/manage.py migrate --list | grep -v "\[X\]"
}
migrate() {
  ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/backoffice/manage.py migrate $1
}
mpending() {
  # fab migrate:--list | grep "NodeNotFoundError\|\[ \]"
  fab migrate:--list | grep -v "\[X\]"
}

gcpm() {
  # Should have no space before and after `=` assignement operator!!!
  CURRENT_BRANCH=`git symbolic-ref --short HEAD`
  git checkout $1 && git pull origin $1
  git checkout $CURRENT_BRANCH
  git merge $1
}

# Check release diff/packages/migrations
crd() {
    # limit=2000
    git diff --name-status $1.. -l 2000 | grep migrations\/0
    find . | grep \/migrations\/ | grep -v pyc$ | grep -oE "\/.+\/[0-9]+" | sort | uniq -d
    git diff --name-only $1.. | grep requirements.txt | xargs git diff $1..
}
# Check release logs/merges
crl() {
    git log --pretty='%H %ar %s' --merges --grep='conflict' --grep='test' --regexp-ignore-case  $1..
}
# Check release and migration list
crm() {
    git diff --name-status $1.. | grep migrations\/0
    find . | grep \/migrations\/ | grep -v pyc$ | grep -oE "\/.+\/[0-9]+" | sort | uniq -d
    git diff --name-only $1.. | grep requirements.txt | xargs git diff $1..
    cd docker
    echo "checking for some migration node errors.."
    mlist
    cd ..
}
# Check latest tag
clt() {
  git fetch --tags
  git tag | grep $1
}

# Exclude the untracked files in "test/folder", to reduce clutter.
# Update the gitconfig's color attribute so that grep preserves the color.
# https://unix.stackexchange.com/questions/44266/how-to-colorize-output-of-git
# --invert-match or -v: exclude the PATTERN.
alias gs=' \
    git status \
    | grep --invert-match "test/" \
    | grep -v "media/backoffice/private/csv_uploads/" \
    | grep -v "qos/gate/conf/scapi/" \
    | grep -v "alloserv/assignment.log"
'
# Include the untracked files in test folder.
alias gsu='git status'
alias ds='drush status'

# XAMPP/MAMP Stack.

#  MySQL
# `sudo /Applications/XAMPP/xamppfiles/xampp stopmysql` doesn't kill the PID!
alias m1='sudo /Applications/XAMPP/xamppfiles/mysql/scripts/ctl.sh start'
alias m2='sudo /Applications/XAMPP/xamppfiles/mysql/scripts/ctl.sh stop'
alias m3='m2 && m1'

# Apache/httpd
alias a1='sudo /Applications/XAMPP/xamppfiles/apache2/scripts/ctl.sh start'
alias a2='sudo /Applications/XAMPP/xamppfiles/apache2/scripts/ctl.sh stop'
alias a3='m2 && m1'

alias x1='m1 && a1'
alias x2='m2 && a2'
alias x3='m2 && a2 && m1 && a1'

# # Bitnami MAMP
# alias b1='/Applications/mampstack-5.6.24-0/ctlscript.sh start'
# alias b2='/Applications/mampstack-5.6.24-0/ctlscript.sh stop'
# alias b3='/Applications/mampstack-5.6.24-0/ctlscript.sh restart'

extract() {
  python "/Users/ranelpadon/Data/UP DGE/Resources/Codes/uvle_processor/zip_processor.py" $1
}
alias unrar=extract

# deploy_clockenflap() {
#   # git tag v0.9.2-nz nz/develop
#   # git push origin v0.9.2-nz
#   git tag $1 2016-develop;
#   # git checkout $1;
#   git push origin $1
# }
# alias dc=deploy_clockenflap


# TODO
# global_lib() {
#   export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/System/Library/Frameworks/ImageIO.framework/Resources/"
# }
# # alias fs=fix_stree
# alias glib=global_lib

# local_lib() {
#   export DYLD_LIBRARY_PATH="/usr/local/lib:/usr/lib/:$DYLD_LIBRARY_PATH:/System/Library/Frameworks/ImageIO.framework/Resources/:/Applications/XAMPP/xamppfiles/lib"
#   export DYLD_LIBRARY_PATH="/Applications/XAMPP/xamppfiles/lib"
#   export DYLD_LIBRARY_PATH="/Applications/XAMPP/xamppfiles/lib:/System/Library/Frameworks/ImageIO.framework/Resources/:$DYLD_LIBARY_PATH"
#   # export DYLD_LIBRARY_PATH="/usr/local/lib:/usr/lib/:$DYLD_LIBARY_PATH:/System/Library/Frameworks/ImageIO.framework/Resources/:/Applications/MAMP/Library/lib"
# }
# alias llib=local_lib

grepx() {
  grep -nr "$1" * --color=always
}

findx() {
  find . -name "$1"
}

# For Virtual Env
# TODO:
# export WORKON_HOME=$HOME/.virtualenvs

# Activate virtualenvwrapper on startup.
# TODO:
# source /usr/local/bin/virtualenvwrapper.sh

# export HISTTIMEFORMAT="%d/%m/%y %T "  # for Bash only
# PATH="$PATH:/Applications/XAMPP/xamppfiles/bin:."

# add latest Python2
# PATH="/usr/local/bin:/usr/local/opt/python/libexec/bin:$PATH"

# PATH="/Applications/XAMPP/xamppfiles/bin:$PATH"
# PATH="$PATH:/Applications/MAMP/Library/bin:."
export DRUSH_PHP=/Applications/XAMPP/xamppfiles/bin/php
alias drush="php /Users/ranelpadon/dev/drush7/drush.php"
# alias php="/usr/local/bin/php"

# alias na='ssh -t e35d18971@new.appledrafting.com "cd public_html && bash -l"'

# Show/hide Apple's hidden files.
alias s='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias h='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

import_db_cron(){
  sh ~/Dropbox/import_db_cron.sh $1 $2
}

#syntax: idc <sql_file>
# alias idc=import_db_cron

alias ll='ls -alFGh'

hisx() {
  # TS_DATE="%-m/%-d/%y";
  # TS_TIME="%H:%M:%S";
  # fc -lt "$TS_DATE $TS_TIME" | grep $(date +$TS_DATE)
  # l (LIST), f (format in US time), -15 (last 15 commands)
  # See: http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#Shell-Builtin-Commands
  fc -lf -15  
}


compass_compile_sass() {
  current_dir="$(pwd)"
  target_dir="$HOME/.virtualenvs/crowdfunding/crowdfunding/apps/portal/static/portal/scss"
    
  if [ $current_dir != $target_dir ]; then
    echo "Going to the target SASS directory...";
    # Semicolons are NOT needed when the next command is in next line.
    # Newlines are command separator by default.
    cd $HOME/.virtualenvs/crowdfunding/crowdfunding/apps/portal/static/portal/scss
  fi  
  
  compass compile main.scss
}
alias ccs=compass_compile_sass

manage_py() {
  ./manage.py $1 $2
}

#syntax: idc <sql_file>
alias mp=manage_py

manage_local_py() {
  ./manage_local.py $1 $2
}

#syntax: idc <sql_file>
alias mlp=manage_local_py

urp() {
  ./manage.py update_role_permissions
}


# run() {
#   if [ $1 = 'ec' ]; then
#     urp
#     ./manage.py runserver local.eventcms.com:8000
#   elif [ $1 = 'fa' ]; then 
#     ./manage_local.py runserver local.festivalapp.com:8001  
#   elif [ $1 = 'fa_base' ]; then 
#     ./manage_local.py runserver local.festivalappbase.com:8002 
#   elif [ $1 = 'warped' ]; then 
#     ./manage_local.py runserver warped.local:8000  # defaults to port 8000 
#   elif [ $1 = 'ppp' ]; then 
#     ./manage_local.py runserver local.propertyplus.ph:8000  # defaults to port 8000 
#   fi
# }
# alias run=runserver

# TODO
# export PATH="/usr/local/opt/openssl/bin:$PATH"


# delete all pyc files
# find . -name '*.pyc' -delete
# find . -name "*.pyc" -exec rm -f {} \;

# clear_port 8000
kill_port() {
  # sudo lsof -t -i tcp:8000 | xargs kill -9
  sudo lsof -t -i tcp:$1 | xargs kill -9

  # other way:
  # ps aux | grep 8000
  # kill -9 <process_id>
}
# alias clear_port=clear_port

# So that arrow navigation and history will work when in Python REPL mode.
export PYTHONSTARTUP=/Users/ranelpadon/.python_startup.py

# Auto-completion shit for Drupal Console
source "$HOME/.console/console.rc" 2>/dev/null

# used by Python's sys.stdout.encoding
# You may need to manually set your language environment
# used
export LANG=en_US.UTF-8 # Fix for some unit tests also
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Make the Python console/interpreter UTF-8 compatible
export PYTHONIOENCODING=UTF-8

convert_to_dotted_path() {
  python "/Users/ranelpadon/Data/UP DGE/Resources/Codes/pathx.py" $1
}
alias pathx=convert_to_dotted_path

alias xcode='open -a Xcode'


# alias dfh='docker run --rm warped-base df -h'
# alias dfh='docker run --rm hello-world df -h'

# ubuntu:16.04 is the base system used in TF!

dfh() {
    docker run --rm ubuntu:16.04 df -h
}

dfh2() {
    docker system df -v
}

sshd() {
    fab start:sshd && fab stop:backoffice
}
start() {
    fab start:db && fab start:alloserv && fab start:worker && fab start:memcached
}

fr() {
    cd ~/dev/ticketflap/ticketing/docker

    # DROP the db first
    fab create_database:drop=True

    cd ..

    # Import the sync_TICKETFLAP.sql.gz
    fab local_sync_from_remote_db

    cd docker

    # Re-build Docker image
    fab build:db start:db
}
frb() {
    fab runserver:backoffice
}
frf() {
    fab runserver:frontend
}
frp() {
    fab runserver:processing
}
frr() {
    fab runserver:redemption
}
frw() {
    fab runserver:worker
}
frpb() {
    fab runserver_plus:backoffice
}
rpb() {
    ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/backoffice/manage.py runserver_plus
}
rb() {
    ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/backoffice/manage.py runserver
}
frpf() {
    fab runserver_plus:frontend
}
rf() {
    ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/frontend/manage.py runserver 0.0.0.0:8002
}
frpp() {
    fab runserver_plus:processing
}
rp() {
    ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/processing/manage.py runserver 0.0.0.0:8001
}
frpr() {
    fab runserver_plus:redemption
}
frpw() {
    fab runserver_plus:worker
}
fmb() {
    # For Linux (install first the `xclip` utility: sudo apt-get install xclip)
    # echo 'from django.utils import translation; translation.activate("en")' | xclip -selection clipboard

    # For Mac.
    # Seems to be fixed in Melco white label.
    fab manage:backoffice,$1
}
fmbs() {
    # For Linux (install first the `xclip` utility: sudo apt-get install xclip)
    # echo 'from django.utils import translation; translation.activate("en")' | xclip -selection clipboard

    # For Mac.
    # Seems to be fixed in Melco white label.
    echo 'from django.utils import translation; translation.activate("en")' | pbcopy
    fab manage:backoffice,shell
}
fmbsp() {
    fab manage:backoffice,shell_plus
}

# fab pip install
# fpi backoffice "factory-boy\=\=2.8.1"  <-- needs the quotes!!!
# fab pip:backoffice,'install factory-boy\=\=2.8.1' 
fpi() {
    # echo "install $2"
    fab pip:$1,"install $2"
}

act() {
    # echo 'from django.utils import translation; translation.activate("en")' | pbcopy
}



tc() {
    ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/$1/manage.py test $2 --settings=settings.local_settings._local_sqlite.$1 --verbosity=0
}
# Sample: ftb apps.common.voucher.tests.test_models verbosity=2
ftb() {
    # dotted_path=$(pathx $1)
    # fab test:backoffice,$dotted_path
    # fab test:backoffice,$1,auto_clean_pyc=0,$2

    # $# variable will tell you the number of input arguments the script was passed.
    if [ $# -eq 1 ]
    then
      fab test:backoffice,$1,auto_clean_pyc=0
    else
      fab test:backoffice,$1,auto_clean_pyc=0,$2
    fi
}
tb() {
    ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/backoffice/manage.py test $1 --settings=settings.local_settings._local_sqlite.backoffice --verbosity=0
}
ftf() {
    # dotted_path=$(pathx $1)
    # fab test:frontend,$dotted_path
    # fab test:frontend,$1,auto_clean_pyc=0,$2

    # $# variable will tell you the number of input arguments the script was passed.
    if [ $# -eq 1 ]
    then
      fab test:frontend,$1,auto_clean_pyc=0
    else
      fab test:frontend,$1,auto_clean_pyc=0,$2
    fi
}
tf() {
    ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/frontend/manage.py test $1 --settings=settings.local_settings._local_sqlite.frontend --verbosity=0
}
ftp() {
    # dotted_path=$(pathx $1)
    # fab test:processing,$dotted_path
    # fab test:processing,$1,auto_clean_pyc=0,$2

    # $# variable will tell you the number of input arguments the script was passed.
    if [ $# -eq 1 ]
    then
      fab test:processing,$1,auto_clean_pyc=0
    else
      fab test:processing,$1,auto_clean_pyc=0,$2
    fi
}
tp() {
    ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/processing/manage.py test $1 --settings=settings.local_settings._local_sqlite.processing --verbosity=0
}
ftr() {
    # dotted_path=$(pathx $1)
    # fab test:redemption,$dotted_path
    # fab test:redemption,$1,auto_clean_pyc=0,$2

    # $# variable will tell you the number of input arguments the script was passed.
    if [ $# -eq 1 ]
    then
      fab test:redemption,$1,auto_clean_pyc=0
    else
      fab test:redemption,$1,auto_clean_pyc=0,$2
    fi
}
fts() {
    # dotted_path=$(pathx $1)
    # fab test:processing,$dotted_path
    # fab test:processing,$1,auto_clean_pyc=0,$2

    # $# variable will tell you the number of input arguments the script was passed.
    if [ $# -eq 1 ]
    then
      fab test:sessions_api,$1,auto_clean_pyc=0
    else
      fab test:sessions_api,$1,auto_clean_pyc=0,$2
    fi
}
ts() {
    ~/.pyenv/versions/2.7.17/envs/ticketing/bin/python ~/dev/ticketflap/ticketing/apps/sessions_api/manage.py test $1 --settings=settings.local_settings._local_sqlite.sessions_api --verbosity=0
}

frdb() {
    # should be in docker/ folder!!!!
    # no need for this now since Homebrew's /usr/local/bin/mysql is ok now!
    # Set this first in root `fabfile.py`
    # local('gunzip < {db_target_file} | /Applications/XAMPP/xamppfiles/bin/mysql {db_connect} {db_target}'.format(
    # fab stop  # since Cmd+C will still leave the `db` container running in the background.
    # this doesnt work due to CLI error.
    # export PATH="/Applications/XAMPP/xamppfiles/bin:$PATH"
    # clear the docker compose's autoruns, to free up the MySQL port.
    dc
    fab create_database:drop=True
    cd ..
    fab local_sync_from_remote_db
    cd docker
}
frdbm() {
    # should be in docker/ folder!!!!
    # Set this first in root `fabfile.py`
    # local('gunzip < {db_target_file} | /Applications/XAMPP/xamppfiles/bin/mysql {db_connect} {db_target}'.format(
    # fab stop  # since Cmd+C will still leave the `db` container running in the background.
    # export PATH="/Applications/XAMPP/xamppfiles/bin:$PATH"
    # clear the docker compose's autoruns, to free up the MySQL port.
    dc
    fab create_database:drop=True
    cd ..
    fab local_sync_from_remote_db
    cd docker
    fab migrate
}
fcp() {
    # Clear the .pyc files.
    fab local_remove_all_pyc
}
# start_local_alloserv
sla() {
    # Needs `fab stop:alloserv fab start:db fab start:memcached fab start:worker`
    pyenv activate alloserv \
    && cd /Users/ranelpadon/dev/ticketflap/ticketing/alloserv/ \
    && python alloserv_entry.py --config alloserv/conf/local_settings.py
}
# docker clear
dc() {
    docker stop \
        sessions-ui \
        ets-mysql \
        ticketing_ets-celery_1
}


##########


worker_log() {
    tail -f ~/dev/ticketflap/ticketing/logs/worker.log
}
worker_logs() {
    worker_log
}
wlog() {
    worker_log
}
wlogs() {
    worker_log
}
wl() {
    worker_log
}
# check-worker-logs
cwl() {
    # Verbose
    docker exec --tty --interactive --workdir /var/log/supervisor ticketflap-worker bash
    # docker exec --tty --interactive --workdir /var/log/supervisor $(docker ps --filter "name=ticketflap-worker" --quiet) bash
    # Shorthand
    # docker exec -ti -w /var/log/supervisor $(docker ps -f "name=ticketflap-worker" -q) bash
    # docker exec -ti -w /var/log/supervisor ticketflap-worker bash
    # docker exec -ti ticketflap-worker

    # Try these instead???
    # have errors though:
    # tail: cannot open '/var/log/supervisor/worker-2.log' for reading: No such file or directory
    # fab log:worker,worker-1
    # fab log:worker,worker-2
    # fab log:worker,worker-low
    # fab log:worker,scheduler
    # fab log:worker,reporter

    # No error when executing.
    # fab log:frontend,error
}
# docker-worker-logs
dwl() {
    cwl
}


##########

# RipGrep MAN page:
# https://www.mankier.com/1/rg

# Search in migration files.
rmp() {
  rg $1 --glob '**/migrations/**'
}

# Search in test files.
rt() {
  rg $1 --glob '**/tests/**'
}


ra() {
    # Include the Git-ignored files w/c are excluded by default!
    rg -i --no-ignore --type-add 'compiled:*.compiled' --type-not compiled $1 $2 --colors match:bg:249,245,154 --colors match:fg:66,98,150 --colors match:style:nobold
}
rac() {
    # rga ">>>>>>"
    rg --type-add 'po:*.po' --type-add 'yml:*.yml' --type po --type py --type html --type js --type css --type txt --type yml ">>>>>>" -s \
        --colors match:bg:249,245,154 --colors match:fg:66,98,150 --colors match:style:nobold
}


rp() {
    # Python files only. 
    # -i for case-insensitive search.
    # -s for sensitive-case search.
    rg -i -tpy $1 $2 --colors match:bg:249,245,154 --colors match:fg:66,98,150 --colors match:style:nobold
}

rh() {
    # HTML files only.
    rg -i -thtml $1 $2 --colors match:bg:249,245,154 --colors match:fg:66,98,150 --colors match:style:nobold
}

rj() {
    # JS files only. Exclude minified files.
    rg -i -tjs -g '!*.min.js' $1 $2 --colors match:bg:249,245,154 --colors match:fg:66,98,150 --colors match:style:nobold
}

rc() {
    # CSS files only.
    rg -i -tcss $1 $2 --colors match:bg:249,245,154 --colors match:fg:66,98,150 --colors match:style:nobold
}


rph() {
    # Python + HTML files.
    rg -i -tpy -thtml $1 $2 --colors match:bg:249,245,154 --colors match:fg:66,98,150 --colors match:style:nobold
}

rphj() {
    # Python + HTML + JS files.
    rg -i -tpy -thtml -tjs -g '!*.min.js' $1 $2 --colors match:bg:249,245,154 --colors match:fg:66,98,150 --colors match:style:nobold
}


rhj() {
    # HTML + JS files.
    rg -i -thtml -tjs -g '!*.min.js' $1 $2 --colors match:bg:249,245,154 --colors match:fg:66,98,150 --colors match:style:nobold
}

rhjc() {
    # HTML + JS + CSS files.
    rg -i -thtml -tjs -tcss -g '!*.min.js' $1 $2 --colors match:bg:249,245,154 --colors match:fg:66,98,150 --colors match:style:nobold
}

clear_logs() {
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/admission.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/backoffice.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/backoffice_sql.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/backoffice_sql.log.2019-04-18
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/backoffice_sql.log.2019-06-28
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/celery/worker-low@ticketflap-worker.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/celery/worker-1@ticketflap-worker.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/celery/worker-2@ticketflap-worker.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/celery/scheduler@ticketflap-worker.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/celery/reporter@ticketflap-worker.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/console_backoffice.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/console_frontend.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/console_processing.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/console_redemption.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/console_worker.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/frontend.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/playpass.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/processing.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/processing_sql.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/processing_sql.log.2019-06-26
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/processing_sql.log.2019-06-27
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/reminder_email.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/reminder_email.log
    cat /dev/null > /Users/ranelpadon/dev/ticketflap/ticketing/logs/worker.log
}

# apply isort
ai() {
    isort $1 --multi-line 3 --trailing-comma --force-grid-wrap
}

# Skip ETS manage.py test_coverage
export COVERAGE_SKIP=1


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
#


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
xmysql() {
    /Applications/XAMPP/xamppfiles/bin/mysql -uroot -ppassword
#     export PATH="/Applications/XAMPP/xamppfiles/bin:$PATH"
}

z() {
    exec zsh
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Homebew's Ruby/gem
# export PATH="/usr/local/opt/ruby/bin:$PATH"
# Homebrew's colorls
# https://github.com/athityakumar/colorls#table-of-contents
# https://github.com/athityakumar/colorls/issues/238#issuecomment-439433117
##export PATH="/usr/local/lib/ruby/gems/2.7.0/bin/:$PATH"
# dirs first, then files.
##alias ll='colorls -lA --sort-dirs'
alias ll='exa --long --icons --all --group-directories-first'

# Doom Emacs
export PATH="/Users/ranelpadon/.emacs.d/bin:$PATH"

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  # eval "$(pyenv virtualenv-init -)"  # Optional.
fi

if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)";
fi

# `quiet` mode means to disable the POWERLEVEL instant prompt.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# The system logo.
# neofetch


# `bat`
# https://github.com/sharkdp/bat
export BAT_THEME="TwoDark"

# fzf
# https://github.com/junegunn/fzf
# Setting fd as the default source for fzf
# If you want the command to follow symbolic links,
# and don't want it to exclude hidden files, use the following command:
# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# --type f \
export FZF_DEFAULT_COMMAND=" \
    fd \
    --hidden \
    --follow \
    --no-ignore \
    --exclude node_modules \
    --exclude logs \
    --exclude media \
    --exclude static \
    --exclude cache \
    --exclude .git \
    --exclude '.git' \
    --exclude '*.pyc' \
    --exclude '*.compiled' \
    --exclude '*.scssc' \
"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# _fzf_compgen_path() {
  # fd --hidden --follow --exclude ".git" . "$1"
# }

# Use fd to generate the list for directory completion
# _fzf_compgen_dir() {
  # fd --type d --hidden --follow --exclude ".git" . "$1"
# }

# Enable preview
# fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias fh='history | fzf'


# Remap `Caps Lock` to `delete` key.
# https://apple.stackexchange.com/questions/7231/how-can-i-rebind-caps-lock-to-delete-backspace
# https://developer.apple.com/library/archive/technotes/tn2450/_index.html
# https://chrisltd.com/blog/2015/03/caps-lock-to-backspace-mac/
# hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000002A}]}'

pyenv global 2.7.17
export PATH="/usr/local/opt/node@12/bin:$PATH"
# export PYTHONPATH="${PYTHONPATH}:${HOME}/.pyenv/versions/2.7.17/envs/ticketing/bin/python:${HOME}/.pyenv/versions/3.6.10/bin/python:${HOME}/dev/ticketflap/ticketing/apps:${HOME}/dev/ticketflap/ticketing/conf"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ranelpadon/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ranelpadon/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.

if [ -f '/Users/ranelpadon/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ranelpadon/google-cloud-sdk/completion.zsh.inc'; fi

# export TERM="alacritty"
# export CLICOLOR=1


# Fix imports
fim() {
  git diff --name-only ets \
  | grep '.py' \
  | grep -v 'migrations/' \
  | grep -v 'conf/' \
  | xargs isort
}


# alias nvim='~/dev/binaries/nvim-osx64/bin/nvim'

alias tmuxx='source ~/.config/tmux/tmuxrc.sh'

alias gad='gcloud app deploy'



# Start an HTTP server from a directory, optionally specifying the port
server() {
    open "http://localhost:8000/" &
    php -S localhost:8000
}


linkify() {
    cp $1 ~/dev/configs
    mv $1 "$1_orig"
    filename="$(basename -- $1)"
    ln -s ~/dev/configs/$filename $1
}


# This conflicts with `fzf`'s Ctrl-R for command history.
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[3 q"
# }


# Open all files with merge conflicts with nvim
mcn() {
    git diff --name-only | uniq | xargs nvim
}


# nnn
export NNN_PLUG='p:preview-tui;t:preview-tabbed;d:dragdrop;v:imgview'
export NNN_BMS='r:"/Users/ranelpadon/Data/UP DGE/Resources"'
export NNN_FIFO='/Users/ranelpadon/tmp/nnn.fifo'


export COLORTERM="truecolor"
export FZF_PREVIEW_COMMAND="COLORTERM=truecolor bat --style=numbers --color=always --line-range :500 {}"


alias lg='lazygit'


# Karabiner/BTT sends <C-Z> which zsh/Vim interprets as the EOL.
# https://jdhao.github.io/2019/06/13/zsh_bind_keys/
bindkey '^Z' end-of-line


# Fix commit email
fce() {

    git filter-branch --env-filter '
        WRONG_EMAIL="ranel.padon@magneticasis.com"
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

