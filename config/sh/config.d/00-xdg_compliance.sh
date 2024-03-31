#!/usr/bin/env sh
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history" # node.js
export GOPATH="$XDG_DATA_HOME/go"
export STACK_ROOT="$XDG_DATA_HOME"/stack # Haskell stack (old)
export STACK_XDG=1                       # Haskel stack (new variable, any non empty value will do)
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg # ??? I didn't install this...
export HISTFILE="${XDG_STATE_HOME}"/bash/history
# mkdir -p "$(dirname "$HISTFILE")" || true # TODO manually create some of these
export XCOMPOSECACHE="${XDG_CACHE_HOME}"/X11/xcompose # not using this either AFAIK
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss    # VLC dependency
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer # I don't use this but somehow ended up with this in my $HOME anyway
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export W3M_DIR="$XDG_DATA_HOME/w3m" # terminal web browser
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
# __pycache__ folder
export PYTHONPYCACHEPREFIX="/tmp/pycache"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
# NOTE .pyhistory is still hardcoded: https://github.com/python/cpython/pull/13208
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
