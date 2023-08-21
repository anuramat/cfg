#!/usr/bin/env bash
# shellcheck disable=SC2250

bind 'set bell-style none' # Disable annoying sound
shopt -s globstar          # TODO write down desj

. "$HOME/.profile" # basic env vars

x="$XDG_CONFIG_HOME/bash"
. "$x/utils.sh" # helper functions
. "$x/opts.sh"  # options for external tools
. "$x/aliases.sh"
. "$x/prompt.sh"
[ -r "$x/private.sh" ] && . "$x/private.sh"
unset x

# ~~~~~~~~~~~~~~~~~~~~~~~~ conda ~~~~~~~~~~~~~~~~~~~~~~~~ #
b="$HOMEBREW_PREFIX/Caskroom/miniforge/base"
if cnd="$("$b/bin/conda" "shell.bash" "hook" 2>/dev/null)"; then
	eval "$cnd"
elif [ -r "$b/etc/profile.d/conda.sh" ]; then
	. "$b/etc/profile.d/conda.sh"
else
	export PATH="$b/bin${PATH:+:$PATH}"
fi
unset b
unset cnd
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
cmp="$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" && [ -r "$cmp" ] && . "$cmp" && unset cmp
fzfpath="$HOME/.fzf.bash" && [ -r "$fzfpath" ] && . "$fzfpath" && unset fzfpath
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j --hook pwd)"
# blesh_path="${XDG_DATA_HOME}/blesh/ble.sh" && [ -r "${blesh_path}" ] && . "${blesh_path}" && unset blesh_path
