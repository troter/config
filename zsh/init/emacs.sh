# -*- coding: utf-8; mode: sh; -*-
# emacs
function carbonemacs_setup() {
    local emacs_app_base="/Applications/Emacs.app"
    if [ -d "${emacs_app_base}" ]; then
       alias carbonemacs="${emacs_app_base}/Contents/MacOS/Emacs"
       alias e="carbonemacs"
    fi
}
carbonemacs_setup; unset -f carbonemacs_setup
