#!/bin/sh

# Tabs
tmux new-session -s Workspace -n "Configs" -d
tmux new-window -t Workspace -n "Vortex"
tmux new-window -t Workspace -n "Nvim ETS"
tmux new-window -t Workspace -n "ETS-1"
tmux new-window -t Workspace -n "ETS-2"
tmux new-window -t Workspace -n "ETS-3"
tmux new-window -t Workspace -n "ETS-4"
tmux new-window -t Workspace -n "Nvim Whitelabels"
tmux new-window -t Workspace -n "Whitelabels"
tmux new-window -t Workspace -n "Django"
tmux new-window -t Workspace -n "Desktop"

# Auto-runs
tmux send-keys -t "Workspace:Configs" "cd ~/dev/configs && nvim" Enter
tmux send-keys -t "Workspace:Vortex" "cd ~/Dropbox/Vortex && nvim" Enter
tmux send-keys -t "Workspace:Nvim ETS" "cd ~/dev/ticketflap/ticketing && pat && nvim" Enter
tmux send-keys -t "Workspace:ETS-1" "cd ~/dev/ticketflap/ticketing && pat" Enter
tmux send-keys -t "Workspace:ETS-2" "cd ~/dev/ticketflap/ticketing && pat" Enter
tmux send-keys -t "Workspace:ETS-3" "cd ~/dev/ticketflap/ticketing && pat" Enter
tmux send-keys -t "Workspace:ETS-4" "cd ~/dev/ticketflap/ticketing && pat" Enter
tmux send-keys -t "Workspace:Nvim Whitelabels" "cd ~/dev/whitelabels/scripts/python && nvim" Enter
tmux send-keys -t "Workspace:Whitelabels" "cd ~/dev/whitelabels/scripts/python && conda activate py311" Enter
tmux send-keys -t "Workspace:Django" "cd /opt/homebrew/Caskroom/miniforge/base/envs/ticketing/lib/python2.7/site-packages/django" Enter
tmux send-keys -t "Workspace:Desktop" "cd ~/Desktop" Enter

# Activate main window
tmux select-window -t "Workspace:Configs"
tmux -u attach-session -t Workspace
