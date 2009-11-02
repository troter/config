# -*- coding: utf-8; mode: zsh; indent-tabs: nil -*-
# user generic .zshrc file for zsh(1).
# ====================================

# Default shell configuration.
# ============================

# Misc.
# -----
umask 022
ulimit -c 0

# Misc Options.
# -------------
setopt auto_cd # auto change directory
#setopt auto_pushd # auto directory pushd that you can get dirs list by ce -[tab]
setopt pushd_ignore_dups # don't push multiple copies of same directory
setopt correct # command correct edition before each completion attempt
setopt list_packed # compacked complete list display
setopt noautoremoveslash # no remove postfix slash of command line
setopt nolistbeep # no beep sound when complete list displayed
setopt nopromptcr # print last line without linefeed(\n)

# Keybind configuration.
# ----------------------
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
[[ $EMACS = t ]] && unsetopt zle

# Prompt configuration.
# ---------------------
# |[user@host:pwd(shlvl)]                      |
# |%                              [date:number]|
# |command is correct? [n,y,a,e]:              |
setopt prompt_subst
function prompt_setup() {
    autoload -U colors; colors
    local c_reset='%{${reset_color}%}'
    local c_black='%{${fg[black]}%}'
    local c_red='%{${fg[red]}%}'
    local c_green='%{${fg[green]}%}'
    local c_yellow='%{${fg[yellow]}%}'
    local c_blue='%{${fg[blue]}%}'
    local c_magenta='%{${fg[magenta]}%}'
    local c_cyan='%{${fg[cyan]}%}'
    local c_white='%{${fg[white]}%}'

    local c_prompt=$c_green
    local c_user=$c_green
    if [[ ${UID} = 0 ]] { c_user=$c_red }

    local shlevel="(\${SHLVL})"
    if [[ ${SHLVL} < 2 ]] { shlevel='' }

    PROMPT="[${c_user}%n${c_reset}@${c_green}%m${c_reset}:${c_cyan}%~${c_reset}${shlevel}]
${c_prompt}%#${c_reset} "
    PROMPT2="${c_prompt}%_>${c_reset} "
    RPROMPT="[%h]"
    SPROMPT="${c_magenta}%r is correct? [n,y,a,e]:${c_reset} "
}
prompt_setup; unset -f prompt_setup

# Command history configuration.
# ------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# Completion configuration.
# -------------------------
fpath=(~/.zsh/functions/Completion ${fpath}) # user define completion files
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -U compinit; compinit -u

# Prediction configuration
#autoload predict-on
#predict-off


# Others.
# =======
autoload zed # zsh editor


# Alias configuration.
# ====================
# expand aliases before completing
setopt complete_aliases     # aliased ls needs if file/dir completions work

# Global alias.
# -------------
alias -g H="| head"
alias -g T="| tail"
alias -g G="| grep"
alias -g L="| \$PAGER"
alias -g W="w3m -T text/html"
alias -g S="| sed"
alias -g A="| awk"

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

# Common alias.
# -------------
alias where="command -v"
alias j="jobs -l"

alias l="ls -F"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias cp="nocorrect cp -i"
alias rm="rm -i"
alias m="make"

alias s="svn"
alias g="git"
alias gs="git svn"

# update commands
case "${OSTYPE}" in
darwin*)
    alias updateports="sudo port selfupdate; sudo port outdated"
    alias portupgrade="sudo port upgrade installed"
    alias portsearch="sudo port search"
    ;;
esac

# emacs
function carbonemacs_setup() {
    local emacs_app_base="/Applications/Emacs.app"
    if [ -d "${emacs_app_base}" ]; then
       alias carbonemacs="${emacs_app_base}/Contents/MacOS/Emacs"
       alias e="carbonemacs"
    fi
}
carbonemacs_setup; unset -f carbonemacs_setup


# Environment variables setting.
# ==============================
if [[ "${TERM}" == (xterm*) ]] { TERM=xterm-color; }
if [[ "${TERM}" == (kterm*) ]] { TERM=kterm-color; }
if [[ "${TERM}" == (rxvt*)  ]] { TERM=rxvt-color;  }
#if [[ "${OSTYPE}" == (cygwin*) ]] { TERM=cygwin;  }
export TERM

#screen -q -X version;
#if [ "$?" = "0" ]; then
if [ "$SCREEN" = "t" ]; then
    chpwd () { echo -n "_`dirs`\\" }
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 )); then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*)
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd == 2)); then
                cmd[1]=$cmd[2]
                fi
                ;;
            *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
            echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    chpwd
fi

# pager
if which less &>/dev/null; then PAGER=less; fi
if which lv &>/dev/null;   then PAGER=lv;   fi
export PAGER
export LESS='-dMr'
export LV='-c'

# grep
export GREP_OPTIONS='--color=auto --exclude=.svn --exclude="*~"'

# Load user .zshrc configuration file.
# ====================================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# __END__
