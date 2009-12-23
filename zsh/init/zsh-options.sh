# -*- coding: utf-8; mode: sh; -*-
# Misc Options.
# -------------
function setup_options() {
    setopt auto_cd # auto change directory
    #setopt auto_pushd # auto directory pushd that you can get dirs list by ce -[tab]
    setopt pushd_ignore_dups # don't push multiple copies of same directory
    setopt correct # command correct edition before each completion attempt
    setopt list_packed # compacked complete list display
    setopt noautoremoveslash # no remove postfix slash of command line
    setopt nolistbeep # no beep sound when complete list displayed
    setopt nopromptcr # print last line without linefeed(\n)
    setopt auto_remove_slash
}
setup_options; unset -f setup_options
