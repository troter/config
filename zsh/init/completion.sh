# -*- coding: utf-8; mode: sh; -*-
# Completion configuration.
# -------------------------
function completion_configuration() {
    fpath=(~/etc/config/zsh/functions/Completion ${fpath}) # user define completion files
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    autoload -U compinit; compinit -u

    # Prediction configuration
    #autoload predict-on
    #predict-off
}
completion_configuration; unset -f completion_configuration
