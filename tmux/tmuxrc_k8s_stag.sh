#!/bin/sh

# Dependencies:
# 1. https://github.com/sharkdp/fd
# 2. https://github.com/chmln/sd
# Run as (new Alacritty window or in Kitty):
# kube_stag 123 (for RC123)
# since $TAG is needed envvar.


# Tabs
tmux new-session -s k8s_stag -d

_new_window() {
    tmux new-window  -t k8s_stag -n $1 -e WHITELABEL=$2
}

_new_window GTSSTAG 11-skies
_new_window HKRUSTAG hkru
_new_window MCSTAG melco
_new_window MGMSTAG mgm
_new_window SUNSTAG sun-entertainment
_new_window ZIPSTAG zipcity
_new_window ZKTSTAG zicket


# Helper function.
_update_env() {
    COMMAND='
        open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/$WHITELABEL/-/pipelines" &&
        cd ~/dev/$WHITELABEL &&
    '
    # Melco has special branch.
    if [ "$1" = "MCSTAG" ]
    then
        COMMAND+='gc release/production &&'
    else
        COMMAND+='gc main &&'
    fi

    COMMAND+='
        gpl &&
        fd --regex "gitlab-ci(.staging)?.yml" --hidden --print0 \
            | xargs -0 sd "ets-prod-v1.8.47-RC[^\s]+" "ets-prod-v1.8.47-RC$TAG" &&
        gd
    '
    tmux send-keys -t k8s_stag:$1 $COMMAND Enter
}

# Auto-runs
_update_env GTSSTAG
_update_env HKRUSTAG
_update_env MCSTAG
_update_env MGMSTAG
_update_env SUNSTAG
_update_env ZIPSTAG
_update_env ZKTSTAG


# Activate main window
tmux select-window -t 'k8s_stag:GTSSTAG'
tmux -u attach-session -t k8s_stag
