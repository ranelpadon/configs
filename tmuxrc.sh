#!/bin/sh

# Tabs
tmux new-window -s Workspace -n "Configs" -d
tmux new-session -t Workspace -n "Nvim ETS"
tmux new-window -t Workspace -n "ETS"
tmux new-window -t Workspace -n "Docker"
tmux new-window -t Workspace -n "Dev"
tmux new-window -t Workspace -n "Home"

# Auto-runs
tmux send-keys -t "Workspace:Configs" "cd ~/dev/configs" Enter
tmux send-keys -t "Workspace:Nvim ETS" "cd ~/dev/ticketflap/ticketing && pyenv activate ticketing && nvim" Enter
tmux send-keys -t "Workspace:ETS" "cd ~/dev/ticketflap/ticketing" Enter
tmux send-keys -t "Workspace:Docker" "cd ~/dev/ticketflap/ticketing/docker" Enter
tmux send-keys -t "Workspace:Dev" "cd ~/dev" Enter

# Activate main window
tmux select-window -t "Workspace:configs"
tmux -u attach-session -t Workspace
