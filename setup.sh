#!/usr/bin/env bash
set -e

. ./lib/utils.sh
. ./home/profile.sh

! command -v brew >/dev/null && continue_prompt "Homebrew binary not found, install?" && {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew analytics off
}

echo "[cfg] installing executables and GUI apps" && ./bin/install/pkgs.sh -g "go-binaries.txt"
echo "[cfg] installing configs" && ./bin/install/configs.sh
echo "[cfg] setting up macOS system preferences" && ./bin/install/prefs.sh
echo "[cfg] setting up iTerm2" && ./bin/install/iterm_prefs.sh

ensure_string "hehe" "${HOME}/.hushlogin"

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
