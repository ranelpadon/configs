# Dependencies:
# 1. https://github.com/sharkdp/fd
# 2. https://github.com/chmln/sd
# Run as (new Alacritty window or in Kitty):
# kube_test 123 (for RC123)
# since $TAG is needed envvar.


# Tabs
tmux new-session -s k8s_test -d

_new_window() {
    tmux new-window  -t k8s_test -n $1 -e WHITELABEL=$2
}


_new_window ATLTEST asiaticketing
_new_window MCTEST melco
_new_window TTLTEST totalticketing


# Helper function.
_update_env() {
    COMMAND='
        open "https://git.hk.asiaticketing.com/ticketflap/whitelabels/$WHITELABEL/-/pipelines"
        cd ~/dev/$WHITELABEL
        gc main
        gpl
        fd --regex "gitlab-ci(.(test|develop).*)?.yml" --hidden \
            | xargs sd "ets-test-v3.0.[^\s]+" "ets-test-v3.0.$TAG"
        gd
    '
    tmux send-keys -t k8s_test:$1 $COMMAND Enter
}

# Auto-runs
_update_env ATLTEST
_update_env MCTEST
_update_env TTLTEST


# Activate main window
tmux select-window -t 'k8s_test:ATLTEST'
tmux -u attach-session -t k8s_test
