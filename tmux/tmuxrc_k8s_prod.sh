# Dependencies:
# 1. https://github.com/sharkdp/fd
# 2. https://github.com/chmln/sd
# Run as (new Alacritty window or in Kitty):
# kube_prod 123 (for RC123)
# since $TAG is needed envvar.
# Deployment Template: https://git.hk.asiaticketing.com/technology/team/-/issues/281


# Tabs
tmux new-session -s k8s_prod -d

_new_window() {
    tmux new-window  -t k8s_prod -n $1 -e WHITELABEL=$2
}

_new_window BYMOPPROD bookyay-mop
_new_window BYPROD sun-entertainment  # SUNPROD
_new_window DEMOPROD demo
_new_window F7PROD f7
_new_window GTSPROD 11-skies
_new_window HKILFPROD hkilf
_new_window HKRUPROD hkru
_new_window KGGPROD kgg-kg
_new_window MGMPROD mgm
_new_window MTPROD matchtic
_new_window TTLPROD totalticketing
_new_window ZIPPROD zipcity
_new_window ZUNIPROD zuni


# Helper function.
_update_env() {

    # DevOps now triggers the PROD deployments.
    # open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/$WHITELABEL/-/pipelines"

    COMMAND='
        cd ~/dev/$WHITELABEL
        gc main
        gpl
    '

    if [ "$1" = "MGMPROD" ]
    then
        COMMAND+='
            fd --regex "gitlab-ci(.production-shared)?.yml" --hidden \
                | xargs sd "ets-prod-v1.8.47-RC[^\s]+" "ets-prod-v1.8.47-RC$TAG"
        '
    else
        COMMAND+='
            fd --regex "gitlab-ci(.prod.*)?.yml" --hidden \
                | xargs sd "ets-prod-v1.8.47-RC[^\s]+" "ets-prod-v1.8.47-RC$TAG"
        '
    fi

    COMMAND+='gd'

    tmux send-keys -t k8s_prod:$1 $COMMAND Enter
}

# Auto-runs
_update_env BYMOPPROD
_update_env BYPROD  # SUNPROD
_update_env DEMOPROD
_update_env F7PROD
_update_env GTSPROD
_update_env HKILFPROD
_update_env HKRUPROD
_update_env KGGPROD
_update_env MGMPROD
_update_env MTPROD
_update_env TTLPROD
_update_env ZIPPROD
_update_env ZUNIPROD


# Activate main window
tmux select-window -t 'k8s_prod:GTSPROD'
tmux -u attach-session -t k8s_prod
