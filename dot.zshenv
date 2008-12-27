# -*- mode:sh -*-
# user generic .zshenv file for zsh(1).
# =====================================

# LANG.
# =====
export LANG=ja_JP.UTF-8

# PATH, MANPATH, INFOPATH, LD_LIBRARY_PATH.
# =========================================
if [ "${PATH/$HOME/}" = "$PATH" ] ; then # if $HOME/bin is not in $PATH ...
  # for MacPorts
  if [ -d "/opt/local" ]; then
    for i in /opt/local/{bin,sbin}; do
      if [ -d "$i" ]; then PATH="$i:$PATH"; fi
    done
    if [ -d "/opt/local/share/man" ]; then
      MANPATH="/opt/local/share/man:$MANPATH"
    fi
    if [ -d "/opt/local/share/info" ]; then
      INFOPATH="/opt/local/share/info:$MANPATH"
    fi
    if [ -d "/opt/local/lib" ]; then
      LD_LIBRARY_PATH="/opt/local/lib:$LD_LIBRARY_PATH"
    fi
  fi

  # for my own tools
  if [ -d "$HOME/bin" ]; then PATH="$HOME/bin:$PATH"; fi
  if [ -d "$HOME/man" ]; then MANPATH="$HOME/man:$MANPATH"; fi
  if [ -d "$HOME/share/man" ]; then MANPATH="$HOME/share/man:$MANPATH"; fi
  if [ -d "$HOME/info" ]; then INFOPATH="$HOME/info:$INFOPATH"; fi
fi
export PATH MANPATH INFOPATH LD_LIBRARY_PATH

# __END__