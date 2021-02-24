#!/bin/sh

# Tabs
tmux new-session -s Workspace -n "Vim ETS" -d
tmux new-window -t Workspace -n "Vim Vortex"
tmux new-window -t Workspace -n "Vim Configs"
tmux new-window -t Workspace -n "ETS"
tmux new-window -t Workspace -n "Docker"
tmux new-window -t Workspace -n "Sessions UI"
tmux new-window -t Workspace -n "Dev"
tmux new-window -t Workspace -n "Home"

# Auto-runs
tmux send-keys -t "Workspace:Vim ETS" "cd ~/dev/ticketflap/ticketing && pyenv activate ticketing && vim" Enter
tmux send-keys -t "Workspace:Vim Vortex" "cd ~/Dropbox/Vortex && vim" Enter
tmux send-keys -t "Workspace:Vim Configs" "cd ~/dev/configs && vim" Enter
tmux send-keys -t "Workspace:ETS" "cd ~/dev/ticketflap/ticketing" Enter
tmux send-keys -t "Workspace:Docker" "cd ~/dev/ticketflap/ticketing/docker" Enter
tmux send-keys -t "Workspace:Sessions UI" "cd ~/dev/sessions-ui && pyenv activate alloserv" Enter
tmux send-keys -t "Workspace:Dev" "cd ~/dev" Enter

# Activate main window
tmux select-window -t "Workspace:Vim ETS"
tmux -u attach-session -t Workspace