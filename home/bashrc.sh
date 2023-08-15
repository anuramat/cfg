#!/usr/bin/env bash

bind 'set bell-style none' # Disable annoying sound
shopt -s globstar          # TODO write down desc

. "${HOME}/.profile"                 # basic env vars
. "${XDG_CONFIG_HOME}/bash/utils.sh" # helper functions
. "${XDG_CONFIG_HOME}/bash/opts.sh"  # options for external tools
. "${XDG_CONFIG_HOME}/bash/aliases.sh"
. "${XDG_CONFIG_HOME}/bash/prompt.sh"

# ~~~~~~~~~~~~~~~~~~~~~~~~ conda ~~~~~~~~~~~~~~~~~~~~~~~~ #
__base="${HOMEBREW_PREFIX}/Caskroom/miniforge/base"
if __conda_setup="$("${__base}/bin/conda" "shell.bash" "hook" 2>/dev/null)"; then
	eval "${__conda_setup}"
elif [ -r "${__base}/etc/profile.d/conda.sh" ]; then
	. "${__base}/etc/profile.d/conda.sh"
else
	export PATH="${__base}/bin${PATH:+:${PATH}}"
fi
unset __base
unset __conda_setup
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
cmp="${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" && [ -r "${cmp}" ] && . "${cmp}" && unset cmp
fzfpath="${HOME}/.fzf.bash" && [ -r "${fzfpath}" ] && . "${fzfpath}" && unset fzfpath
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j --hook pwd)"
# blesh_path="${XDG_DATA_HOME}/blesh/ble.sh" && [ -r "${blesh_path}" ] && . "${blesh_path}" && unset blesh_path
