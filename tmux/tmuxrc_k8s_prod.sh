#!/bin/sh

# Run as in (new Alacritty window or in Kitty):
# kube_prod 123 (for RC123)
# since $TAG is needed envvar.

# Tabs
tmux new-session -s k8s_prod -n 'DEMOSTAG' -d
tmux new-window -t k8s_prod -n 'GTSPROD'
tmux new-window -t k8s_prod -n 'KGGPROD'
tmux new-window -t k8s_prod -n 'MGMPROD'
tmux new-window -t k8s_prod -n 'ZIPPROD'

# Auto-runs
tmux send-keys -t 'k8s_prod:DEMOSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/demo/-/pipelines" &&
    cd ~/dev/demo &&
    gc main &&
    gpl &&
    fd --regex "gitlab-ci.yml|gitlab-ci.production.*" --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[^\s]\{1,\}$/ets-prod-v1.8.47-RC$TAG/" &&
    gd
' Enter
tmux send-keys -t 'k8s_prod:GTSPROD' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/11-skies/-/pipelines" &&
    cd "~/dev/11-skies" &&
    gc main &&
    gpl &&
    git tag $TAG &&
    git push origin $TAG
' Enter
tmux send-keys -t 'k8s_prod:KGGPROD' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/kgg-kg/-/pipelines" &&
    cd ~/dev/kgg-kg &&
    gc main &&
    gpl &&
    fd --regex "gitlab-ci.yml|gitlab-ci.production.*" --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[^\s]\{1,\}$/ets-prod-v1.8.47-RC$TAG/" &&
    gd
' Enter
tmux send-keys -t 'k8s_prod:MGMPROD' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/mgm/-/pipelines" &&
    cd ~/dev/mgm &&
    gc main &&
    gpl &&
    fd --regex "gitlab-ci.yml|gitlab-ci.production-shared.*" --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[^\s]\{1,\}$/ets-prod-v1.8.47-RC$TAG/" &&
    gd
' Enter
tmux send-keys -t 'k8s_prod:ZIPPROD' '
open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/zipcity/-/pipelines" &&
    cd ~/dev/zipcity &&
    gc main &&
    gpl &&
    git tag $TAG &&
    git push origin $TAG
' Enter

# Activate main window
tmux select-window -t 'k8s_prod:DEMOSTAG'
tmux -u attach-session -t k8s_prod
