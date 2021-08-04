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
tmux send-keys -t 'k8s:MCSTAG' 'cd ~/dev/melco && gc release/production && gpl && nvim' Enter
tmux send-keys -t 'k8s:MGMSTAG' 'cd ~/dev/mgm && gc main && gpl && nvim' Enter
tmux send-keys -t 'k8s:GTSSTAG' 'cd ~/dev/11-skies && gc main && gpl && nvim' Enter
tmux send-keys -t 'k8s:ZIPSTAG' 'cd ~/dev/zipcity && gc main && gpl && nvim' Enter
tmux send-keys -t 'k8s:SUNSTAG' 'cd ~/dev/sun-entertainment && gc main && gpl && nvim' Enter
tmux send-keys -t 'k8s:HKRUSTAG' 'cd ~/dev/hkru && gc main && gpl && nvim' Enter
tmux send-keys -t 'k8s:ZKTSTAG' 'cd ~/dev/zicket && gc main && gpl && nvim' Enter

# Activate main window
tmux select-window -t 'k8s:MCSTAG'
tmux -u attach-session -t k8s
