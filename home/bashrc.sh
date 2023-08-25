#!/usr/bin/env bash

bind 'set bell-style none' # Disable annoying sound
shopt -s globstar          # Enables ** for recursing into subdirectories

. "$HOME/.profile" # basic env vars

rclib="$XDG_CONFIG_HOME/bash"
. "$rclib/utils.sh" # helper functions
. "$rclib/opts.sh"  # options for external tools
. "$rclib/aliases.sh"
. "$rclib/prompt.sh"
[ -r "$rclib/private.sh" ] && . "$rclib/private.sh"
unset rclib
# ~~~~~~~~~~~~~~~~~~~~~~~~ conda ~~~~~~~~~~~~~~~~~~~~~~~~ #
frgbse="$HOMEBREW_PREFIX/Caskroom/miniforge/base"
if cnd="$("$frgbse/bin/conda" "shell.bash" "hook" 2>/dev/null)"; then
	eval "$cnd"
elif [ -r "$frgbse/etc/profile.d/conda.sh" ]; then
	. "$frgbse/etc/profile.d/conda.sh"
else
	export PATH="$frgbse/bin${PATH:+:$PATH}"
fi
unset frgbse cnd
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
cmp="$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" && [ -r "$cmp" ] && . "$cmp" && unset cmp
fzfpath="$HOME/.fzf.bash" && [ -r "$fzfpath" ] && . "$fzfpath" && unset fzfpath
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j --hook pwd)"
