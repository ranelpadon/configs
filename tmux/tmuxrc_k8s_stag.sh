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


_new_window 29RSGSTAG 29rooms-sg
_new_window AAJSTAG allaboutjazz
_new_window BYMOPSTAG bookyay-mop
_new_window BYNTDSTAG bookyay-ntd
_new_window DEMOSTAG demo
_new_window F7STAG f7
_new_window GTSSTAG 11-skies  # GTSSTAG and GTSSTAG-K11
_new_window HKILFSTAG hkilf
_new_window HKRUSTAG hkru
_new_window KGGSTAG kgg-kg
_new_window MCSTAG melco
_new_window MCCSTAG melco-cyprus
_new_window MGMSTAG mgm
_new_window MTSTAG matchtic
_new_window SUNSTAG sun-entertainment
_new_window TASTAG tatlerasia
_new_window TKLSTAG tickelo
_new_window TTLSTAG totalticketing
_new_window ZIPSTAG zipcity
# _new_window ZKTSTAG zicket
_new_window ZUNISTAG zuni


# Helper function.
_update_env() {
    COMMAND='
        open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/$WHITELABEL/-/pipelines"
        cd ~/dev/$WHITELABEL
        gc main
        gpl
        fd --regex "gitlab-ci(.staging.*)?.yml" --hidden \
            | xargs sd "ets-prod-v2.0.[^\s]+" "ets-prod-v2.0.$TAG"
        gd
    '
    # | xargs sd "ets-prod-v1.8.47-RC[^\s]+" "ets-prod-v2.0.$TAG"
    tmux send-keys -t k8s_stag:$1 $COMMAND Enter
}

# Auto-runs
_update_env 29RSGSTAG
_update_env AAJSTAG
_update_env BYMOPSTAG
_update_env BYNTDSTAG
_update_env DEMOSTAG
_update_env F7STAG
_update_env GTSSTAG
_update_env HKILFSTAG
_update_env HKRUSTAG
_update_env KGGSTAG
_update_env MCSTAG
_update_env MCCSTAG
_update_env MGMSTAG
_update_env MTSTAG
_update_env SUNSTAG
_update_env TASTAG
_update_env TKLSTAG
_update_env TTLSTAG
_update_env ZIPSTAG
# _update_env ZKTSTAG
_update_env ZUNISTAG


# Activate main window
tmux select-window -t 'k8s_stag:GTSSTAG'
tmux -u attach-session -t k8s_stag
