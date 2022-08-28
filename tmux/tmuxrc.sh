#!/bin/sh

# Tabs
tmux new-session -s Workspace -n "Configs" -d
tmux new-window -t Workspace -n "Vortex"
tmux new-window -t Workspace -n "Nvim ETS"
tmux new-window -t Workspace -n "ETS-1"
tmux new-window -t Workspace -n "ETS-2"
tmux new-window -t Workspace -n "ETS-3"
tmux new-window -t Workspace -n "Docker"
tmux new-window -t Workspace -n "Dev"
tmux new-window -t Workspace -n "Home"

# Auto-runs
tmux send-keys -t "Workspace:Configs" "cd ~/dev/configs && pat && nvim" Enter
tmux send-keys -t "Workspace:Vortex" "cd ~/Dropbox/Vortex && pat && nvim" Enter
tmux send-keys -t "Workspace:Nvim ETS" "cd ~/dev/ticketflap/ticketing && pat && nvim" Enter
tmux send-keys -t "Workspace:ETS-1" "cd ~/dev/ticketflap/ticketing && pat" Enter
tmux send-keys -t "Workspace:ETS-2" "cd ~/dev/ticketflap/ticketing && pat" Enter
tmux send-keys -t "Workspace:ETS-3" "cd ~/dev/ticketflap/ticketing && pat" Enter
tmux send-keys -t "Workspace:Dev" "cd ~/dev" Enter

# Activate main window
tmux select-window -t "Workspace:Configs"
tmux -u attach-session -t Workspace
