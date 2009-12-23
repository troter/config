# -*- coding: utf-8; mode: sh; -*-
# Command history configuration.
# ------------------------------
function history_configuration() {
    HISTFILE=~/.zsh_history
    HISTSIZE=1000000
    SAVEHIST=1000000
    setopt hist_ignore_dups     # ignore duplication command history list
    setopt share_history        # share command history data
}
history_configuration; unset -f history_configuration
