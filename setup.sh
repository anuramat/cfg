#!/usr/bin/env bash
set -e

. ./lib/utils.sh
. ./home/profile.sh

./bin/install/configs.sh
./bin/install/pkgs.sh
./bin/install/prefs.sh
./bin/install/iterm_prefs.sh

ensure_string "hehe" "${HOME}/.hushlogin" # Suppress login message

# Make bash the default shell
[ "${SHELL}" != "${HOMEBREW_PREFIX}/bin/bash" ] && {
	continue_prompt "Change shell to bash?" && {
		set_shell "${HOMEBREW_PREFIX}/bin/bash"
	}
}

# Install fzf shell integration
[ -f "${HOME}/.fzf.bash" ] || {
	continue_prompt "Install fzf integration?" && {
		"${HOMEBREW_PREFIX}/opt/fzf/install"
	}
}
