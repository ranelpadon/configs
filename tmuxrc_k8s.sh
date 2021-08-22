#!/bin/sh

# Run as in (new Alacritty window or in Kitty):
# kube ets-prod-v1.8.47-RC123
# since $TAG is needed envvar.

# Tabs
# tmux new-session -s k8s -n 'DEMOSTAG' -d
tmux new-session -s k8s -n 'GTSSTAG' -d
tmux new-window -t k8s -n 'HKRUSTAG'
tmux new-window -t k8s -n 'MCSTAG'
tmux new-window -t k8s -n 'MGMSTAG'
tmux new-window -t k8s -n 'SUNSTAG'
tmux new-window -t k8s -n 'ZIPSTAG'
tmux new-window -t k8s -n 'ZKTSTAG'

# Auto-runs
# tmux send-keys -t 'k8s:DEMOSTAG' '
    # open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/demo/-/pipelines" &&
    # cd ~/dev/demo &&
    # gc main &&
    # gpl &&
    # fd ".gitlab*" --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[0-9]\{1,\}$/$TAG/" &&
    # gd
# ' Enter
tmux send-keys -t 'k8s:GTSSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/11-skies/-/pipelines" &&
    cd ~/dev/11-skies &&
    gc main &&
    gpl &&
    fd --regex "gitlab-ci.yml|gitlab-ci.staging.*" --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[0-9]\{1,\}$/$TAG/" &&
    gd
' Enter
tmux send-keys -t 'k8s:HKRUSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/hkru/-/pipelines" &&
    cd ~/dev/hkru &&
    gc main &&
    gpl &&
    fd "gitlab*" --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[0-9]\{1,\}$/$TAG/" &&
    gd
' Enter
tmux send-keys -t 'k8s:MCSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/melco/-/pipelines" &&
    cd ~/dev/melco &&
    gc release/production &&
    gpl &&
    fd "gitlab*" --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[0-9]\{1,\}$/$TAG/" &&
    gd
' Enter
tmux send-keys -t 'k8s:MGMSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/mgm/-/pipelines" &&
    cd ~/dev/mgm &&
    gc main &&
    gpl &&
    fd --regex "gitlab-ci.yml|gitlab-ci.staging.*"  --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[0-9]\{1,\}$/$TAG/" &&
    gd
' Enter
tmux send-keys -t 'k8s:SUNSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/sun-entertainment/-/pipelines" &&
    cd ~/dev/sun-entertainment &&
    gc main &&
    gpl &&
    fd "gitlab*" --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[0-9]\{1,\}$/$TAG/" &&
    gd
' Enter
tmux send-keys -t 'k8s:ZIPSTAG' '
open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/zipcity/-/pipelines" &&
    cd ~/dev/zipcity &&
    gc main &&
    gpl &&
    fd "gitlab*" --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[0-9]\{1,\}$/$TAG/" &&
    gd
' Enter
tmux send-keys -t 'k8s:ZKTSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/zicket/-/pipelines" &&
    cd ~/dev/zicket &&
    gc main &&
    gpl &&
    fd "gitlab*" --hidden --print0 | xargs -0 sed -i "" -e "s/ets-prod-v1.8.47-RC[0-9]\{1,\}$/$TAG/" &&
    gd
' Enter

# Activate main window
tmux select-window -t 'k8s:GTSSTAG'
tmux -u attach-session -t k8s
