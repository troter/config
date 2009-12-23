# -*- coding: utf-8; mode: sh; -*-
# Prompt configuration.
# ---------------------
# |[user@host:pwd(shlvl)]                      |
# |%                                   [number]|
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
