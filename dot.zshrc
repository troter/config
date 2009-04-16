# -*- coding:utf-8; mode:sh -*-
# user generic .zshrc file for zsh(1).
# ====================================

# Default shell configuration.
# ============================

# Misc.
# -----
umask 022
ulimit -c 0

# Keybind configuration.
# ----------------------
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


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
    RPROMPT="[`date '+%y/%m/%d %H:%M:%S'`${c_cyan}:${c_reset}%h]"
    SPROMPT="${c_magenta}%r is correct? [n,y,a,e]:${c_reset} "
}
prompt_setup
unset -f prompt_setup


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
setopt nopromptcr # print last line without linefeed(\n)


# Completion configuration.
# -------------------------
fpath=(~/.zsh/functions/Completion ${fpath})
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -U compinit; compinit -u

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
if [[ "${OSTYPE}" == (freebsd*|darwin*) ]] { alias ls="ls -G -w" }
if [[ "${OSTYPE}" == (linux*)           ]] { alias ls="ls --color=auto"; }
if [[ "${OSTYPE}" == (cygwin*)          ]] { alias ls='ls -F --show-control-chars --color=auto' }

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
#    zstyle ':completion:*' list-colors \
#        'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory.
# -----------------------------------------------
case "${TERM}" in
kterm*|xterm*)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors \
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
