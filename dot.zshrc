# -*- mode:sh -*-
# user generic .zshrc file for zsh(1).
# ====================================

# Default shell configuration.
# ============================

# Misc.
# -----
umask 077
ulimit -c 0

# Keybind configuration.
# ----------------------
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "¥¥ep" history-beginning-search-backward-end
bindkey "¥¥en" history-beginning-search-forward-end


# Prompt configuration.
# ---------------------
setopt prompt_subst
#unsetopt zle

autoload -U colors; colors
PROMPT_FG_CYAN='%{${fg[cyan]}%}'
PROMPT_FG_WHITE='%{${fg[white]}%}'
PROMPT_COLOR_RESET='%{${reset_color}%}'
PROMPT="%#"

case ${UID} in
0) # root
    PROMPT="%B${WINDOW:+"[$WINDOW]"}${PROMPT_FG_CYAN}${PROMPT}${PROMPT_COLOR_RESET}%b "
    PROMPT2="%B${PROMPT_FG_CYAN}%_%#${PROMPT_COLOR_RESET}%b "
    RPROMPT="%B${PROMPT_FG_WHITE}%~${PROMPT_FG_CYAN}:${PROMPT_FG_WHITE}%!${PROMPT_COLOR_RESET}%b"
    SPROMPT="%B${PROMPT_FG_CYAN}%r is correct? [n,y,a,e]:${PROMPT_FG_RESET}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="${PROMPT_FG_CYAN}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
*) # others
    PROMPT="${WINDOW:+"[$WINDOW]"}${PROMPT_FG_CYAN}${PROMPT}${PROMPT_COLOR_RESET} "
    PROMPT2="${PROMPT_FG_CYAN}%_%#${PROMPT_COLOR_RESET} "
    RPROMPT="${PROMPT_FG_WHITE}%~${PROMPT_FG_CYAN}:${PROMPT_FG_WHITE}%!${PROMPT_COLOR_RESET}"
    SPROMPT="${PROMPT_FG_CYAN}%r is correct? [n,y,a,e]:${PROMPT_COLOR_RESET} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="${PROMPT_FG_CYAN}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac


# Command history configuration.
# ------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


# Misc Options.
# -------------
setopt auto_cd # auto change directory
setopt auto_pushd # auto directory pushd that you can get dirs list by ce -[tab]
setopt correct # command correct edition before each completion attempt
setopt list_packed # compacked complete list display
setopt noautoremoveslash # no remove postfix slash of command line
setopt nolistbeep # no beep sound when complete list displayed
setopt nopromptcr # print last line without linefeed(¥n)


# Completion configuration.
# -------------------------
fpath=(~/.zsh/functions/Completion ${fpath})
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -U compinit; compinit

# Prediction configuration
#autoload predict-on
#predict-off


# Alias configuration.
# ====================
# expand aliases before completing
setopt complete_aliases     # aliased ls needs if file/dir completions work

# Global alias.
# -------------
alias -g H="| head"
alias -g T="| tail"
alias -g G="| grep"
alias -g L="| $PAGER"
alias -g W="w3m -T text/html"
alias -g S="| sed"
alias -g A="| awk"

# ls colors
case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color=auto"
    ;;
esac

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

# update commands
case "${OSTYPE}" in
darwin*)
    alias updateports="sudo port selfupdate; sudo port outdated"
    alias portupgrade="sudo port upgrade installed"
    alias portsearch="sudo port search"
    ;;
esac

# emacs
EMACS_APP_BASE="/Applications/Emacs.app"
if [ -d "$EMACS_APP_BASE" ]; then
   alias carbonemacs="${EMACS_APP_BASE}/Contents/MacOS/Emacs"
   alias ce="carbonemacs"
fi

# Terminal configuration
# ======================
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-color
    ;;
kterm)
    export TERM=kterm-color
    stty erase # set BackSpace control character
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors ¥
#        'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory.
# -----------------------------------------------
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo "${USER}@${HOST%%.*}:${PWD}"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors ¥
#        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac


# Others.
# =======
autoload zed # zsh editor


# Load user .zshrc configuration file.
# ====================================
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

# __END__
