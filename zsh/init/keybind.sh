# -*- coding: utf-8; mode: sh; -*-
# Keybind configuration.
# ----------------------
function keybind_configuration() {
    bindkey -e
    # historical backward/forward search with linehead string binded to ^P/^N
    autoload history-search-end
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end
    bindkey "^P" history-beginning-search-backward-end
    bindkey "^N" history-beginning-search-forward-end
    [[ $EMACS = t ]] && unsetopt zle
}
keybind_configuration; unset -f keybind_configuration
