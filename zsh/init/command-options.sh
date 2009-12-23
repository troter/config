# -*- coding: utf-8; mode: sh; -*-

# pager
if which less &>/dev/null; then PAGER=less; fi
if which lv &>/dev/null;   then PAGER=lv;   fi
export PAGER
export LESS='-dMr'
export LV='-c'

# grep
export GREP_OPTIONS='--color=auto --exclude=.svn --exclude="*~"'

# ls colors
case "${OSTYPE}" in
freebsd*|darwin*)
    export LSCOLORS='exfxcxdxbxegedabagacad'
    alias ls="ls -G -w"
    ;;
linux*)
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    # ad-hoc
    if [[ `ls --version | head -n 1 | awk '{print $3}'` = (5.2*) ]] {
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:'
    }
    alias ls="ls --color=auto"
    ;;
cygwin*)
    alias ls='ls -F --show-control-chars --color=auto'
    ;;
esac
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

