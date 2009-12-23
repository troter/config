# -*- coding: utf-8; mode: sh; -*-

# svn status filter
function sst() {
    local arg
    if [ $# = 0 ]; then
        svn st
        return 1
    fi
    case $1 in
        "?") arg='^\?';;
        *) arg="^$1" ;;
    esac
    svn st | grep $arg | tr -d $arg | sed 's/[ ]*//' | sed 's/[ ]/\\ /g'
}
