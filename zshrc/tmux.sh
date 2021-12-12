_tmuxx_resume() {
    tmux attach -t $1
}

alias tmuxx='source ~/.config/tmux/tmuxrc.sh'
alias tmuxx_kube_stag='source ~/.config/tmux/tmuxrc_k8s_stag.sh'
alias tmuxx_kube_prod='source ~/.config/tmux/tmuxrc_k8s_prod.sh'

alias tmuxx_resume='_tmuxx_resume Workspace'
alias tmuxx_resume_stag='_tmuxx_resume k8s_stag'
alias tmuxx_resume_prod='_tmuxx_resume k8s_prod'

# kube_update STAG 123
# kube_update PROD 123
kube_update() {
    tmux set-environment -g TAG $2
    ENV=$(echo $1 | tr '[:upper:]' '[:lower:]')
    eval tmuxx_kube_$ENV
}

# kube_commit STAG 123
# kube_commit PROD 123
kube_commit() {
    # Send the same Git commit message to all active windows.
    SESSION_NAME=$(tmux display-message -p '#S')
    # Double quotes are needed to correctly evaluate the inner vars.
    MESSAGE="
      gca 'Update $1 to RC$2.'
      gps
    "
    tmux list-windows -t $SESSION_NAME|cut -d: -f1|xargs -I{} tmux send-keys -t $SESSION_NAME:{} $MESSAGE Enter
}

refresh_windows() {
    SESSION_NAME=$(tmux display-message -p '#S')
    tmux list-windows -t $SESSION_NAME|cut -d: -f1|xargs -I{} tmux send-keys -t $SESSION_NAME:{} ez Enter
}

