#!/bin/sh

# Tabs
tmux new-session -s k8s -n 'MCSTAG' -d
tmux new-window -t k8s -n 'MGMSTAG'
tmux new-window -t k8s -n 'GTSSTAG'
tmux new-window -t k8s -n 'ZIPSTAG'
tmux new-window -t k8s -n 'SUNSTAG'
tmux new-window -t k8s -n 'HKRUSTAG'
tmux new-window -t k8s -n 'ZKTSTAG'

# Auto-runs
tmux send-keys -t 'k8s:MCSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/melco/-/pipelines" &&
    cd ~/dev/melco &&
    gc release/production &&
    gpl &&
    nvim
' Enter
tmux send-keys -t 'k8s:MGMSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/mgm/-/pipelines" &&
    cd ~/dev/mgm &&
    gc main &&
    gpl &&
    nvim
' Enter
tmux send-keys -t 'k8s:GTSSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/11-skies/-/pipelines" &&
    cd ~/dev/11-skies &&
    gc main &&
    gpl &&
    nvim
' Enter
tmux send-keys -t 'k8s:ZIPSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/zipcity/-/pipelines" &&
    cd ~/dev/zipcity &&
    gc main &&
    gpl &&
    nvim
' Enter
tmux send-keys -t 'k8s:SUNSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/sun-entertainment/-/pipelines" &&
    cd ~/dev/sun-entertainment &&
    gc main &&
    gpl &&
    nvim
' Enter
tmux send-keys -t 'k8s:HKRUSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/hkru/-/pipelines" &&
    cd ~/dev/hkru &&
    gc main &&
    gpl &&
    nvim
' Enter
tmux send-keys -t 'k8s:ZKTSTAG' '
    open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/zicket/-/pipelines" &&
    cd ~/dev/zicket &&
    gc main &&
    gpl &&
    nvim
' Enter

# Activate main window
tmux select-window -t 'k8s:MCSTAG'
tmux -u attach-session -t k8s