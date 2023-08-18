#!/usr/bin/env bash
. ./lib/utils.sh
. ./home/profile.sh
./bin/configs.sh
./bin/pkgs.sh
./bin/prefs.sh
./bin/iterm_prefs.sh
ensure_string "hehe" "${HOME}/.hushlogin"            # Suppress login message
[ "${SHELL}" != "${HOMEBREW_PREFIX}/bin/bash" ] && { # Make bash the default shell
	continue_prompt "Change shell to bash?" && {
		set_shell "${HOMEBREW_PREFIX}/bin/bash"
	}
}
[ -f "${HOME}/.fzf.bash" ] || { # Install fzf shell integration
	continue_prompt "Install fzf integration?" && {
		"${HOMEBREW_PREFIX}/opt/fzf/install"
	}
}
