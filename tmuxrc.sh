#!/bin/sh

# Tabs
tmux new-session -s Workspace -n "Nvim ETS" -d
tmux new-window -t Workspace -n "ETS"
tmux new-window -t Workspace -n "Docker"
tmux new-window -t Workspace -n "Dev"
tmux new-window -t Workspace -n "Configs"
tmux new-window -t Workspace -n "Home"

# Auto-runs
tmux send-keys -t "Workspace:Nvim ETS" "cd ~/dev/ticketflap/ticketing && pyenv activate ticketing && nvim" Enter
tmux send-keys -t "Workspace:ETS" "cd ~/dev/ticketflap/ticketing" Enter
tmux send-keys -t "Workspace:Docker" "cd ~/dev/ticketflap/ticketing/docker" Enter
tmux send-keys -t "Workspace:Configs" "cd ~/dev/configs" Enter
tmux send-keys -t "Workspace:Dev" "cd ~/dev" Enter

# Activate main window
tmux select-window -t "Workspace:Nvim ETS"
tmux -u attach-session -t Workspace
