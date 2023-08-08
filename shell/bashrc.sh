#!/usr/bin/env bash
# start blesh init
[[ $- == *i* ]] && source "$XDG_DATA_HOME/blesh/ble.sh" --noattach

bind 'set bell-style none'                     # disable annoying sound
eval "$(/opt/homebrew/bin/brew shellenv bash)" # brew env variables
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
default_exa="exa --group-directories-first --group --icons --header --git --color=always"
alias f="nvim"
alias ls="$default_exa"
alias ll="$default_exa --long"
alias la="$default_exa --long --all"
alias tree="$default_exa --tree"
alias bathelp="bat --plain --language=help"
alias conv="plutil -convert xml1"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
__overprompt() {
	local -r status=$?
	echo                       # Separate command-output blocks
	echo -n " "                # Offset
	echo -n "${PWD/#$HOME/\~}" # Current working directory, with tilde abbreviation
	# Git branch/commit hash, if any
	if git rev-parse --git-dir >/dev/null 2>&1; then
		local branch
		branch=$(git branch --show-current)
		[ -z "$branch" ] && branch="($(git rev-parse --short HEAD))"
		echo -n " ($branch)"
	fi
	# Return code, if non-zero
	[ "$status" -ne 0 ] && echo -n " [$status]"
}
PS1='$(__overprompt)\n '
PS2='│'
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ E(x)ternal bloat ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Zoxide
# TODO add zoxide-fzf options
export _ZO_RESOLVE_SYMLINKS="1"
# Fzf integration
[ -f ~/.fzf.bash ] && . "$HOME/.fzf.bash"
# Fzf
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'tree {}'"
# Exa
export EXA_COLORS="uu=36:gu=37:sn=32:sb=32:da=34:ur=34:uw=35:ux=36:ue=36:gr=34:gw=35:gx=36:tr=34:tw=35:tx=36"
# Zoxide
eval "$(zoxide init bash --cmd j)"
# Conda
if __conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"; then
	eval "$__conda_setup"
else
	if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
		. "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
	else
		export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
	fi
fi
unset __conda_setup

[[ ${BLE_VERSION-} ]] && ble-attach
