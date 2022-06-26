_tmuxx_resume() {
    tmux attach -t $1
}

alias tmuxx='source ~/.config/tmux/tmuxrc.sh'
alias tmuxx_kube_test='source ~/.config/tmux/tmuxrc_k8s_test.sh'
alias tmuxx_kube_stag='source ~/.config/tmux/tmuxrc_k8s_stag.sh'
alias tmuxx_kube_prod='source ~/.config/tmux/tmuxrc_k8s_prod.sh'

alias tmuxx_resume='_tmuxx_resume Workspace'
alias tmuxx_resume_test='_tmuxx_resume k8s_test'
alias tmuxx_resume_stag='_tmuxx_resume k8s_stag'
alias tmuxx_resume_prod='_tmuxx_resume k8s_prod'

# update_ets_version TEST 123
# update_ets_version STAG 123
# update_ets_version PROD 123
update_ets_version() {
    tmux set-environment -g TAG $2
    ENV=$(echo $1 | tr '[:upper:]' '[:lower:]')
    eval tmuxx_kube_$ENV
}

# commit_ets_version TEST 123
# commit_ets_version STAG 123
# commit_ets_version PROD 123
commit_ets_version() {
    # Send the same Git commit message to all active windows.
    SESSION_NAME=$(tmux display-message -p '#S')

    # Double quotes are needed to correctly evaluate the inner vars.
    if [[ "$1" = "TEST" ]]
    then
        MESSAGE="
            gca 'Update $1 to ets-test-v3.0.$2.'
        "
    else
        MESSAGE="
            gca 'Update $1 to ets-prod-v2.0.$2.'
        "
    fi

    MESSAGE+='gps'

    tmux list-windows -t $SESSION_NAME|cut -d: -f1|xargs -I{} tmux send-keys -t $SESSION_NAME:{} $MESSAGE Enter
}


refresh_windows() {
    SESSION_NAME=$(tmux display-message -p '#S')
    tmux list-windows -t $SESSION_NAME|cut -d: -f1|xargs -I{} tmux send-keys -t $SESSION_NAME:{} ez Enter
}

